# namespace :check_prolong_subscription do
#   task prolong_trial_newcomers: :environment do
#     UserPurchase.where(created_at: 7.days.ago.end_of_day...7.days.ago.end_of_day)
#                 .where(is_trial_period: true).find_each do |user|
#       AppsflyerService.new(user).call
#     end
#   end
# end
namespace :check_prolong_subscription do
  task prolong_trial_newcomers: :environment do
    # get_users
    Rails.logger.info "\n\n\n\n\n\n\n\n\n\n\n\n\n\nProlong subscription__#{Time.now}"
  end

  # private

  # def get_users
  #   UserPurchase.where('created_at > ?', Time.now)
  #   puts "get users for prolong"
  # end
end
