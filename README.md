<!DOCTYPE html>
<html>
 <head>
     <title>Bookers2</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
    
     <!--FontAwesomeを適用する為のリンク-->
     <link rel ="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
     
 </head>
<body>
  <header>
     <header class="shadow-sm">
         <nav class="navbar navbar-expand-lg navbar-dark bg-dark"><%#ナビゲーションバーの設定、bgはBackgroundの略#%>
         <a class="nav-item"><%= link_to (root_path), class: 'nav-link text-white' do %><%end%></a><%#ナビゲーションの中にlink_toをしてtext-whiteで文字の色を追加している#%>
    <div class="container">
      <a class="navbar-brand" href="/">Bookers</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav ml-auto">
             
        <% if user_signed_in? %>
        <li class="nav-item">
          <%= link_to user_path(current_user.id),  class: 'nav-link text-white' do %><%#users_show_path(current_user.id)#%>
          <i class="fa-solid fa-house-chimney"></i> Home
          <% end %>
        </li>
        <li class="nav-item">
          <%= link_to users_path,  class: 'nav-link text-white' do %><%#users_index_path(current_user.id)#%>
          <i class="fa-solid fa-users"></i> Users
          <% end %>
        </li>
        <li class="nav-item">
          <%= link_to books_path,  class: 'nav-link text-white' do %><%#books_index_path(current_user.id)#%>
          <i class="fa-solid fa-book-open"></i> Books
          <% end %>
        </li>
        <li class="nav-item">
          <%= link_to destroy_user_session_path, method: :delete, class: 'nav-link text-white' do %>
          <i class="fa-solid fa-right-from-bracket"></i> Log out
          <% end %>
        <% else %>
        <li class="nav-item">
          <%= link_to root_path, class: 'nav-link text-white' do %>
          <i class="fa-solid fa-house-chimney"></i> Home
          <% end %>
        </li>
        <li class="nav-item">
          <%= link_to about_path, class: 'nav-link text-white' do %>
          <i class="fa-solid fa-link"></i> About
          <% end %>
        </li>
        <li class="nav-item">
          <%= link_to new_user_registration_path, class: 'nav-link text-white' do %>
          <i class="fa-solid fa-user-plus"></i> Sign up
          <% end %>
        </li>
        <li class="nav-item">
          <%= link_to new_user_session_path, class: 'nav-link text-white' do %>
          <i class="fa-solid fa-right-to-bracket"></i> Log in
          <% end %>
        </li>
        <% end %>
        </ul>
      </div>
     </div>
   </nav>
  </header>
  <main>
    <!--バリデーションエラー用
    <%# if @book.errors.any? %>
     <div id="error_explanation">
       <h4><%#= @book.errors.count %>errors prohibited this obj from being saved:</h4>
        <ul>
       <%# @book.errors.full_messages.each do |message| %>
        <li><%#= message %></li>
      <%# end %>
      </ul>
     </div>
    <%# end %>-->
    
    <!--User info 部分-->
    <p></p>
    <div class="container px-5 px-sm-0">
      <div class="row">
        <div class="col-md-3">
        <h2>User info</h2>
        
          <!-- ユーザーの詳細 -->
          <table class="table">
            <div><%= image_tag @user.get_profile_image(100,100) %></div>
            
            <thead>
              <tr>
                <td><B>name</B></td>
                <td><B><%= @user.name %></B></td>
              </tr>
            </thead>
            
             <tbody>
               <tr>
                 <td><B>introduction</B></td>
                 <td><B><%= @user.introduction %></B></td>
               </tr>
             </tbody>
          </table>
          
             <!--ユーザー編集ボタン-->
            
             <%= link_to edit_user_path(current_user), class: 'btn btn-default btn-outline-secondary btn-block' do %>
             <i class="fa-solid fa-user-gear"></i>
             <% end %><br>
             
             <!--投稿フォーム-->
             
             <h2>New book</h2>
             <%= form_with model: @book do |f| %>
             <h6>Title</h6>
             <%= f.text_field :title %>
             <p></p>
             <h6>Opinion</h6>
             <%= f.text_area :body %>
             <p></p>
             <%= f.submit "Create Book" ,class: 'btn btn-success btn-auto' %>
             <% end %>
        </div>
      </div>
    </div>
  </main>
  <footer><br>
    <p align="center">CopyRight Infratop.inc</p>
  </footer>
 </body>
</html>