class UserController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email]
    )
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/quizzes/index")
    else
      render("user/new")
    end
  end

  def index
    @users = User.order(score: :desc) 
  end


  #ログイン画面
  def login
  end

  #ログインした時の処理
  def login_form
    @user = User.find_by(name: params[:name],email: params[:email])
    session[:user_id] = @user.id
    if @user
      redirect_to("/quizzes/index")
    else
      render("user/login")
    end
  end

  def logout  
    @a = "ログインしてくださいaaaaaaaaaaa"
    session[:user_id] = nil
    redirect_to("/login")
  end

end