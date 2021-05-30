# https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md
# Defining factories docs https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#defining-factories
# RANDOM_100_PLUS_CHARS = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
# FactoryBot.define do
#   factory :job_post, class: 'JobPost' do
#     # sequence is a method provided by factory-bot which keeps 
#     # accepts a lambda injecting a variable n. n is usually a number 
#     # that factory-bot increments on every object it generates 
#     # so we can use it to make sure all instances created are unique
#     sequence(:title) { |n| Faker::Job.title + " #{n}" }  
#     description { Faker::Job.field + " #{RANDOM_100_PLUS_CHARS}"} # All objects created using Factories should be valid objects. In this case, we're adding 100 characters to the description of any job_post to make sure it passes the description length validation
#     location { Faker::Address.city }
#     company_name { Faker::Company.name }
#     min_salary { rand(80_000..200_000) }
#     max_salary { rand(200_000..400_000) }
#     # The line below will create a user (using its
#     # factory) before creating a job post. Then, it will
#     # associate that user to the job post. This is necessary
#     # to pass the validation added by 'belongs_to' :user
#     association(:user, factory: :user)
#   end
# end

# With this factory defined we can:
# FactorBot.create(:job_post)