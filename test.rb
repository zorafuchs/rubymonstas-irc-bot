Dir.foreach('test') do |test|
  next if test == '.' or test == '..'
  puts "\n\n\nRunning #{test}\n==============================="
  system "ruby test/#{test}"
end