namespace :forecast do
  desc "Get forecast entries and create/update records"
  task update_and_notify: :environment do
    Spot.distinct.pluck(:code).each do |code|
      SpotSyncJob.perform_later(code)
    end

    UserNotifierJob.set(wait: 30.minutes).perform_later
  end
end
