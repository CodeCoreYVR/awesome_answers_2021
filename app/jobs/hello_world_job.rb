# generated with `rails generate job hello_world`
class HelloWorldJob < ApplicationJob
  queue_as :default

  def perform(word)
    # Do something later
    # this is the code that gets executed at a later time
    puts "--------"
    puts "Running a job 🏃‍♀️"
    puts "The word is: #{word}"
    puts "--------"
  end
end

# To run this... inside of a controller (or model)

# <JobClass>.perform_now(<args>)
# HelloWorldJob.perform_now("Background Process synchronously")

# <JobClass>.perform_later(<args>)
# will enqueue the job to perform at a later time.
# with the delayed_job method calling a job with `perform_later` will add it to a queue of jobs that needs to be run
