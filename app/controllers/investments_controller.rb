class InvestmentsController < ApplicationControllercase
  include InvestmentHelper, ApplicationHelper

  before_filter :authenticate_user!

  expose(:item) { Item.find params[:item_id] }
  expose(:investment) {
    found = item.investment_of current_user
    if found
      found
    else
      item.investments.build params[:investment]
    end
  }

  before_filter :setup_investment

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


protected
  
  def amount
    params[:amount] && params[:amount].to_f
  end

  def setup_investment
    investment.user = current_user
  end

  def refresh
    item.reload
    investment.reload

    obj = {
      :item_worth => pretty_round(item.worth), 
      :user_rating => user_rating(item),
      :user_balance => pretty_round(current_user.zuth)
    }
    render :json => obj
  end


end
