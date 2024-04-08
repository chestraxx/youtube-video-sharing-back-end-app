class Api::V1::SessionsController < ActionController::API
  include CurrentUserConcern

  def create
    user = User.find_by(email: params["user"]["email"])
                .try(:authenticate, params["user"]["password"])

    if user
      session[:user_id] = user.id

      render json: {
        status: :created,
        logged_in: true,
        user: user
      }
    else
      user = User.create!(
        email: params['user']['email'],
        password: params['user']['password'],
        password_confirmation: params['user']['password'],
      )

      if user
        session[:user_id] = user.id
        render json: {
          status: :created,
          registed: true,
          user: user
        }
      else
        render json: { status: 500}
      end
    end
  end

  def logged_in
    if @current_user
      render json: {
        logged_in: true,
        user: @current_user
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  def logout
    reset_session
    render json: { status: :deleted, logged_out: true }
  end
end
