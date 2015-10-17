require 'thor'
require 'pdf-reader'

class Notifier < Thor
  desc 'search BARCODE', 'search BARCODE in list'
  def search(barcode)
    reader = PDF::Reader.new("test/input.pdf")
    reader.pages.each do |page|
      puts 'found!' if page.text.match barcode
    end
  end
end
