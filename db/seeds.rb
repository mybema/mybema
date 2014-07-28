# Create guest user
unless User.where(username: 'Guest').any?
  puts 'hi'
  User.create name: 'Guest', username: 'Guest', email: 'guest@mybema.com', password: SecureRandom.hex(12)
end