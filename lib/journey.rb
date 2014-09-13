require_relative 'time_helpers'

module TFLJourneyPlanner

	class Journey < RecursiveOpenStruct

		include TimeHelpers


		def instructions
			array = []
			legs.each do |leg|
				if leg.instruction.steps.any?
					leg.instruction.steps.each {|step| array << [ "#{prettify leg.departure_time} - #{prettify leg.arrival_time}", step.description]}
				else
					array << ["#{prettify leg.departure_time} - #{prettify leg.arrival_time}", leg.instruction.summary + " / " + leg.instruction.detailed]
				end
			end
			array.inject(Hash.new{ |hash,key| hash[key]=[] }){ |hash,(key,value)| hash[key] << value; hash }
		end

		def map_path
			legs.map { |leg| JSON.parse(leg.path.line_string)}.flatten(1)
		end

		def find_disruptions(options = {filter: :all})
			array = []
			legs.each do |leg|
				leg.disruptions.each do |disruption|
					array << disruption.description if (options[:filter] == :all || disruption.category.downcase == options[:filter].to_s.downcase )
				end
			end
			return array
		end

	end

end