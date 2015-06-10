require 'marvelite'

class MarvelAPI
  attr_reader :client, :super_hero_array
  
  # initializes 
  
  def initialize
    @client = Marvelite::API::Client.new( :public_key => 'f86b7c595648736f9600732d05b42587', :private_key =>  'a41226ecc8e9ac5ca9e982067178610382b1c2f6')
    @super_hero_array = []
  end
  
  
  # returns a search for a character called name
  #
  # name - String of the name to search for
  #
  # returns an Array of all restuls matching that name
  def character_search(name)
    name_marvel = client.characters(:name => name)
    #puts client.characters(:limit => 10, :offset => 400, :orderBy => 'name')
    array_of_results = name_marvel[:data][:results]

    # if array_of_results.length > 0
    #   puts "You have found one!"
    # end
  end
  
  # returns the character_id from Marvel's result hash
  #
  # result_hash - Hash containing information on the character
  #
  # returns an integer
  def return_character_id(result_hash)
    result_hash[:id]
  end
  
  # searches if the character name starts with
  #
  # letters - String
  #
  # returns an Array (which may be empty if nothing is found)
  def character_starts_with_search(letters)
    name_marvel = client.characters(:nameStartsWith => letters, :limit => 100)
    #puts client.characters(:limit => 10, :offset => 400, :orderBy => 'name')
    array_of_results = name_marvel[:data][:results]

    # if array_of_results.length > 0
    #   puts "You have found one!"
    # end
  end
  
end