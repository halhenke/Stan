# README

## Built Using
- Jade
- Coffeescript
- SASS
- Gulp
- live-server
- Tiny bit of Angular

## To send an email
- Setup/Configure
    - Copy your Gmail username and password (app specific) etc into the `email_secrets.config.coffee` file
    - rename the file to `email_secrets.coffee`
- Add a destination email etc to the same file
- Call `coffee nodeMailer.coffee` from the commnd line 
    - or `npm run sendMail`

## To build project and watch for changes
- `gulp`
    + or `npm run build`

## Simple Server
- If you have the `live-server` package installed globally
    + then `live-server campaign/page` from the app route will show the web page
        * or `npm run devServe`
