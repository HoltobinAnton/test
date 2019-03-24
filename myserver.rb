require_relative 'simple_mailer'
require 'net/http'

class MyServer
  def initialize
   @sites = [{url: 'https://pokupon.ua',         status: nil},
             {url: 'https://partner.pokupon.ua', status: nil}]
  end
  
  def main
  	loop do
	  @sites.each do |site|
	  	response = Net::HTTP.get_response(URI(site[:url])) 
	  	check_sites(response, site) if response.is_a?(Net::HTTPSuccess)
	  end
	  sleep(60)
	end
  end

  private
  
  def check_sites(response, site)
  	if response.code != '200' && response.code != site[:status]
	   mailer_job(response, site)  	  
  	elsif response.code == '200' && response.code != site[:status] &&
  	  site[:status]
  	   mailer_job(response, site)
  	end
  end

  def mailer_job(response, site)
  	site[:status] = response.code
  	SimpleMailer.new().send_mail(site[:url], response.code)
  end
end

MyServer.new.main()



