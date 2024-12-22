class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:new]
  before_action :quiz_check_answer, only: [:check_answer]
  before_action :quiz_find_id, only: [:show]

  def new
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
      },
      # 新しく追加したセレクトボタンの値
      select_button_value: params[:select_button_value]

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

    # 現在のページを取得、デフォルトは１
    current_page = (params[:page] || 1).to_i
    # 1ページに表示するクイズの数
    per_page = 6
  
    # セレクトボタン　名前はname属性使用
    select_option = params[:select_option]

    # クイズの取得条件
    if select_option.present? && select_option != "全体"
      # セレクトボタンの値に応じたクイズを取得　Quiz.whereを使用しカラムセレクトボタンと送信されたセレクトボタンの紐づけ
      @quiz = Quiz.where(select_button_value: select_option).offset((current_page - 1) * per_page).limit(per_page)
    else
      # クイズをページに応じて取得する
      @quiz = Quiz.order(created_at: :asc).offset((current_page -1)* per_page).limit(per_page)
    end
    
    # クイズの総数を計算（フィルタリング後のデータ数を取得）total_quizzes = select_option.present? ?Quiz.where...ryの書き方もあったけどわからなくなるのでこちらを使用
    if select_option.present? && select_option != "全体"
      total_quizzes = Quiz.where(select_button_value: select_option).count
    else
      total_quizzes = Quiz.count
    end
    
    # 最後のページの判定
    @is_last_page = (current_page * per_page) >= total_quizzes

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
