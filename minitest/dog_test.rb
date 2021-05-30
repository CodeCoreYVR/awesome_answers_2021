require "minitest/autorun"

class Bone
  attr_accessor :size
  
  def initialize(size)
    @size = size
  end
end

class Dog

  def initialize()
    @bones = []
  end

  def give_bone(bone)
    if !(bone.instance_of? Bone) 
      raise "#{bone} is not an instance of Bone. Got: #{bone.class}"
    end

    if @bones.length >= 3
      raise "maximum bone count reached. Can't hold any more bones"
    end

    @bones << bone
    @bones.length
  end

  def eat_bone
    @bones.pop
  end

  def bone_count
    @bones.length
  end
end

describe "Dog" do
  describe ".give_bone" do
    it "only accepts bones" do
      dog = Dog.new
      _(-> { dog.give_bone([]) }).must_raise RuntimeError
    end

    it "has a maximum of 3 bones" do
      dog = Dog.new
      dog.give_bone Bone.new('large')
      dog.give_bone Bone.new('large')
      dog.give_bone Bone.new('large')
      _(-> { dog.give_bone(Bone.new('small')) }).must_raise RuntimeError
    end

    it "returns the number of bones it currently owns" do
      dog = Dog.new
      dog.give_bone Bone.new('small')
      return_val = dog.give_bone Bone.new('small')
      _(return_val).must_equal(2)
    end
  end

  describe ".eat_bone" do
    it "returns the last bone" do
      dog = Dog.new
      dog.give_bone Bone.new('small')
      last_bone = Bone.new('medium')
      dog.give_bone last_bone

      return_val = dog.eat_bone

      _(return_val).must_be_same_as last_bone
    end

    it "removes the last bone" do
      dog = Dog.new
      dog.give_bone Bone.new('small')
      last_bone = Bone.new('medium')
      dog.give_bone last_bone

      dog.eat_bone # if eat_bone removes the last bone then calling it again won't result in the same bone being returned
      _(dog.eat_bone).wont_be_same_as last_bone
    end
  end

  describe ".bone_count" do
    
    it "returns the correct count of bones" do
      dog = Dog.new
      dog.give_bone Bone.new('small')
      dog.give_bone Bone.new('small')
      dog.eat_bone

      _(dog.bone_count).must_equal(1)
    end
  end


end
