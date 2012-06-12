class ItemsController < ApplicationController

	expose(:filter_name) {
		if params[:item_type]
			item_type.try(:name)
		else
			"Items"
		end
	}
	expose(:items) {
		filtered = Item.joins(:tags)
		TagType.all.each do |tt|
			if params[tt.url_name].present?
				filtered = filtered.where("lower(tags.url_name) = ?", params[tt.url_name])
			end
		end
		filtered.by_worth 
	}
	# expose(:item)

	before_filter :authorize, :only => :destroy

	# GET /items
	# GET /items.json
	def index
		if filter_name
			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: items }
			end
		else
			redirect_to items_url, :alert => "'#{params[:tag]}'' is an invalid tag"
		end
	end

	# GET /items/1
	# GET /items/1.json
	def show
		@item = Item.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @item }
		end
	end

	# GET /items/new
	# GET /items/new.json
	def new
		@item = Item.new
		taglink = @item.tag_links.new
		if tag
			taglink.tag_id = tag.id
		end

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @item }
		end
	end

	# GET /items/1/edit
	def edit
		@item = Item.find(params[:id])

		@item.tag_links.build
	end

	# POST /items
	# POST /items.json
	def create
		@item = Item.create(params[:item])

		respond_to do |format|
			if @item.save
				format.html { redirect_to items_url, notice: 'Item was successfully created.' }
				format.json { render json: items, status: :created, location: items_url }
			else
				format.html { render action: "new" }
				format.json { render json: @item.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /items/1
	# PUT /items/1.json
	def update
		@item = Item.find(params[:id])

		respond_to do |format|
			if @item.update_attributes(params[:item])
				format.html { redirect_to items_url, notice: 'Item was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @item.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /items/1
	# DELETE /items/1.json
	def destroy
		@item = Item.find(params[:id])
		@item.destroy

		respond_to do |format|
			format.html { redirect_to items_url }
			format.json { head :no_content }
		end
	end

	protected

	def item_type 
		@item_type ||= Tag.where("lower(url_name) = ?", params[:item_type].try(:downcase)).first
	end
end
