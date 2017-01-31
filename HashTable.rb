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
			@table[index].each do |bucket|
				number = 1 
				bucket.each do |slot|
					slot_num = 1
					if slot[:key] == key
						return "#{index + 1}:#{number}:#{slot_num}"
					end
					slot_num += 1 
				end
				number += 1
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