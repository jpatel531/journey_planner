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
			array.inject(Hash.new{ |h,k| h[k]=[] }){ |h,(k,v)| h[k] << v; h }
		end

		def map_path
			array = []
			legs.each do |leg|
				array += JSON.parse(leg.path.line_string)
			end
			return array
		end

	end

end