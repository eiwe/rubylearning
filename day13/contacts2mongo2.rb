#!/usr/bin/env ruby
# Parse output from Google contacts CSV files and insert into a mongo database
require 'csv'
require 'mongo'

# Specify CSV source file
contacts = "/home/eiwe/Documents/contacts.csv"
raise "Contacts file not found" unless File.exists?(contacts)

# MongoHQ database connection
db = Mongo::Connection.new('staff.mongohq.com', 10036).db("rubylearning")
auth = db.authenticate('user', 'password')
coll = db.collection("contacts2")

# Create an array that will hold hashes
lines = []

# Parse the CSV and assign a few variables
CSV.foreach(contacts) do |r|
  firstname = r[0].to_s
  lastname  = r[2].to_s
  email     = r[14].to_s
  homephone = r[18].to_s
  cellphone = r[20].to_s
  fullname  = "#{firstname} #{lastname}"

  # Insert entries into the array containing both First name and Email
  unless firstname.empty? or email.empty?
    lines.push({ firstname: "#{firstname}", lastname: "#{lastname}", email: "#{email}" })
    defined?(@csvcount) ? @csvcount += 1 : @csvcount = 1
  end
end

# Iterate over our Array and insert into Mongo DB
lines.each do |entry|
  unless coll.find(:firstname => entry[:firstname], :lastname => entry[:lastname])
    begin
      coll.insert(entry)
      defined?(@dbcount) ? @dbcount += 1 : @dbcount = 1
    rescue => e
      puts "Skipping entry: #{e.message}"
    end
  end
end

puts "#{@csvcount} CSV entries processed."
puts "#{@dbcount} entries inserted into the Mongo DB."
puts "#{coll.count} total entries in the Mongo DB."
