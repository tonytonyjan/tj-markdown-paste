namespace :faker do
  desc "Fake posts"
  task :posts => :environment do
    print "How many posts? "
    num = $stdin.gets.to_i
    num.times{
      Post.create title: Faker::Lorem.word, content: Faker::Lorem.paragraph
    }
  end
end