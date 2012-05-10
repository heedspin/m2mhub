# Cronhint:
# 00 2 * * * /var/www/lxd_m2mhub/current/script/runner.sh 'LighthouseWakeup.new.run_in_background!'

require 'logger_utils'
class LighthouseWakeup
  include LoggerUtils
  def run
    Lighthouse::Project.all.each do |project|
      Lighthouse::Ticket.find(:all, :params => { :project_id => project.id, :q => "state:hold" }).each do |_ticket|
        ticket = Lighthouse::Ticket.find(_ticket.id, :params => { :project_id => project.id })
        ticket.versions.reverse.each do |comment|
          break if comment.body.include?('Wake Up Call!')
          if (comment.body =~ /wakeup: ?([\d\-\/]+)/i) and (wakeup_date = Date.parse($1))
            log "Project #{project.name}, Ticket #{ticket.title} wakeup call at #{wakeup_date}"
            if Date.current >= wakeup_date
              ticket.state = 'open'
              ticket.body = 'Wake Up Call!'
              ticket.save
            end
            break
          end
        end
      end
    end
    true
  end
  
  def run_in_background!
    self.send_later(:run)
  end
end