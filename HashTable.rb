require_relative "LinkedList.rb"

class HashTable
	attr_reader :table
	#Instance a bucket of any size passed to the parameter
	def initialize(size)
		@table = Array.new(size)
	end
	#hash fuction method for child to define
	def hash_function
		raise "SYSTEM ERROR: Method missing"
	end
	#Inserts a value to the table 
	def insert(key,value)
		index = hash_function(key)
		if @table[index] == nil
			@table[index] = LinkedList.new
			@table[index].append(key,value)
		else
			@table[index].append(key,value)
		end
	end
	#Search the table and return the location of the key value pair
	def search(key)
		index = hash_function(key)
		if @table[index] == nil
			return -1
		else
			slot_num = 1	
			@table[index].each do |slot|
					
				if slot[:key] == key
					return {:location => "#{index + 1}/#{slot_num}", :data => slot[:value]}
				end
				slot_num += 1 
			end
			return -1
		end
	end
	#Iterate through the hash table to access all the bucket locations
	def each 
		@table.each do |hashkeys|
			if hashkeys != nil
				yield hashkeys
			end
		end

	end

end
