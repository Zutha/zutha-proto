class TagsController < ApplicationController
	expose(:tags) { Tag.alphabetically }
	expose(:_tag)

	before_filter :authorize, :only => [:create, :destroy, :edit]

	def index
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: tags }
		end
	end

	def create		
		respond_to do |format|
			if _tag.save
				format.html { redirect_to tags_url, notice: 'Tag was successfully created.' }
				format.json { render json: items, status: :created, location: tags_url }
			else
				format.html { render action: "index" }
				format.json { render json: _tag.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		_tag.destroy

		respond_to do |format|
			format.html { redirect_to tags_url }
			format.json { head :no_content }
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if _tag.update_attributes(params[:tag])
				format.html { redirect_to tags_url, notice: 'Tag was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: _tag.errors, status: :unprocessable_entity }
			end
		end
	end
end