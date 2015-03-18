fs = require("fs")
path = require("path")
templatesDir = path.join(__dirname, "/app/templates/email/")
nodemailer = require("nodemailer")
config = require("./email_secrets")

# Prepare nodemailer transport object
transporter = nodemailer.createTransport(
  config.nodemailer
)

# SEND A SINGLE EMAIL
html = fs.readFileSync "#{__dirname}/campaign/edm/saul.html", "utf8"
text = fs.readFileSync "#{templatesDir}ink/text.md", "utf8"

transporter.sendMail
  from: "#{config.sender.name.first} <#{config.sender.email}>"
  to: [
    name: "#{config.recipient.name.first} #{config.recipient.name.last}"
    address: config.recipient.email
  ]
  subject: config.subject
  html: html
  attachments: [
      filename: "better-call-saul.jpg"
      path: "#{__dirname}/app/images/better-call-saul.jpg"
      cid: "unique@kreata.ee" # same cid value as in the html img src
  ]
  text: text
, (err, responseStatus) ->
  if err
    console.log err
  else
    console.log responseStatus.message
  return
