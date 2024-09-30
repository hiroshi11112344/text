class QuizzesController < ApplicationController
  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(
      question: params[:question], 
      answer_1: params[:answer_1],
      answer_2: params[:answer_2],
      # quizテーブルに書いた、accepts_nested_attributes_for を使用することで、Quiz の作成時に Answer のデータも同時に保存できます。
      answer_attributes: { 
      user_answer: params[:user_answer]

      
      }
    )
    if @quiz.save
      redirect_to("/quizzes/new")
    else
      render :new
    end
  
  end

  def index
    @quiz = Quiz.all
    
    #<%= quiz.answer.user_answer%>

  end

end
