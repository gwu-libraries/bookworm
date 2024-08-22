# README

test webhook trigger 1

## Production Setup

Requires Docker engine and docker compose. 

Quickstart:
- Make a copy of `.env.example` and rename it to `.env`
- In the `/rails` folder, run `bin/rails credentials:edit` to generate a Rails master key. Copy the resulting key string to RAILS_MASTER_KEY in your `.env` file. 
- Set POSTGRES_PASSWORD in the `.env` to a password that will be used for the database. 
- Generate an SSL key and certificate [(stackoverflow discussion here)](https://stackoverflow.com/questions/10175812/how-to-generate-a-self-signed-ssl-certificate-using-openssl) and place both files in `/nginx/certs`. They must be named `key.pem` and `certificate.pem`.
- In the main directory, run `docker compose build` to build the rails and react docker images.
- In the main directory, run `docker compose up` to start the containers. Once the NGINX container has started, the application should be visible on `[LOCALHOST-OR-YOUR-IP-ADDRESS]:80`

## Development Setup

The recommended development setup is to run the rails development server and the react npm development server independently.

Requires a working installation of Postgres, npm, and bundler, and Ruby 3.2.2.
- If you do not have a ruby version manager, I recommend `rbenv`. 
- If you do not have bundler installed, run `gem install bundler`
- For Postgres, follow the instructions in [config/database.yml](config/database.yml) if you see an error related to `pg` on running `bundle install`

### Rails Development

In the `/rails` folder, run `npm i` to install development dependencies. This repository uses [prettier](https://prettier.io/) and the [ruby-plugin](https://github.com/prettier/plugin-ruby) for code formatting. I recommend activating format-on-save ([https://www.digitalocean.com/community/tutorials/how-to-format-code-with-prettier-in-visual-studio-code](https://www.digitalocean.com/community/tutorials/how-to-format-code-with-prettier-in-visual-studio-code)).

In the `/rails` folder: 
- Run `bundle install` to install gems. 
- Run `rails db:create` to create the `development` and `test` databases. 
- Run `rails db:migrate` to migrate the `development` and `test` databases. 

To start the development server, run `rails s`. It should automatically start in development mode, but you can run `rails s -e development` if not. 

The `graphiql` user interface should now be available at `localhost:3001/graphiql`.

### React Development

In the `/react` folder:
- Run `npm install` to install node packages. 
- Run `npm run dev` to launch the Vite/React frontend in development mode.

### Automated Tests

This repository uses RSpec for testing the rails application. 

In the `/rails` folder:
- Run `rspec` to run all of the rspec tests, or `rspec spec/path/to/*_spec.rb` to run a specific test. 

Coverage reports are generated using [simplecov](https://github.com/simplecov-ruby/simplecov), and will be in `/rails/coverage`.

The test suite is configured to use [vcr](https://github.com/vcr/vcr) for tests that interact with any external APIs, primarily the OpenAlex API. If you encounter errors related to `vcr` while running tests, try deleting the recorded 'cassette' files in `spec/fixtures/vcr_cassettes/` and running `rspec` again to re-record them. 

Planning on trying Jest for testing front end. WIP. 
