class EventCheckerService
  def initialize
    @user_purchases = UserPurchase
  end

  def first_purchase
    @user_purchases = UserPurchase.all
    @user_purchases.where('expires_date_ms = ?', nil).find_each do |user_purchase|
      user_purchase.event_key + '_DidSuccessPurchase'
      # TO DO
      AppsflyerService.new(user_purchase).call
    end
  end

  def prolonged_purchase
    @user_purchases = UserPurchase.all
    params[:expires_date_ms]
    @user_purchases.where('expires_date_ms > ?', Time.now).find_each do |user_purchase|
      user_purchase.event_key + '_DidProlongSubscription'
      # TO DO
      AppsflyerService.new(user_purchase).call
    end
  end

  def cancel_purchase
    @user_purchases = UserPurchase.all
    @user_purchases.where('expires_date_ms < ?', Time.now).find_each do |user_purchase|
      user_purchase.event_key + '_DidCancelSubscription'
    end
  end

  def check_status
    @user_purchases = UserPurchase.all.find_each do |user_purchase|
      if user_purchase.where('expires_date_ms < ?', Time.now)
        @user_purchases.find_each do |user_p|
          AppsflyerService.new(user_p).call
          puts "\n\n\n\n\n\n\n\n\n\n\n\n CANCEL SUBSCRIPTION"
        end
      elsif @user_purchases.where(expires_date_ms == nil)
        @user_purchases.find_each do |user_p|
          AppsflyerService.new(user_p).call
        # TO DO
        puts "\n\n\n\n\n\n\n\n\n\n\n\n SUBSCRIPTION"
        end
      elsif @user_purchases.where(is_trial_period: false)
        @user_purchase.find_each do |user_p|
          AppsflyerService.new(user_p).call
        # TO DO
        puts "\n\n\n\n\n\n\n\n\n\n\n\n SUBSCRIPTION"
        end
      else
        # TO DO
        puts "\n\n\n\n\n\n\n\n\n\n\n\n SUBSCRIPTION"
      end
    end
  end
end
