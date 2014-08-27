class CustomLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{severity} #{timestamp} #{msg}\n"
  end
end

logfile = File.open(Rails.root.to_s + '/log/my.log', 'w')  #create log file
logfile.sync = true  #automatically flushes data to file

MY_LOG = CustomLogger.new(logfile)  #constant accessible anywhere