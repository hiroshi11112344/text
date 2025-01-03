class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  allow_browser versions: :modern
  before_action :set_current_user

  def set_current_user
    # @current_user = User.find_by(id: session[:user_id])
    @current_user = User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
    @current_user = nil
  end
  
  def set_quiz
    @quiz = Quiz.new
  end

  def quiz_check_answer
    @quiz = Quiz.find_by(id: params[:id])
    selected_answer = params[:selected_answer]
    @current_user
    # ↑変数入れなくて良い
    if @quiz && selected_answer
      if @current_user
        elapsed_time = (Time.current - @quiz.started_at).to_i # 経過時間（秒単位）
        # 秒数を時間、分、秒の形式に変換
        time_in_hours = Time.at(elapsed_time).utc.strftime("%H:%M:%S")

        # 中間テーブルログインしているユーザーIDと開いているクイズIDの紐付け
        quiz_result = QuizResult.find_or_create_by(user: @current_user, quiz: @quiz) 
        
        if selected_answer == @quiz.answer.user_answer
          
          # 中間テーブル
          #毎回０にして新しいデータを保存するので　if 小さい　＞　大きい　で保存する時の条件をつける
          #if quiz_result.time_spent.nil? || quiz_result.time_spent >= elapsed_time
          if quiz_result.time_spent >= elapsed_time
            quiz_result.time_spent = 0
            quiz_result.time_spent = elapsed_time.to_i
            quiz_result.save
          end

          # QuizResultに保存（ユーザーとクイズごとの解答時間を管理）
          # セーブをアップデート文に買える　１１２５
          @current_user.update(
             # ユーザーに正解したらスコア+1
            score: @current_user.score.to_i + 1,   # ユーザーに正解したらスコア+1

            # total_time が nil の場合は 0 に設定してから秒単位で加算
            total_time: (@current_user.total_time || 0.0) + elapsed_time.to_i  
          )
        
          
          # ユーザーに正解したらスコア+1
          #@user.score = @user.score.to_i + 1
          #@user.save # スコアをデータベースに保存  
          #flash[:notice] = "正解 : #{time_in_hours}"
          # total_time が nil の場合は 0 に設定してから秒単位で加算
          #@user.total_time ||= 0.0
          #@user.total_time += elapsed_time.to_i # 秒単位で加算
          #@user.save
          
          redirect_to("/quizzes/new")
          
        else selected_answer != @quiz.answer.user_answer
          flash[:notice] = "不正解"
          redirect_to("/quizzes/new")
        end
      else
        # ログインなし状態の処理
        if selected_answer == @quiz.answer.user_answer
          flash[:notice] = "正解"
          return redirect_to("/quizzes/new")
        else selected_answer != @quiz.answer.user_answer
          flash[:notice] = "不正解"
          return redirect_to("/quizzes/new")
        end
      end
        
    end
  end

  def quiz_find_id
    @quiz = Quiz.find_by(id: params[:id])
  end

end
