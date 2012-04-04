# Usage: rails runner ./script/import_contacts.rb path/to/file.csv
#
require 'csv_to_hash'
require 'm2mhub_link'
require 'mailchimper'
require 'with_retries'

class ImportContacts
  include WithRetries
  def run(args)
    file = args[0]
    @dry_run                = false
    @source                 = :YOUVEGOTLEADS
    @import_title           = 'You\'ve got leads'
    @add_to_lighthouse      = false
    @subscribe_to_mailchimp = true
    @create_greetings       = false
    @only_create_greetings  = false
    if @only_create_greetings
      @add_to_lighthouse = @subscribe_to_mailchimp = false
    end
    unless File.exists?(file)
      puts "Could not find #{file}"
      1
    else
      if import_file(file)
        0
      else
        1
      end
    end
  end

  def import_file(file)
    log "Loaded #{ImportHistory.instance.all_imports.size} histories"
    @mailchimper = Mailchimper.new
    csv_line_count = 0
    CsvToHash.parse_file(file, :downcase_keys => true) do |row_hash|
      csv_line_count += 1
      @current_row = SmartRow.new(@source, row_hash)
      # puts row_hash.inspect
      if @current_row.email.present?
        if @current_row.history.ignore?
          log "Ignoring #{@current_row.email}"
        else
          status = @mailchimper.status_for(@current_row.email)
          @current_row.history['mailchimp'] = status
          case status
          when :subscribed
            log "#{@current_row.name} #{@current_row.email} already subscribed"
            create_greeting(status)
          when :unsubscribed
            log "#{@current_row.name} #{@current_row.email} is unsubscribed"
          when :never_subscribed
            subscribe_to_mailchimp
            add_lighthouse_ticket
            create_greeting(status)
          else
            raise "Unknown mailchimper status: #{status}"
          end
        end
      end
    end
    log "Parsed #{csv_line_count} lines from #{file}"
    persist_greetings
    ImportHistory.instance.persist unless @dry_run
    true
  end

  def create_greeting(status)
    if @create_greetings
      log "Created greeting for #{@current_row.name}"
      @current_row.history['greeting'] = 'created'
    end
    return if @dry_run or !@create_greetings
    @greetings ||= []
    click_explanation = if @current_row.date
      "They tell us you clicked on one of our ads in there newsletter back on #{@current_row.date.to_s(:human_date)}."
    else
      "They tell us you clicked on one of our ads in their newsletter."
    end
    working_text = if @current_row.company.present?
      "#{@current_row.company} is working"
    else
      "you are working"
    end

    @greetings.push <<-TEXT
#{@current_row.website}
"#{@current_row.name}" <#{@current_row.email}>
Status: #{status}

Hey #{@current_row.first_name}. We received your contact info from SID (Information Display publication). #{click_explanation}

If #{working_text} on any products that use an LCD, I hope you'll let LXD compete for your business. We manufacture our LCDs in China and have engineering and support in the U.S..

If you don't remember clicking on any ads in the newsletter, no worries. I promise I will not keep bugging you. :-)

Let me know if there's any way we can help,

Tim Harrison
LXD Liquid Crystal Displays
www.lxdinc.com
(919) 600-6440
TEXT
  end

  def persist_greetings
    return if @dry_run or !@create_greetings or @greetings.nil?
    File.open( File.join(Rails.root, 'imports', 'import_greetings.txt'), 'a' ) do |out|
      out.puts "\n****************************************************************\n\n"
      out.puts "#{Time.now.strftime('%I:%M%p %m-%d-%y')}"
      out.puts @greetings.join("\n-----------------------------\n")
    end
  end

  def log(txt)
    if @dry_run
      txt = "Dry run: #{txt}"
    end
    puts txt
  end

  def log_error(txt)
    log(txt)
  end

  def subscribe_to_mailchimp
    return if @dry_run or !@subscribe_to_mailchimp
    if @mailchimper.subscribe(:name => @current_row.name, :email => @current_row.email, :enabled => true)
      log "Mailchimp subscribed #{@current_row.name} #{@current_row.email}" unless !@subscribe_to_mailchimp
      @current_row.history['mailchimp'] = 'subscribed'
    else
      raise 'mailchimp failed'
    end
  end

  def add_lighthouse_ticket
    log "lighthouse ticket: #{ticket.title}" unless !@add_to_lighthouse
    return if @dry_run or !@add_to_lighthouse
    with_retries do
      ticket = Lighthouse::Ticket.new(:project_id => CompanyConfig.lighthouse_sales_leads_id)
      ticket.title = "#{@current_row.name}, #{@current_row.email} - #{@import_title}"
      body = []
      body.push "**From:**  #{@current_row.name} #{@current_row.email}<br />"
      body.push "**Date:** #{@current_row.date}<br />" if @current_row.date.present?
      body.push "**Company:** #{@current_row.company}<br />" if @current_row.company.present?
      body.push "**Phone:** #{@current_row.phone}<br />" if @current_row.phone.present?
      body.push "[Create New Customer On M2MHub](#{@current_row.m2mhub_link.to_url})"
      body.push "\n"
      row_hash.each do |key, value|
        if value.present?
          body.push "#{key} = " + value
        end
      end
      ticket.body = body.join("\n")
      if !Rails.env.production? and CompanyConfig.lighthouse_test_user_id
        ticket.attributes['assigned_user_id'] = AppConfig.lighthouse_test_user_id
      end
      ticket.save unless @dry_run
      @current_row.history['lighthouse'] = ticket.id
      # log "lighthouse ticket body #{ticket.body}"
    end
  end
