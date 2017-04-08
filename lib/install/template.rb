# Install webpacker

puts "Copying webpack core config and loaders"
directory "#{__dir__}/config/webpack", "config/webpack"

append_to_file ".gitignore", <<-EOS
/public/webpack
EOS

puts "Webpacker Lite successfully installed 🎉 🍰"
