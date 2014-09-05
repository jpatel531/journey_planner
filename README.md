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

journeys = client.get_journeys from: "old street underground station", to: "oxford circus underground station"

# => returns an array of Journey objects, each representing one of the possible journeys

```

### Methods you can play with:

The `instructions` method returns a hash of instructions, with the keys as departure and arrival times, and the values as arrays of verbal instructions.

```ruby
journeys.first.instructions
# {"Sep 5 2014 16:21 - Sep 5 2014 16:27"=>["Northern line to Euston / Northern line towards Edgware, Mill Hill East, or High Barnet"], 
# "Sep 5 2014 16:32 - Sep 5 2014 16:35"=>["Victoria line to Oxford Circus / Victoria line towards Brixton"]} 
```

### Integrating with Google Maps

Setting up a simple Sinatra app:

```ruby

require 'sinatra'
require 'sinatra/json'
require 'journey_planner'

get '/' do 
	erb :index
end

get '/maps' do 
	client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
	journeys = client.get_journeys from: "old street underground station", to: "oxford circus underground station"
	json journeys.first.map_path
end

```

Your HTML and Javascript (assuming JQuery, the Google Maps API, and GMapsJS have already been linked)

```html
<div id="map" style="height: 500px; width: 500px"></div>
```

```javascript
	$(document).ready(function(){

		$.get('/maps', function(coordinates){

			var map = new GMaps({
	  			div: '#map',
	  			lat: coordinates[0][0],
	  			lng: coordinates[0][1]

			});

			map.drawPolyline({
			  path: coordinates,
			  strokeColor: '#131540',
			  strokeOpacity: 0.6,
			  strokeWeight: 6
			});
		})

	})
```

On launching your app, you should find that GMaps has created a polyline from the TFL Journey Planner path coordinates.

![Image1](https://raw.githubusercontent.com/jpatel531/journey_planner_gem/master/screenshots/jp_gmaps_ex.jpg)




## Contributing

1. Fork it ( https://github.com/[my-github-username]/journey_planner_gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
