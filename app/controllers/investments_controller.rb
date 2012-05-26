class InvestmentsController < ApplicationController
  include InvestmentHelper, ApplicationHelper

  before_filter :authenticate_user!

  expose(:item) { Item.find params[:item_id] }
  expose(:investment) { item.investment_of current_user }

  def buy
    default = current_user.zuth >= 5 ? 1.0 : 0.1
    investment.buy(amount || default)
    refresh
  end

  def sell
    default = 1.0
    investment.sell(amount || default)
    refresh
  end

  def set
    value = params[:investment][:value].to_f
    investment.set_value(value)
    refresh
  end


protected
  
  def amount
    params[:amount] && params[:amount].to_f
  end

  def refresh
    item.reload
    investment.reload
    current_user.reload

    render :json => make_response
  end

  def make_response
    new_item_worth = pretty_round(item.worth)
    new_user_rating = investment.value
    new_user_balance = pretty_round(current_user.zuth)

    obj = {}

    if params[:new_item_worth] != new_item_worth.to_s
      obj[:item_worth] = new_item_worth
    end
    if params[:new_user_balance] != new_user_balance.to_s
      obj[:user_balance] = new_user_balance
    end
    if params[:new_user_rating] != new_user_rating.to_s
      obj[:user_rating] = new_user_rating
    end
    obj
  end

end
