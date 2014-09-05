module TFLJourneyPlanner

	class Journey < RecursiveOpenStruct
		def instructions
			array = []
			legs.each do |leg|
				if leg.instruction.steps.any?
					leg.instruction.steps.each {|step| array << [ "#{leg.departure_time} - #{leg.arrival_time}", step.description]}
				else
					array << ["#{leg.departure_time} - #{leg.arrival_time}", leg.instruction.summary + " / " + leg.instruction.detailed]
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