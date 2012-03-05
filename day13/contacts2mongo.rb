#!/usr/bin/env ruby
# Parse output from Google contacts CSV files and insert into a mongo database
require 'csv'
require 'mongo'

# Specify CSV source file
contacts = "/home/eiwe/Documents/contacts.csv"
raise "Contacts file not found" unless File.exists?(contacts)

# MongoHQ database connection
db = Mongo::Connection.new('staff.mongohq.com', 10036).db("rubylearning")
auth = db.authenticate('username', 'password')
coll = db.collection("contacts")

# Set up an array so that we'll use later to ensure we only
# import unique contacts.
csvnames = Array.new
mdbnames = Array.new
count = 0

# Put all the MongoDB entries in an array
coll.find.each do |r|
  mdbnames << r['firstname'] + " " + r['lastname']
end

# Parse the CSV and assign a few variables
CSV.foreach(contacts) do |r|
  firstname = r[0].to_s
  lastname  = r[2].to_s
  email     = r[14].to_s
  homephone = r[18].to_s
  cellphone = r[20].to_s
  fullname  = "#{firstname} #{lastname}"

  # Check the arrays to see if this name has already been imported
  unless csvnames.include?("#{fullname}") or mdbnames.include?("#{fullname}")
    csvnames << "#{fullname}"

    unless firstname.empty? or email.empty?
      doc = {
             :firstname => "#{firstname}",
             :lastname => "#{lastname}",
             :email => "#{email}"
            }
      begin
        coll.insert(doc)
        count += 1
      rescue => e
        puts "Error: #{e.message} when inserting #{fullname}"
      end
    end
  end
end

puts "#{coll.count} total records. #{count} records inserted."

