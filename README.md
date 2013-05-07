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

     # Live Feed
     match.live

     # OR
     live = FootStats::Live.find(match.source_id)

     # Getting the FootStats Response for all feeds.
     #
     live.response

     match.response

     championship.response
```

## Simulating responses

With this gem you can simulate responses if you had some footstats responses stored in somewhere:

```ruby

     # Live Feed
     FootStats::Live.find(25563, response: Response.new({ body: '....' }))

     # Narrations Feed
     response = FootStats::Response.new(resource_key: FootStats::Narration.resource_key, body: '...')
     FootStats::Narration.find(match: 25563, response: response)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
