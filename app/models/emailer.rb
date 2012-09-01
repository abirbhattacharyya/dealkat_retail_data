class Emailer < ActionMailer::Base
  default_url_options[:host] = "www.dealkat.info:3000"
  
  def sendto(recipient,id,name,message,others='',sent_at = Time.now)
    @id = id
    @name = name
    @message = message
    
    subject    'Someone Sent you a valuable free information'
    recipients recipient
    bcc        others
    
    from       sender_email
    sent_on    sent_at
    content_type 'text/html'
  end

  def downloadto(recipient,others='',sent_at = Time.now)
    
    subject    'Your data file from DealKat is attached.'
    recipients recipient
    bcc        others
    
    from       sender_email
    sent_on    sent_at
    content_type    "text/html"
    body    "<p>Hey,here is your data file from DealKat.</p>
            <p></p>
            <p>Regards,</p>
            <p></p>
            <p>DealKat</p>"
    
    attachment :content_type => "text/comma-separated-values",:filename => "dealkat_data.csv",:body => File.read(RAILS_ROOT + "/products.csv")
    
  end

  protected
  def sender_email
      "\"Dealkat\" <dealkat@dealkat.info>"
  end

end
