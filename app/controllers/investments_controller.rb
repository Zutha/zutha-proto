class InvestmentsController < ApplicationController

  before_filter :authenticate_user!

  expose(:item) { Item.find params[:item_id] }
  expose(:investment) {
    found = Investment.where(:user_id => current_user, :item_id => item).first
    if found
      found
    else
      item.investments.build params[:investment]
    end
  }

  before_filter :setup_investment

  def buy
    investment.buy(1)
    refresh
  end

  def sell
    investment.sell(1)
    refresh
  end


protected

  def setup_investment
    investment.user = current_user
  end

  def refresh
    item.reload
    investment.reload
    render investment
  end

end
