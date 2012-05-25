class TagsController < ApplicationController
	expose(:tags) { Tag.all }

	before_filter :authorize, :only => [:create, :destroy]

	def index
		@tag = Tag.new

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: tags }
		end
	end

	def create
		@tag = Tag.new(params[:tag])
		
		respond_to do |format|
			if @tag.save
				format.html { redirect_to tags_url, notice: 'Tag was successfully created.' }
				format.json { render json: items, status: :created, location: tags_url }
			else
				format.html { render action: "index" }
				format.json { render json: @tag.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@tag = Tag.find(params[:id])
		@tag.destroy

		respond_to do |format|
			format.html { redirect_to tags_url }
			format.json { head :no_content }
		end
	end
end