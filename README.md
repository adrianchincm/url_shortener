# Url shortener

#### Deployment and build
Deployed on Heroku at : https://accm-url-shortener.herokuapp.com/

This project is built on :  
Ruby 3.0.2  
Rails 6.1.4.1

#### Installation and running the app
1. Clone the repo
2. Run `rails db:migrate`
3. Run `rails webpacker:install`, when it asks if it should override files, select `n` for all files
4. Run `bin/webpack-dev-server` on another terminal
5. Finally, run `rails s`

#### Run tests
1. Run `rails test`

#### Frameworks used
1. StimulusJS
2. TailwindCSS
3. UI Components from [TailwindUI](https://tailwindui.com/), [wickedblocks](https://blocks.wickedtemplates.com/navigation), [kitwind.io](https://kitwind.io/) and icons from [flaticon](https://www.flaticon.com/)

#### Gems used
1. stimulus-rails
2. geocoder
3. httparty
4. nokogiri