end

class SmartRow
  CONFIG={
    :defaults => {
      :first_name => 'firstname',
      :last_name => 'lastname',
      :email => 'email',
      :company => 'company',
      :phone => 'phone',
      :website => 'website'
    },
    :YOUVEGOTLEADS => {
      :date => 'actionaate',
      :company => 'companyname'
    },
    :ESC => {
      :date => 'scandate',
      :phone => 'phone1'
    }
  }
  attr_accessor :history
  def initialize(source, row_hash)
    @source = source
    @row_hash = row_hash
    if self.email
      @history = ImportHistory.instance.ensure_history(self.email)
      @history['name'] = self.name
      @history['source'] = source
      @history['m2mhub_link'] = self.m2mhub_link.to_url
    end
  end
  
  def m2mhub_link
    @m2mhub_link ||= M2mhubLink.new( :name => self.name,
                                      :email => self.email,
                                     :company => self.company,
                                     :phone => self.phone )
  end

  def name
    (value(:first_name, '') + ' ' + value(:last_name, '')).strip
  end
  def website
    if (v = value(:website)).present?
      v
    elsif self.email.present?
      'www.' + self.email.split('@').last
    else
      nil
    end
  end
  def date
    if (v = value(:date))
      Date.parse(v)
    else
      nil
    end
  end
  def company
    if (v = value(:company)).present?
      v.titleize
    else
      nil
    end
  end
  def email
    @email ||= value(:email).try(:downcase)
  end

  def value(key,default_value=nil)
    key = key.to_sym
    result = if CONFIG[@source].member?(key)
      @row_hash[CONFIG[@source][key]]
    elsif CONFIG[:defaults].member?(key)
      @row_hash[CONFIG[:defaults][key]]
    end
    result || default_value
  end
  def respond_to?(mid)
    mid = mid.to_sym
    CONFIG[@source].member?(mid) || CONFIG[:defaults].member?(mid)
  end

  def method_missing(mid, *args)
    if self.respond_to?(mid)
      value(mid)
    else
      super
    end
  end
end

class ImportHistory
  include Singleton

  class LeadHistory
    attr_accessor :config
    def initialize(config)
      @config = config
    end
    def ignore?
      (v = @config['ignore']).present? && !v.is_a?(FalseClass)
    end
    def email
      @config['email']
    end
    def []=(key,value)
      @config[key] = value.to_s
    end
  end

  def initialize
    @history_file = File.join(Rails.root, 'imports/history.yml')
  end

  def all_imports
    if @all_imports.nil?
      @all_imports = if File.exists?(@history_file)
        if (file_contents = IO.read(@history_file)).present? and (content = YAML::load(file_contents))
          @all_imports = content.map { |c| LeadHistory.new(c) }
        end
      end
      @all_imports ||= []
    end
    @all_imports
  end

  def email_to_import_history
    if @email_to_import_history.nil?
      @email_to_import_history = {}
      self.all_imports.each do |history|
        @email_to_import_history[history.email] = history
      end
    end
    @email_to_import_history
  end

  def ensure_history(email)
    return nil if @dry_run
    history = self.email_to_import_history[email]
    unless history
      history = LeadHistory.new({'email' => email})
      self.all_imports.push(history)
      self.email_to_import_history[email] = history
    end
    history
  end

  def persist
    File.open(@history_file, 'w+' ) do |out|
      YAML.dump(self.all_imports.map(&:config), out)
    end
  end

end

exit ImportContacts.new.run(ARGV)
