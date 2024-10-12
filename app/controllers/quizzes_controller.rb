class QuizzesController < ApplicationController
  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(
      question: params[:question], 
      answer_1: params[:answer_1],
      answer_2: params[:answer_2],
      title: params[:title],
      user_id: @current_user.id,   #.id忘れずに！
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

  def show
    @quiz = Quiz.find_by(id: params[:id])
    @options = [@quiz.answer_1, @quiz.answer_2, @quiz.answer.user_answer].shuffle 
    @quiz.started_at = Time.current
    @quiz.save
    
  end

  def check_answer
    @quiz = Quiz.find_by(id: params[:id])
    selected_answer = params[:selected_answer]
    if @quiz && selected_answer
      elapsed_time = Time.current - @quiz.started_at # 経過時間（秒単位）
      elapsed_minutes = (elapsed_time / 60).round(2) # 分単位に変換し、少数第2位まで表示
      if selected_answer == @quiz.answer.user_answer
        @quiz.user.score = @quiz.user.score.to_i + 1
        @quiz.user.save # スコアをデータベースに保存  
        flash[:notice] = "正解 : #{elapsed_minutes}"
        #トータルタイムカラムを作ってそこに加算保存します　　あってもなくてもいい
        #@quiz.total_time = (@quiz.total_time.to_f + elapsed_minutes.to_f)
        #@quiz.save
        
        #ユーザータイムカラムを作ってそこに加算保存します
        @quiz.user.total_time= (@quiz.user.total_time.to_f + elapsed_minutes.to_f)
        @quiz.user.save


        redirect_to("/quizzes/new")
      else selected_answer != @quiz.answer.user_answer
        flash[:notice] = "不正解"
        redirect_to("/quizzes/new")
      end
    end

  end

  
end
