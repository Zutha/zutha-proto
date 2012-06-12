class TagsController < ApplicationController
	expose(:tags) { Tag.alphabetically }

	before_filter :authorize, :only => [:create, :destroy, :edit]

	def index
		@tag = Tag.new

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: tags }
		end
	end

	def create
		@tag = Tag.create(params[:tag])
		
		respond_to do |format|
			if @tag.valid?
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

	def edit
		@tag = Tag.find(params[:id])
	end

	def update
		@tag = Tag.find(params[:id])

		respond_to do |format|
			if @tag.update_attributes(params[:tag])
				format.html { redirect_to tags_url, notice: 'Tag was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @tag.errors, status: :unprocessable_entity }
			end
		end
	end
end