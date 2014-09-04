# Unofficial TFL Journey Planner Gem

A Ruby-wrapper for the TFL Journey Planner API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'journey_planner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install journey_planner

## Usage Examples

```
irb
```
```ruby
require 'journey_planner'

client = TFLJourneyPlanner::Client.new(app_id: your_app_id, app_key: your_app_key)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/journey_planner_gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
