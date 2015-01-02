Mybema
======
[![Circle CI](https://circleci.com/gh/mybema/mybema/tree/master.svg?style=svg&circle-token=90c4da5a58b2d537ebc3e508bae7b1aa931347e0)](https://circleci.com/gh/mybema/mybema/tree/master)

Mybema is an open source community platform. It allows users to participate in discussions and lets you create knowledgebase articles for your community.

Installation
============
You can install Mybema in one of two ways at the moment. We recommend using Ansible.

Using Ansible
-------------
The easy way to setup Mybema is to use the [mybema-config](http://www.github.com/pawel2105/mybema-config) repository. It uses [Ansible](http://www.ansible.com) to provision a VPS on [DigitalOcean](http://www.digitalocean.com).

The hard way
------------
If you don't want to use Ansible, you can run the following steps. First clone the repo:

    git clone git@github.com:pawel2105/mybema.git

Then install the dependencies:

    bundle install

Install Postgres if you haven't alrady

    brew install postgresql

Install Redis if you haven't alrady

    brew install redis

Install Elasticsearch if you haven't already

    brew install elasticsearch

Create a database configuration file:

    cp config/database.example.yml config/database.yml

Create your database and run the migrations and the seeds:

    rake db:create db:migrate db:seed

Create a secrets configuration file:

    touch config/secrets.yml

Create a secret token using `rake secret` and add it into the file. You will also need to add your S3 credentials if you plan on using S3 for asset storage:

    development:
      secret_key_base: YOUR_SECRET_TOKEN
      amazon_bucket: YOUR_BUCKET_NAME
      amazon_access_key_id: ACCESS_KEY_ID
      amazon_secret_access_key: ACCESS_KEY

    test:
      secret_key_base: YOUR_SECRET_TOKEN

    production:
      secret_key_base: YOUR_SECRET_TOKEN
      amazon_bucket: YOUR_BUCKET_NAME
      amazon_access_key_id: ACCESS_KEY_ID
      amazon_secret_access_key: ACCESS_KEY

From here you should be good to start up the server:

    bundle exec rails s

Running the tests
=================
You'll need to fire up elasticsearch as well as a redis server before running the test suite. Once they are up, simply run:

    rake test

Contributing
============
Contributions are welcome. Please add unit tests as well as feature tests with your changes and squash your commits before submitting pull requests. Bugs should be reported via the issue tracker.

License
=======
Please see [LICENSE.txt](https://github.com/mybema/mybema/blob/master/LICENSE.txt) for licensing details.