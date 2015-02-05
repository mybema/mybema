0.4.0
-----

- New design for the discussions listing pages
- fix admins responding when guest posting is disabled
- Start embracing the full power of SASS
- Decorate articles
- Add spectrum.js colorpicker to admin section
- Users can now add bios to their profiles
- Add case-insensitive username validation
- Update to Rails 4.2
- Add subscription model and add email notifications
- Fix hero cookie permanence
- Fix IE and flexbox layout issues

0.3.5
-----

- Allow logo uploading
- Header CSS can be customized via the admin section
- Fix typeahead bug
- Each community can now customize its HTML title element
- merge request from @firstrow
- Add auto_link to articles
- CSS tweaks

0.3.4
-----

- Move email configuration back to MybemaDeviseMailer
- Add LGPL 3.0 license
- Add hero image and excerpt to articles
- Introduce pretty article layouts
- Add draper gem and decorate articles

0.3.3
-----

- Change smtp settings in MybemaDeviseMailer to class methods

0.3.2
-----

- Change default domain address for AppSettings

0.3.1
-----

- Critical MybemaDeviseMailer bugfix

0.3.0
-----

- Bugfix for mailers

0.2.9
-----

- Send out welcome mailer when new users register
- Allow admins to configure SMTP settings

0.2.8
-----

- Allow admins to upload their own avatars

0.2.7
-----

- Rename answers to articles
- CSS tweaks
- Fix styling of Devise pages

0.2.6
-----

- Add emoji support
- Use Google Analytics only in production
- Move user_is_guest() methods to a concern
- Fix search for opera mini users

0.2.5
-----

- Fix typeahead discussions to link to slug not ID

0.2.4
-----

- Add discussions stylesheet

0.2.3
-----

- Style fix
- Make discussion titles unique

0.2.2
-----

- Add code highlighting CSS

0.2.1
-----

- CSS bugfix for flash notice
- Add search helper for results paths

0.2.0
-----

- CSS style changes for answers section

0.1.9
-----

- Add IE8 CSS compatibility fixes

0.1.8
-----

- Add rails-autoprefixer
- Add reset.css
- Fix some cross-browser styling issues

0.1.7
-----

- Remove the hero html_safe and add auto_link instead
- Add auto_link gem
- Also add auto_link to discussions and comments

0.1.6
-----

- Make the hero message html safe

0.1.5
-----

- Move GA JavaScript out of the asset pipeline

0.1.4
-----

- Change AppSetting defaults to empty strings not nil

0.1.3
-----

- Add Google Analytics tracking configuration
- Fix admin avatar for discussion comments
- Add Sitemap generator
- Add whenever for cron jobs
- Add domain address URL configuration for sitemap creation
- Sluggify discussion titles
- Prettify discussion URLs with slugs