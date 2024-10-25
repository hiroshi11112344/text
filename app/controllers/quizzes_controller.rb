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
      user_id: @current_user.id,   # .id忘れずに！
      # quizテーブルに書いた、accepts_nested_attributes_for を使用することで、Quiz の作成時に Answer のデータも同時に保存できます。
      answer_attributes: { 
      user_answer: params[:user_answer]
      }

    )
    if 
      @quiz.save
      redirect_to("/quizzes/index")

    else
      redirect_to("/quizzes/new")
      flash[:notice] = "入力に誤りがあるみたいです"
      # render :new
    end
  
  end

  def index
    # @quiz = Quiz.page(params[:page]).per(6)
    
    # 現在のページを取得、デフォルトは１
    current_page = (params[:page] || 1).to_i

    # 1ページに表示するクイズの数
    per_page = 6

    # クイズをページに応じて取得する
    @quiz = Quiz.order(created_at: :asc).offset((current_page -1)* per_page).limit(per_page)

    # 次へボタン用のページ番号
    @next_page = current_page + 1 

    # 戻るボタン用のページ番号ただし、1ページ目は戻れない）
    @prev_page = current_page - 1 if current_page > 1

  end

  def show
    @quiz = Quiz.find_by(id: params[:id])
    @options = [@quiz.answer_1, @quiz.answer_2, @quiz.answer.user_answer].shuffle 
    @quiz.started_at = Time.current
    @quiz.save



    if @quiz
      # クイズに関連するQuizResultをtime_spent
      @quiz_result = QuizResult.where(quiz: @quiz).order(:time_spent).limit(3)
    else
      # each文の中身がnullだった場合こちらでnullエラーを防ぎます
      @quiz_result = []
    end
      
  end
    
    
  

  def check_answer
    @quiz = Quiz.find_by(id: params[:id])
    selected_answer = params[:selected_answer]
    @user = @current_user
    
    if @quiz && selected_answer

      elapsed_time = (Time.current - @quiz.started_at).to_i # 経過時間（秒単位）
      # 秒数を時間、分、秒の形式に変換
      time_in_hours = Time.at(elapsed_time).utc.strftime("%H:%M:%S")

      # 中間テーブルログインしているユーザーIDと開いているクイズIDの紐付け
      quiz_result = QuizResult.find_or_create_by(user: @user, quiz: @quiz) 
      
      if selected_answer == @quiz.answer.user_answer
        # QuizResultに保存（ユーザーとクイズごとの解答時間を管理）
        quiz_result.time_spent = 0
        quiz_result.time_spent = elapsed_time.to_i
        quiz_result.save

        # ユーザーに正解したらスコア+1
        @quiz.user.score = @quiz.user.score.to_i + 1
        @quiz.user.save # スコアをデータベースに保存  
        flash[:notice] = "正解 : #{time_in_hours}"
        

        # total_time が nil の場合は 0 に設定してから秒単位で加算
        @quiz.user.total_time ||= 0.0
        @quiz.user.total_time += elapsed_time.to_i # 秒単位で加算
        @quiz.user.save

        # 合計時間を "HH:MM:SS" 形式で表示
        total_time_in_hours = seconds_to_time(@quiz.user.total_time)
        flash[:notice] += " 総合時間: #{total_time_in_hours}"
      
        redirect_to("/quizzes/new")
      else selected_answer != @quiz.answer.user_answer
        flash[:notice] = "不正解"
        redirect_to("/quizzes/new")
      end
    end
  end
  
  private

  # 秒数を "HH:MM:SS" 形式の文字列に変換するメソッド
  def seconds_to_time(seconds)

  hours = seconds / 3600

  minutes = (seconds % 3600) / 60

  seconds = seconds % 60

  format("%02d:%02d:%02d", hours, minutes, seconds)
  
  end
end
