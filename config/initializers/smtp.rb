
# ActionMailer::Base.smtp_settings = {
#   address: "smtp.gmail.com",
#   port: "587",
#   enable_starttls_auto: true,
#   authentication: "plain",
#   user_name: ENV["EMAIL_USERNAME"],
#   password: ENV["EMAIL_PASSWORD"]
# }

# google requires your gmail that is connected to smtp to have "less secure app access toggled off" in order to send mail
# find the setting here https://myaccount.google.com/lesssecureapps
# if you have 2-factor authentication you'd need to do more work...
# if you're using :sendmail then you want this commented out