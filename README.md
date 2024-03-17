# About
this repository is a full stack web application powered by Ruby On Rails.

# Requirements
- Ruby Version 3.2.2
- Bundler Version  2.5.6
- PostgresSQL
- Redis (for caching and sidekiq)
- Bun 1.x.x (for frontend assets processing)

# Getting Started
First please install [ruby](https://github.com/rbenv/rbenv), [bundler](https://bundler.io/), [rails](https://rubyonrails.org/), [bun](https://bun.sh/), and aslo postgreSQL and Redis (it's easier to use Docker)
copy the .env.example into .env
```sh
cp .env.example .env
```

and update these following value
```
DB_HOST=127.0.0.1
DB_USERNAME=postgres
DB_PASSWORD=
REDIS_HOST=redis://127.0.0.1:6379/0
CACHE_REDIS_URL=redis://127.0.0.1:6379/1
SIDEKIQ_USER=sidekiq
SIDEKIQ_PASSWORD=sidekiq_passowrd
```

to run the server
```sh
rails s
```

to run the entire development servers you need to install foreman to run multiple command concurrently. Don't add it to your local project, it is supposed to be a global binary.
```sh
gem install foreman
```

to run development servers
```sh
foreman s -f Procfile.dev
```

now you can access the webpage on [http://127.0.0.1:5000](http://127.0.0.1:5000)

check sidekiq on [http://127.0.0.1:5000/sidekiq](http://127.0.0.1:5000/sidekiq) use the username and password from your  `.env` file