class HomeController < ApplicationController
  def top
    @quiz = Quiz.all
  end
end


#<%= link_to image_tag("Bg01.jpg"), "/quizzes/index"%>
