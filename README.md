# README

## Introduction

BookWorm is a full stack application allowing users to query bibliometric data, sourced from [OpenAlex's data snapshot](https://docs.openalex.org/download-all-data/openalex-snapshot), and provides the option of viewing the resulting data in a graph-based data visualization. 

On opening, users are presented with a blank canvas.

![Image of a blank canvas on a webpage with a green bar at the top. There is a button in the left that says "Open Query Panel" and a button on the right that says "Render Visualization?" In the center is an emoji of a caterpillar and a book and it says "BookWorm"](https://github.com/user-attachments/assets/a2317195-2488-476b-b22a-fa71afb685ca)

In the top left corner is a button to open the "Query Panel", which utilizes GraphiQL to provide an embedded GraphQL interface for creating queries, as well as documentation for the structure of the graph. 

![Image of the query panel open, and an example GraphQL query.](https://github.com/user-attachments/assets/1296afea-f551-42c1-81dc-923e5184929e)

If the query is valid and successful, the API will return a JSON object that mirrors the structure of the request.

![Image of the resulting JSON response from the query](https://github.com/user-attachments/assets/095f4462-41c4-45ac-ba70-f4bb3d864038)

On closing the query panel, users can view and interact with the generated graph visualization. 

![Image of a graph visualization of the data, showing a yellow work in the center with teal lines going out and connecting to nodes representing authors](https://github.com/user-attachments/assets/6e2c118b-ec4f-4e9c-a4e2-aeaa4fddcae5)

![Another image of a query result, showing many blue or yellow nodes with article titles, connected by pink lines between them.](https://github.com/user-attachments/assets/63a52e59-0ae6-4f88-9010-0a8d5033be9e)


This uses a [GraphQL API](https://graphql.org/learn/queries/) for the query structure. 

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

To run a local development setup, you can run the rails development server and the react npm development server independently.

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

This repository uses RSpec for testing the rails application. (These need to be reworked as they haven't been maintained in recent changes). 

In the `/rails` folder:
- Run `rspec` to run all of the rspec tests, or `rspec spec/path/to/*_spec.rb` to run a specific test. 

Coverage reports are generated using [simplecov](https://github.com/simplecov-ruby/simplecov), and will be in `/rails/coverage`.

The test suite is configured to use [vcr](https://github.com/vcr/vcr) for tests that interact with any external APIs, primarily the OpenAlex API. If you encounter errors related to `vcr` while running tests, try deleting the recorded 'cassette' files in `spec/fixtures/vcr_cassettes/` and running `rspec` again to re-record them. 

Planning on trying Jest for testing front end. WIP. 

## Data Source

Data is sourced from [OpenAlex's data snapshot](https://docs.openalex.org/download-all-data/openalex-snapshot), which also provides information about the structure of the source data and some basic instructions for uploading to a relational database, such as the Postgres database used in BookWorm. 

There are rake tasks in `/rails/lib/tasks/` for reading from CSV files to the database - this process could be optimized by running rake tasks in parallel or making adjustments to the insertion batch sizes in each file. 

## Data Visualization

The data visualization is generated using a combination of [React Flow](https://reactflow.dev/) for rendering nodes and edges, and [D3](https://d3js.org/) for calculating node positions. 
