class BooksController < ApplicationController
  before_action :book_check,only:[:edit,:update]
  
  def new
    @book = Book.new
  end
  
  def create#投稿データの保存
    @book = Book.new(book_params)
    @book.user_id = current_user.id#bookモデルに紐づいたuser_idを操作+ログイン中のユーザー情報を取得
    @user = User.find(current_user.id)
    @books = Book.all
    if @book.save                  #book(投稿データ)のuser_idを投稿データに今ログイン中のユーザーIDを持たせる
    flash[:notice] = "You have created book successfully."#bookのcreateフラッシュメッセ
    redirect_to book_path(@book)# bookのshowページへのリンク、@bookにcurrent_user.idが代入されているので、@bookを指定
    else
    render "index"
    end
  end

  def index
    @book = Book.new
    @user = User.find(current_user.id)
    @books = Book.all
    #<% @books.each do |book| %> @booksにBookの情報全て(.all)を代入し、@booksから|book|に対し一情報ずつ投稿されたbookを格納しeachにより繰り返し表示(一覧表示)させる
  end

  def show
     @book = Book.new
     @book_id = Book.find(params[:id])# 投稿されたbookの詳細情報を見つけるために(params[:id])を使用する
     @user = @book_id.user            # link_to @books.title,book_pathや@books.bodyは投稿されたbookの情報を抽出させる為に@books = Book.find(params[:id])これが必要になる
     # @userは投稿したユーザー(@books.user)を特定したいので@books.userを代入。
     # image_tag @user.get_profile_image(100,100) や　link_to @user.name,user_path　の@userはbookを投稿したユーザーを表示させたいので@user = @books.userこれが必要になる
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."#bookのeditフラッシュメッセ
    redirect_to book_path
    else
      render "edit"
    end
  end
  
  def destroy
    @books = Book.find(params[:id]) # 投稿した画像詳細に対してdestroyするので、@booksに対して.destroyと記述する
    @books.destroy                  # Showページと同じViewに記載するので、@bookにしてしまうと、@book = Book.new空の投稿と認識されるのでエラーになる。だから@booksとなる
    redirect_to books_path
  end
  
  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

  def book_check
     @book = Book.find(params[:id])#@bookに投稿したbookの投稿番号を見つけるアクションを代入
     @user = @book.user#@userに投稿したbookの情報(@book)のユーザー情報を代入
   if
      @user != current_user#bookを投稿したuserと現在ログイン中のユーザーが違う時
      redirect_to books_path#book＃indexに遷移する設定
   end
  end
  
end
