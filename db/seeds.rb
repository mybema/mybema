# Create guest user
unless User.where(username: 'Guest').any?
  User.create name: 'Guest', username: 'Guest', email: 'guest@mybema.com', password: SecureRandom.hex(12)
end

Guideline.delete_all
["Add a short, relevant title to your discussion.", "Be clear and concise.",
"Check your spelling and grammar before posting.", "Add your discussion to the appropriate category.",
"Be civil. We don't tolerate hate speech, racism or personal insults.",
"Do not lie or stretch the truth.", "No posting of spam. Obviously.",
"Thoughtful comments are much better than 'me too' posts."].each { |name| Guideline.create(name: name) }