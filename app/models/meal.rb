class Meal < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant


  def send_text
    client_number = "7578488208"

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    @twilio_client.account.sms.messages.create(
     from: "+1#{twilio_phone_number}",
     to: client_number,
     body: "Please work"
    )
  end

  def send_call(phone)
    client_number = phone

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    @twilio_client.account.calls.create({
     from: "+1#{twilio_phone_number}",
     to: client_number,
     url: "http://app.elevatemealplan.com/meals/call.xml",
     :method => 'GET',
  	 :fallback_method => 'GET',
  	 :status_callback_method => 'GET',
  	 :record => 'false'
    })
  end


end
