class ItemsController < ApplicationController
  expose(:items) { Item.by_worth }
  expose(:item)

  before_filter :authorize, :only => :destroy

  # GET /items
  # GET /items.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: item }
    end
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    respond_to do |format|
      if item.save
        format.html { redirect_to items_url, notice: 'Item was successfully created.' }
        format.json { render json: items, status: :created, location: items_url }
      else
        format.html { render action: "new" }
        format.json { render json: item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    respond_to do |format|
      if item.update_attributes(params[:item])
        format.html { redirect_to items_url, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
