require 'thor'
require 'pdf-reader'
require 'mail'

class Notifier < Thor
  option :email

  desc 'search BARCODE', 'search BARCODE in list'
  def search(barcode)
    reader = PDF::Reader.new("test/input.pdf")
    reader.pages.each do |page|
      notify(barcode) if page.text.match barcode
    end
  end

  private
  def notify(barcode)
    mail(barcode) if options[:email]
    puts "Found barcode: #{barcode}"
  end

  def mail(barcode)
    email = options[:email]
    begin
      Mail.deliver do
        from     'notifier@everm1nd.dev'
        to       email
        subject  'Yay! Your visa is ready!'
        body     ':) :) :)'
        add_file './media/attach.jpg'
      end
    rescue
      puts '[ERROR]: Failed to send email'
    end
  end
end
