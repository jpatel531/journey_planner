require 'time'

module TimeHelpers

	def prettify time
		t = Time.parse time
		t.strftime("%b%e %Y %H:%M")
	end


end