#!/usr/bin/ruby

guard :bundler do
	watch 'Gemfile'
	watch '*.gemspec'
end

# guard :rspec do
#   watch(%r{^controllers/(.+)\.rb$}) { |m| "spec/controllers/#{m[1]}_spec.rb" }
#   watch(%r{^models/(.+)\.rb$})      { |m| "spec/models/#{m[1]}_spec.rb" }
#   watch(%r{^spec/(.+)\.rb$})      { |m| "spec/#{m[1]}.rb" }
#   watch('spec/spec_helper.rb')      { "spec" }

#   watch('app.rb')                   {"spec"}
#   watch('helpers.rb')               {"spec"}
#   watch('spec/factories.rb')        {"spec"}
#   watch('spec/shared_examples.rb')  {"spec"}
# end

# guard :yard do
#   watch(%r{^controllers/(.+)\.rb$})
#   watch(%r{^models/(.+)\.rb$})
# end

# guard :shotgun do
#    watch('app.rb')
# end

# guard 'livereload' do
#   watch(%r{views/.+\.(erb|haml|slim)$})
#   watch(%r{public/.+\.(css|js|html)})
# end

# group :server do
#   guard :shotgun do
#     watch(%r{^controllers/(.+)\.rb$})
#     watch(%r{^models/(.+)\.rb$})
#     watch('views/views.rb')
#     watch('app.rb')
#     watch('helpers.rb')
#   end
# end
