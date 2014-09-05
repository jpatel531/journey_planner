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

## Usage

```
irb
```
```ruby
require 'journey_planner'

client = TFLJourneyPlanner::Client.new(app_id: your_app_id, app_key: your_app_key)

journeys = client.get_journeys from: "old street underground station", to: "oxford circus underground station"

# => returns an array of Journey objects, each representing one of the possible journeys

```

### Example Methods

####Journey Instructions

The `instructions` method returns a hash of instructions, with the keys as departure and arrival times, and the values as arrays of verbal instructions.

```ruby
journeys.first.instructions
# {"Sep 5 2014 16:21 - Sep 5 2014 16:27"=>["Northern line to Euston / Northern line towards Edgware, Mill Hill East, or High Barnet"], 
# "Sep 5 2014 16:32 - Sep 5 2014 16:35"=>["Victoria line to Oxford Circus / Victoria line towards Brixton"]} 
```

####Disruptions

The `find_disruptions` method returns an array of potential disruptions to a particular journey.

```ruby
journeys = client.get_journeys from: "fulham broadway underground station", to: 'edgware road underground station circle line'
journey = journeys.first
journeys.first.find_disruptions
#=> ["DISTRICT LINE TO KENSINGTON (OLYMPIA): The all day District Line service to Kensington (Olympia) has been withdrawn on Monday to Friday except for a very limited number of early morning and evening trains and during some events. Journey Planner will show when this service is operating.", "District Line: Minor delays between Edgware Road and Wimbledon only, due to an earlier signal failure at East Putney. GOOD SERVICE on the rest of the line.", "FULHAM BROADWAY, WIMBLEDON, SOUTHFIELDS, EARLS COURT AND WESTMINSTER STATIONS: A ramp is provided at these stations providing step-free access onto District line trains (as well as Circle line trains at Westminster). Please ask staff in the ticket hall for assistance."] 
```

This method also comes with the filter options, `filter: :realtime`, `filter: :information`. The former represents live updates regarding delays and closures, where the latter provides more general information. The method is called with the argument `filter: :all` by default.

```ruby
journey.find_disruptions filter: :realtime
#=> ["District Line: Minor delays between Edgware Road and Wimbledon only, due to an earlier signal failure at East Putney. GOOD SERVICE on the rest of the line."] 
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

###Search Options

```ruby
client.get_journeys

from: #=> 	Origin of the journey (if in coordinate format then must be "longitude,latitude")

to: #=> Destination of the journey (if in coordinate format then must be "longitude,latitude")

via: #=> Travel through (if in coordinate format then must be "longitude,latidude")

national_search: #=> Does the journey cover stops outside London? eg. "nationalSearch=true". Set to false by default

date: #=> The date must be in yyyyMMdd format

time: #=> The time must be in HHmm format

time_is: #=> Does the time given relate to arrival or leaving time? Possible options: "departing" | "arriving". Set to Departing by default

journey_preference: #=> The journey preference eg possible options: "leastinterchange" | "leasttime" | "leastwalking"

mode: #=> The mode must be a comma separated list of modes. eg possible options: "public-bus,overground,train,tube,coach,dlr,cablecar,tram,river,walking,cycle"

accessibility_preference: #=> The accessibility preference must be a comma separated list eg. "noSolidStairs,noEscalators,noElevators,stepFreeToVehicle,stepFreeToPlatform"

from_name: #=> From name is the location name associated with a from coordinate

to_name: #=> To name is the label location associated with a to coordinate

via_name: #=> Via name is the location name associated with a via coordinate

max_transfer_minutes: #=> The max walking time in minutes for transfer eg. "120"

min_transfer_minutes: #=> The max walking time in minutes for journeys eg. "120"

walking_speed: #=> The walking speed. eg possible options: "slow" | "average" | "fast"

cycle_preference: #=> The cycle preference. eg possible options: "allTheWay" | "leaveAtStation" | "takeOnTransport" | "cycleHire"

adjustment: #=> Time adjustment command. eg possible options: "TripFirst" | "TripLast"

bike_proficiency: #=> A comma separated list of cycling proficiency levels. eg possible options: "easy,moderate,fast"

alternative_cycle: #=> Set to True to generate an additional journey consisting of cycling only, if possible. Default value is false. eg. alternative_cycle: true

alternative_walking: #=> Set to true to generate an additional journey consisting of walking only, if possible. Default value is false. eg. alternative_walking: true

apply_html_markup: #=> Flag to determine whether certain text (e.g. walking instructions) should be output with HTML tags or not.

```

#### Disambiguation

When entering to- and from- locations, specificity is the best option. For instance, searching for "Fulham Broadway Underground Station" or "Feltham Rail Station" will work, whereas "Fulham Broadway", "Feltham", "Fulham Broadway Station" or "Feltham Station" will not. However, TFL does provide some disambiguation options in their API for less obvious entries, which the gem prints to the console when an ambiguous search has been entered.

```ruby 
client.get_journeys from: "fulham broadway underground station", to: "edgware road underground station"

#=> Did you mean? 
#=> Edgware Road, Edgware Road (Circle Line) Underground Station
#=> false
```

##Objectives

* To learn about how to create a gem
* To learn about making HTTP requests with HTTParty
* To learn how to stub HTTP requests in your test suite with VCR and WebMock
* To explore the TFL Journey Planner API


##Technologies

* Ruby
* RSpec
* VCR
* WebMock
* HTTParty
* Recursive OpenStruct
* TFL API


## Contributing

1. Fork it ( https://github.com/[my-github-username]/journey_planner_gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
