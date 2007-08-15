class ChronicController < ApplicationController
	def time
		@time = Chronic.parse(params[:duration])
		render :layout => false
		rescue Exception => e
		render :text => "Invalid format."
	end
end
