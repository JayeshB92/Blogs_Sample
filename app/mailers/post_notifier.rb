class PostNotifier < ApplicationMailer
  def post_update_email(user_id, message)
    user = User.find_by_id(user_id)

    if user.present?
      @message = message
      mail(:to => user.email,
           :subject => "Post updated..!!"
      )
    end
  end
end