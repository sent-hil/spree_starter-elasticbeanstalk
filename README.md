# Spree Starter

This a forked version of dockerized [Spree Commerce](https://spreecommerce.org) application template ready to for local development and Elasticbeanstalk. See [https://github.com/spree/spree_starter](https://github.com/spree/spree_starter) for the original.

## Deploy in the cloud

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

<a href="https://render.com/deploy?repo=https://github.com/spree/spree_starter/tree/main">
  <img src="https://render.com/images/deploy-to-render-button.svg" alt="Deploy to Render" height=32>
</a>

### Elasticbeanstalk

It is a fairly involved process to setup EB propery. I wrote a [terraform module](https://github.com/sent-hil/terraform_common_modules) to automate most of it.

Once that's setup from within the folder:

#### Initialize EB

```bash
eb init
```

To deploy:

#### Deploy

```bash
eb deploy
```

Since EB uses docker-compose.yml for deployment, I moved the development version to be under docker-compose.dev.yml.

Note, the production version uses docker volumes to share bundle artificats and rails assest pipeline compiled assets. There have been instances where this has caused problems (once when upgrading version and other when the mimetypes were wrongly configured). If you run into any issues, start with deleting the two volumes with `sudo docker volume rm current_bundle_cache current_rails_assets`.

## Local Installation

### Using Docker (Recommended)

#### Install required tools and dependencies:

- [Docker](https://www.docker.com/community-edition#/download)

#### Run setup script

```bash
bin/setup
```

This will automatically launch the application at `http://localhost:4000/admin`

#### (Optional) Import sample data such as products, categories, etc

```bash
docker-compose -f docker-compose.dev.yml run web rake spree_sample:load
```

#### Launching local server

```bash
docker-compose -f docker-compose.dev.yml up
```

### Without Docker (not recommended for beginners)

#### Install required tools and dependencies

1. HomeBrew - https://brew.sh/
2. Install required packages

      ```bash
      brew install gpg postgresql redis imagemagick
      createuser -P -d postgres
      ```

3. RVM - https://rvm.io/
4. NVM - https://github.com/nvm-sh/nvm
5. Ruby - `rvm install 3.0.2`
6. Node - `nvm install`
7. Yarn - `npm -g install yarn`

#### Run setup script

```bash
bin/setup-no-docker
```

## Adding Storefront

Spree is a [headless e-commerce platform](https://dev-docs.spreecommerce.org/getting-started/headless-commerce) which you can use with any storefront you like. We have pre-built integrations with:

* [Next.js Commerce](https://dev-docs.spreecommerce.org/storefronts/next.js-commerce)
* [Vue Storefront](https://dev-docs.spreecommerce.org/storefronts/vue-storefront)

## Updating

### Connect to the docker container

```bash
docker-compose -f docker-compose.dev.yml run web bash
```

### Run update commands

```
bundle update
bin/rails spree:install:migrations
bin/rails db:migrate
```

For additional instructions please visit [Spree Upgrade Guides](https://dev-docs.spreecommerce.org/upgrades)

## Development

### Launching rails console

```bash
docker-compose -f docker-compose.dev.yml run web rails c
```

### Launching bash console

```bash
docker-compose -f docker-compose.dev.yml run web bash
```

## Customization

### Adding new gems

Update `Gemfile` and run

```bash
bundle install
docker-compose -f docker-compose.dev.yml build
```

You will need to restart the server if running:

```bash
docker-compose -f docker-compose.dev.yml restart
```

## Environment variables

| variable            | description                                                                                                                 | default value |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------- | ------------- |
| DEBUG_ASSETS        | Enables/disables [asset debugging in development](https://guides.rubyonrails.org/asset_pipeline.html#turning-debugging-off) | false         |
| DB_POOL             | database connection pool                                                                                                    | 5             |
| MEMCACHED_POOL_SIZE | memcache connection pool                                                                                                    | 5             |
| SENDGRID_API_KEY    | API key to interface Sendgrid API                                                                                           |               |

## License

Spree Starter (formerly Spark Starter Kit) is copyright © 2015-2021
[Spark Solutions Sp. z o.o.][spark]. It is free software,
and may be redistributed under the terms specified in the
[LICENSE](LICENSE.md) file.

## About Spark Solutions

[![Spark Solutions](http://sparksolutions.co/wp-content/uploads/2015/01/logo-ss-tr-221x100.png)][spark]

Spree Starter is maintained and funded by [Spark Solutions Sp. z o.o.](http://sparksolutions.co?utm_source=github)
The names and logos are trademarks of Spark Solutions Sp. z o.o.

We are passionate about open source software.
We are [available for hire][spark].

[spark]: http://sparksolutions.co?utm_source=github
