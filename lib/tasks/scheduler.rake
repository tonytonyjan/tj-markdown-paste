namespace :cron do
  desc "Destroy all posts older than 1 week."
  task :destroy_expired_posts => :environment do
    Post.where("updated_at < ?", Time::now.weeks_ago(1)).find_each{|p| p.destroy}
  end
end