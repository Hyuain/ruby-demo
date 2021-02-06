class FirstController < ApplicationController
  def hello
    @xxx = "controller 里面的 @xxx"
    render 'first/hello'
  end
  def hi
    render 'first/hi'
  end
end