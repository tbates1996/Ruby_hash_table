require_relative "HashTable.rb"

class MyHash < HashTable
	#Instance a hash table with size passed to initialize
	def initialize size
		super size #me
	end

	#Read in the data from filename of choice 
	def read_data filename
		data = File.readlines(filename)
		data.each do |line|
			string = line.chomp
			str10 = string[0..9]
			str20 = string[10..-1]
			insert(str10,str20)

		end

	end
	#Read in keys from file and find the locations of the values
	def search_from_file
		print_search_header
		search_keys = File.readlines("SEARCH.txt")
		search_keys.each do |key|
			result = search(key.chomp)
			if result == -1
				print_search(key.chomp, "Record not found" , "")
			else
				print_search(key.chomp, result[:data] , result[:location])
			end
		end
	end
	#Write the data to the Output.txt file
	def write_data
		File.open("Output.txt","w") do |file|
			self.each do |bucket|
				bucket.each do |slot|
					file.write(slot[:key] + slot[:value] + "\n")
				end
			end
		end
		@table = Array.new(20)
	end
	#Defines the hash function used to put the data into the table
	def hash_function key
		return (key[1].ord + key[3].ord + key[5].ord)%20
	end
	#calculates total and average collisions on the table
	def stats
		#Should work out to 2.29 for this assignment
		total = 0
		buckets = 0
		@table.each do |bucket|
			if bucket != nil 
				if bucket.count != 1
					buckets += 1 		
					total += bucket.count 
				end
			end	
		end
			total = total - buckets
			puts "Total collisions: #{total}"
			puts "Average collisions: #{(total.to_f/buckets).round(2)}"
	end
	#Prints a report of the table and outputs it to the console
	def print_table
		print_report_header
		i = 1
		@table.each do |bucket|
			unless bucket == nil
					puts "Bucket #{i}:"
					j = 1
				bucket.each do |slot|			
					printf "%45s \n", "Slot #{j}: #{slot[:key]} #{slot[:value]}"
					j += 1
				end
			end
			i += 1
		end
	end

	private
	#Prints the header for the report of the hash table
	def print_report_header
		printf("%29s \n %32s \n %35s \n", "Hash Table", "Verification Report", "Before|After Restoration")
	end
	#Prints the variables of a search in the report format
	def print_search(key, value, location)
		printf("%10s %15s %25s\n",key, location, value)
	end
	#Prints the header of the search report
	def print_search_header
		printf("%10s %15s %25s\n","Search Key","Bucket/Slot" , "Record")
		50.times{print "="}
		puts 
	end

end

def main
	$stdout = File.new("Report.txt", "w")
	ht = MyHash.new(20)
	ht.read_data("DATAIN.txt")
	ht.print_table
	ht.write_data
	ht.read_data("Output.txt")
	ht.print_table
	puts ""
	ht.search_from_file
	puts ""
	puts "Stats\n======================="
	ht.stats
end

main