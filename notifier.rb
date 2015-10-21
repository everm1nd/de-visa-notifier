require 'thor'
require 'pdf-reader'
require 'mail'

Mail.defaults do
  delivery_method :smtp, {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'gmail.com',
    :user_name            => CONFIG['email']['username'],
    :password             => CONFIG['email']['password'],
    :authentication       => 'plain',
    :enable_starttls_auto => true
  }
end

class Notifier < Thor
  PROCESS_STOP_PATH = './notifier.stop'

  option :email

  desc 'search BARCODE', 'search BARCODE in list'
  def search(barcode)
    if disabled?
      puts "Barcode already found. Shutdown"
      return
    end
    reader = PDF::Reader.new("test/input.pdf")
    reader.pages.each do |page|
      notify(barcode) if page.text.match barcode
    end
  end

  private
  def notify(barcode)
    mail(barcode) if options[:email]
    puts "Found barcode: #{barcode}"
    disable
  end

  def mail(barcode)
    email = options[:email]
      Mail.deliver do
        from     'visa-notifier@everm1nd.dev'
        to       email
        subject  'Yay! Your visa is ready!'
        body     ':) :) :)'
        add_file './media/attach.jpg'
      end
  end

  def disable
    File.new(PROCESS_STOP_PATH,'w')
  end

  def disabled?
    File.exists? PROCESS_STOP_PATH
  end
end
