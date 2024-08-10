# README

## Development Steps

### Dependencies
1. Install ruby 3.2.2 (try `rbenv` if you don't have a ruby package manager)
2. Install `bundler` if needed - `gem install bundler`
3. Run `bundle install` to install gems.

You will also a working installation of PostgreSQL - follow the instructions in [config/database.yml](config/database.yml) if you see an error related to `pg` on running `bundle install`.

### Database Setup
1. Run `rails db:create` to create the development and test databases.

2. Run `rails db:migrate` to migrate the development and test databases. 

### Development server
1. Run `rails s` to start development server.

At this point, the GraphQL endpoint should be available at `http://localhost:3000/graphql`.

The `GraphiQL` interface should also be available at `http://localhost:3000/graphiql`.