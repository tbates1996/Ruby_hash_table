class LinkedList
	#Shows the beginins and end node of the linked list
	attr_accessor :head,:tail, :count
	#Structure to define a slot data type
	Slot = Struct.new(:key, :value,:next)

	#Initialize an empty Linked list
	def initialize
		@head = nil
		@tail = nil
		@count = 0
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
		tmp = Slot.new(key,value,nil)
		if @head.nil?
			@head = tmp
			@tail = tmp
			@count += 1
		else
			@tail[:next] = tmp
			@tail = tmp
			@count += 1
		end
		
	end
	# Iterate through the current list and preform actions on the data in a code block
	def each
		current = @head
		while current != nil
			yield current
			current = current[:next]
		end
	end

end
