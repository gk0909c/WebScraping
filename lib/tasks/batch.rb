require "csv"
require_dependency "GoogleSearch"

class Tasks::Batch
  def self.execute
    print "input csv file path > "
    input_path = STDIN.gets.chomp 

    if !File.exist?(input_path)
      puts "file not exist"
      return
    end

    table = CSV.table(input_path)
    output = CSV.open("data/output.csv", "w")

    table.each do |line|
      search_result = Services::GoogleSearch.get_result(line[0])

      display = search_result[0][:html]
      display.slice!("<b>")
      display.slice!("</b>")

      output << [line[0], display, search_result[0][:link]]
    end

    output.close()
  end
end
