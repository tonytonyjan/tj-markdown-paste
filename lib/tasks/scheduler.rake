namespace :cron do
  desc "Destroy all posts older than 1 week."
  task :destroy_expired_posts => :environment do
    now = Time::now
    Post.find_each{|p| p.destroy if now - p.updated_at > 1.week }
  end
end