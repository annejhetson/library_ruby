require 'spec_helper'

describe Author do
  it 'it will initalize an author with a name' do
    test_author = Author.new({:name => "Stephen King"})
    test_author.should be_an_instance_of Author
    test_author.name.should eq "Stephen King"
  end
  it 'it will delete an author' do
    test_author = Author.create({:name => "Stephen King"})
    test_author.delete
    Author.all.should eq []
  end
  it 'will edit an authors name' do
    test_author = Author.create({:name => "Stephen King"})
    test_author.edit("Bonnie Bright")
    Author.all.first.name.should eq "Bonnie Bright"
  end

  describe ".create" do
    it 'it will initialize and save a book at once' do
    test_author = Author.create({:name => "Stephen King"})
    Author.all.first.name.should eq "Stephen King"
    end
  end
end
