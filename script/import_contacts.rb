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
    @dry_run = false
    @import_title = 'ESC 2012'
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
    CsvToHash.parse_file(file) do |row_hash|
      # puts row_hash.inspect
      @name = get_name(row_hash)
      @email = row_hash['EMail'] || ''
      if @email.present?
        with_retries do
          Mailchimper.new.subscribe(:name => @name, :email => @email) unless @dry_run
        end
        log "Mailchimp subscribed #{@name} #{@email}"
      end
      with_retries do
        add_lighthouse_ticket(row_hash)
      end
    end
    true
  end

  def get_name(row_hash)
    first_name = row_hash['FirstName'] || ''
    last_name = row_hash['LastName'] || ''
    (first_name + ' ' + last_name).strip
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

  def add_lighthouse_ticket(row_hash)
    ticket = Lighthouse::Ticket.new(:project_id => CompanyConfig.lighthouse_sales_leads_id)
    ticket.title = "#{@name}, #{@email} - #{@import_title}"
    body = []
    body.push "**From:**  #{@name} #{@email}<br />"
    if (date = row_hash['ScanDate']).present?
      body.push "**Date:** #{date}<br />"
    end
    if (company = row_hash['Company']).present?
      body.push "**Company:** #{company}<br />"
    end
    if (phone = row_hash['Phone1'] || row_hash['Phone2']).present?
      body.push "**Phone:** #{phone}<br />"
    end
    m2mhub_link = M2mhubLink.new( :name => @name,
                                  :email => @email,
                                  :company => company,
                                  :phone => phone )
    body.push "[Create New Customer On M2MHub](#{m2mhub_link.to_url})"
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
    log "lighthouse ticket: #{ticket.title}"
    # log "lighthouse ticket body #{ticket.body}"
  end
end

exit ImportContacts.new.run(ARGV)
