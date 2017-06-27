require 'plutolib/logger_utils'

class PdfGenerationError < StandardError; end

module PdfGeneration
  def render_pdf(options = nil, &block)
    options ||= {}
    begin
      filename = options.delete(:filename) || 'report_' + Time.now.to_i
      xml = render_to_string(options, &block)
      if Rails.env.development?
        # Log xml for debug purposes.
        File.open(File.join(Rails.root, 'log/last_pdf.xml'), 'w+') do |f|
          f.write(xml.encode('utf-8', 
                             invalid: :replace, 
                             undef: :replace,
                             replace: "?"))
        end
      end
      pdf = PdfGenerator.new(xml)
      if pdf.success
        send_file pdf.file.path
        headers['Content-type'] = 'application/pdf'
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      elsif Rails.env.development?
        render :text => '<pre>' + pdf.command_output + '</pre>',
          :layout => false,
          :content_type => 'text/html',
          :status => 500
      else
        raise PdfGenerator, pdf.command_output
      end
    end
  end
end

class PdfGenerator
  require 'net/http'
  require 'uri'
  include Plutolib::LoggerUtils

  attr_accessor :file, :success, :command_output

  def initialize(xml)
    tempfile = Tempfile.new('pdfgenerator_')
    tempfile.print(xml.encode('utf-8', 
                             invalid: :replace, 
                             undef: :replace,
                             replace: "?"))
    tempfile.close
    source = tempfile.path + '.html'
    logfile = tempfile.path + '.log'
    FileUtils.mv tempfile.path, source
    destination = tempfile.path + '.pdf'
    command = "#{AppConfig.prince_location} -v -s #{M2mhub::Engine.root}/app/views/shipping/backlog_reports/prince.css --log #{logfile} #{source} -o #{destination}"
    log "Prince command: #{command}"
    `#{command}`
    status = $?
    self.success = (status.to_i == 0)
    File.open(logfile) do |input|
      self.command_output = input.read
    end
    if self.success
      log "Prince success: #{self.command_output}"
      @file = File.new(destination)
    else
      log "Prince error: #{status}: #{self.command_output}"
    end
    FileUtils.rm source
  end
  
end
