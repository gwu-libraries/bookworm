# README

## Development Steps

### Dependencies
1. Install ruby 3.2.2 (try `rbenv` if you don't have a ruby package manager)
2. Install `bundler` if needed - `gem install bundler`
3. Run `bundle install` to install gems.

### Database Setup

You will also a need a working installation of PostgreSQL - follow the instructions in [config/database.yml](config/database.yml) if you see an error related to `pg` on running `bundle install`.

1. Run `rails db:create` to create the development and test databases.

2. Run `rails db:migrate` to migrate the development and test databases. 

### Development server
After setting up the database, run `rails s` to start the development server.

At this point, the GraphQL endpoint should be available at `http://localhost:3000/graphql`.

The `GraphiQL` interface should also be available at `http://localhost:3000/graphiql`.

### Testing

Uses `RSpec` for testing - run `rspec` in to run the full suite, or `rspec spec/*_spec.rb` to run tests for a specific file. 

The test suite is configured to use [vcr](https://github.com/vcr/vcr) for tests that interact with any external APIs, primarily the OpenAlex API. If you encounter errors related to `vcr`, try deleting the recorded 'cassete' files in `spec/fixtures/vcr_cassettes/` and running `rspec` again to re-record them. 