require 'tzinfo'

every 1.day, at: '9:30 pm' do
  rake 'check_prolong_subscription:prolong_trial_newcomers'
end
