# Create guest user
unless User.where(username: 'Guest').any?
  User.create name: 'Guest', username: 'Guest', email: 'guest@mybema.com', password: SecureRandom.hex(12)
end

# Clear all guidelines and add the defaults
Guideline.delete_all
["Add a short, relevant title to your discussion.", "Be clear and concise.",
"Check your spelling and grammar before posting.", "Add your discussion to the appropriate category.",
"Be civil. We don't tolerate hate speech, racism or personal insults.",
"Do not lie or stretch the truth.", "No posting of spam. Obviously.",
"Thoughtful comments are much better than 'me too' posts."].each { |name| Guideline.create(name: name) }

# Create admin account
Admin.create(name: 'Admin', email: 'admin@admin.admin', password: 'password')

# Create general category
DiscussionCategory.create(name: 'General', description: 'General off-topic chat')

# Create application settings with a default hero message
AppSettings.create(hero_message: "Welcome to the Mybema community. If you've got a question about Mybema, try finding here before contacting our customer service. You can search below or navigate via the links above. See our knowledge base for official articles written by us about the most common issues you may experience. If you don't find what you're looking for there, you can also interact with our representitives and customers by joining or starting a new discussion.")