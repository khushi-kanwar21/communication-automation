#!/bin/bash

send_email() {
    echo "Enter your Gmail address:"
    read from_email
    echo "Enter recipient email:"
    read to_email
    echo "Enter your Gmail app password:"
    read -s password
    echo "Enter subject:"
    read subject
    echo "Enter message:"
    read message

    python3 - <<END
import yagmail
yag = yagmail.SMTP(user="${from_email}", password="${password}")
yag.send(to="${to_email}", subject="${subject}", contents="${message}")
print("✅ Email sent successfully!")
END
}

send_sms() {
    echo "Enter your Twilio SID:"
    read sid
    echo "Enter your Twilio Auth Token:"
    read -s token
    echo "Enter your Twilio phone number (e.g., +1415xxxxxxx):"
    read from_number
    echo "Enter recipient phone number (e.g., +91xxxxxxxxxx):"
    read to_number
    echo "Enter message:"
    read message

    python3 - <<END
from twilio.rest import Client
client = Client("${sid}", "${token}")
message = client.messages.create(
    body="${message}",
    from_="${from_number}",
    to="${to_number}"
)
print("✅ SMS sent successfully!")
END
}

send_whatsapp() {
    echo "Enter your Twilio SID:"
    read sid
    echo "Enter your Twilio Auth Token:"
    read -s token
    echo "Enter your Twilio WhatsApp number (e.g., whatsapp:+1415xxxxxxx):"
    read from_number
    echo "Enter recipient WhatsApp number (e.g., whatsapp:+91xxxxxxxxxx):"
    read to_number
    echo "Enter message:"
    read message

    python3 - <<END
from twilio.rest import Client
client = Client("${sid}", "${token}")
message = client.messages.create(
    body="${message}",
    from_="${from_number}",
    to="${to_number}"
)
print("✅ WhatsApp message sent successfully!")
END
}

while true; do
    echo ""
    echo "=== Communication Menu ==="
    echo "1. Send Email"
    echo "2. Send SMS"
    echo "3. Send WhatsApp Message"
    echo "4. Exit"
    echo "=========================="
    read -p "Enter your choice: " choice

    case $choice in
        1) send_email ;;
        2) send_sms ;;
        3) send_whatsapp ;;
        4) echo "Goodbye!"; exit ;;
        *) echo "Invalid option!" ;;
    esac
done
