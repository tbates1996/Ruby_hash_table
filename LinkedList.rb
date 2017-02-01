class LinkedList
	#Shows the beginins and end node of the linked list
	attr_accessor :head,:tail
	#Initialize an empty Linked list
	def initialize
		@head = nil
		@tail = nil
	end
	#Empties the linked list 
	def purge 
		@head = nil
		@tail = nil
	end
	#Returns boolean value showing if the list is empty or not 
	def empty?
		@head.nil?
	end
	#Returns the first value in the list
	def first
		raise ContainerEmpty if @head.nil?
		@head
	end
	#Adds a bucket or adds to a current bucket in the list
	def append(key,value)
		tmp = Bucket.new(key,value,self)
		if @head.nil?
			@head = tmp
			@tail = tmp
		else
			@tail.add(key,value)
		end
		
	end
	# Iterate through the current list and preform actions on the data in a code block
	def each
		current = @head
		while current != nil
			yield current
			current = current.overflow
		end
	end

end

#Elements of the linked list
class Bucket
		#Structure defining a slot which holds key value pairs 
		Slot = Struct.new(:key, :value)
		#Accessors to the fundamental parts of the bucket structure
		attr_accessor :slots, :count , :overflow
		#Initialize the bucket 
		def initialize(key,value,list)
			@slots = Array.new
			@slots << Slot.new(key,value)
			@count =  1
			@overflow = nil
			@list = list
		end
		#adds a value to the bucket or instances an overflow and updates the @overflow and list
		def add(key,value)
			if @count < 3
				@slots << Slot.new(key,value)
				@count += 1
			else
				@overflow = Bucket.new(key,value,@list)
				@list.tail = @overflow
			end
		end
		#Boolean expression to see if the bucket is full
		def isFull?
			if count == 3 
				return true
			end
			false
		end
		#iterate through the slots of the bucket 
		def each
			@slots.each do |slot|
				yield slot
			end
		end


	end