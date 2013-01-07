# FootStats

FootStats API Client in Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'foot_stats'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install foot_stats

## Setup

```ruby
    FootStats::Setup.setup do |config|
      config.username      = "username"
      config.password      = "password"
      config.logger        = Rails.logger
      config.base_url      = "http://footstats.com"
      config.payload_store = Redis.new
    end
```

## Usage

```ruby
     # Championship
     #
     championships = FootStats::Championship.all

     # Championship
     #
     championship = championships.first

     # Championship Classification
     #
     championship.classification 

     # Championship Teams
     #
     championship.teams

     # Matches
     #
     matches = championship.matches

     # Match
     match = matches.first

     # Narrations
     #
     match.narrations
```

## Next

* LIVE 'feed'.
* Create a Fake App (Sandbox), that simulates FootStats API.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
