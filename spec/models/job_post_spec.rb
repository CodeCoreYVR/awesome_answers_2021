require 'rails_helper'
require 'byebug'
# matchers docs https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
# run these tests using the command rspec -f d

RSpec.describe JobPost, type: :model do
  def current_user
    @current_user ||= FactoryBot.create(:user)
  end
  describe "#validates" do
    it "is requires a title" do
      # Given
      job_post = FactoryBot.build(:job_post, title: nil)
      # Your Factories should always create a valid model
      # FactoryBot.build create a new instance of the model but not save it to the database.

      # When
      job_post.valid?

      # Then
      # expect is is passed a value we're asserting
      # we can chain .to()
      # .to() accepts a assertion/expectation clause
      expect(job_post.errors.messages).to(have_key(:title))
    end

    it "requires a unique title" do
      persisted_job_post = FactoryBot.create(:job_post)
      job_post = FactoryBot.build(:job_post, title: persisted_job_post.title)

      job_post.valid?
      expect(job_post.errors.messages).to(have_key(:title))
    end

    it "requires a location" do
      job_post = FactoryBot.build(:job_post, location: nil)

      job_post.valid?

      expect(job_post.errors.messages).to(have_key(:location))
    end

    it "requires a description" do
      job_post = FactoryBot.build(:job_post, description: nil)

      job_post.valid?

      expect(job_post.errors.messages).to(have_key(:description))
    end

    it "requires description to be more than 20 characters" do
      # Given
      job_post = FactoryBot.build(:job_post, description: 'less than 20')

      # When
      job_post.valid?

      # Then
      # byebug
      expect(job_post.errors.messages).to(have_key(:description))
    end

    it "requires that min_salary is greater than 30_000" do
      # When
      job_post = FactoryBot.build(:job_post, min_salary: 25_000)

      job_post.valid?

      # the error object on models have a method details that returns a hash with keys equal to columns that have errors. The value of those keys are an array of error messages each with a error key whose value is a validation symbol
      expect(job_post.errors.details[:min_salary][0][:error]).to(be(:greater_than_or_equal_to))
    end
  end

  # As per Ruby docs, methods that are described with a '.' in front
  # are class methods, while those described with a '#' in front are 
  # instance methods
  describe ".search" do
    it "should return job posts containing the search term" do 
      # GIVEN 
      # 3 job posts in the db
      job_post_a = JobPost.create(
        title: "Software Engineer",
        description: "Best Job ever. We build the best applications ever",
        min_salary: 50_000,
        location: "Vancouver",
        user: current_user
      )
      job_post_b = JobPost.create(
        title: "Programmer",
        description: "Best Software position. We build the best applications ever",
        min_salary: 50_000,
        location: "Burnaby",
        user: current_user
      )
      job_post_c = JobPost.create(
        title: "Programmer",
        description: "Build awesome stuff. We build the best applications ever",
        min_salary: 50_000,
        location: "Vancouver",
        user: current_user
      )

      # WHEN
      # searching for 'software'
      results = JobPost.search('software')

      # THEN
      # JobPost A & B are returned
      expect(results).to eq([job_post_a, job_post_b])
    end
  end

end
