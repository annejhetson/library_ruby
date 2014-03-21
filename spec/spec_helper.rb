require 'rspec'
require 'pg'
require 'book'
require 'author'

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM titles *;")
     DB.exec("DELETE FROM authors *;")
     DB.exec("DELETE FROM books *;")
  end
end
