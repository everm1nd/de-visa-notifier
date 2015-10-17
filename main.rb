require 'pdf-reader'

BARCODE = '3230731'

reader = PDF::Reader.new("test/input.pdf")

reader.pages.each do |page|
  puts 'found!' if page.text.match BARCODE
end
