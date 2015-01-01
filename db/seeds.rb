# Create application settings with a default hero message
unless AppSettings.any?
  AppSettings.create(hero_message: "Welcome to the Mybema community. If you've got a question about Mybema, try finding it here before contacting our customer service team. See the articles section for official articles written by us about the most common issues you may experience. If you don't find what you're looking for there, you can also interact with our representatives and other customers by joining a discussion or starting a new one.")
end

# Create guest user
if AppSettings.first.seed_level < 1
  User.create name: 'Guest', username: 'Guest', email: 'guest@mybema.com', password: SecureRandom.hex(12)
  AppSettings.first.update_attributes(seed_level: 1)
end

# Clear all guidelines and add the defaults
if AppSettings.first.seed_level < 2
  ["Add a short, relevant title to your discussion.", "Be clear and concise.",
  "Check your spelling and grammar before posting.", "Add your discussion to the appropriate category.",
  "Be civil. We don't tolerate hate speech, racism or personal insults.",
  "Do not lie or stretch the truth.", "No posting of spam. Obviously.",
  "Thoughtful comments are much better than 'me too' posts."].each do |name|
    Guideline.create(name: name)
  end
  AppSettings.first.update_attributes(seed_level: 2)
end

# Create admin account
if AppSettings.first.seed_level < 3
  Admin.create(name: 'Admin', email: 'admin@admin.admin', password: 'password')
  AppSettings.first.update_attributes(seed_level: 3)
end

# Create general category
if AppSettings.first.seed_level < 4
  DiscussionCategory.create(name: 'General', description: 'General off-topic chat')
  AppSettings.first.update_attributes(seed_level: 4)
end

# Add emoji images
if AppSettings.first.seed_level < 5
  Rake::Task['emoji'].invoke
  AppSettings.first.update_attributes(seed_level: 5)
end