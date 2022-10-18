require 'securerandom'
require 'digest/md5'
require 'jwt'


class Api::V1::AccountController < ApplicationController

  # TODO global settings

  JWT_HMAC_SECRET = "a_j@tseCrx1tkk$$$"
  JWT_TOKEN_EXP_DAYS = 30
  JWT_TOKEN_REFRESH_CYCLES = 6

  def sign_up
    password = params[:password].to_s
    password = SecureRandom.uuid if password.blank?

    password_hash = Digest::MD5.hexdigest(password)

    user = User.new(username: params[:username],
                    password_hash: password_hash,
                    email: params[:email])
    if user.save
      # TODO send confirm email.
      #
      token = generate_token user
      render json: { msg: "ok", data: { token: token }, status: 200 }
    else
      render json: { error: "sign up failed.", status: 400 }
    end
  end

  def sign_in
    username = params[:username]
    password = params[:password].to_s

    if username.blank? or password.blank?
      render json: { error: "sign in failed.", status: 401 }
    end

    user = User.find_by_username(username)
    password_hash = Digest::MD5.hexdigest(password)
    if user.password_hash != password_hash
      render json: { error: "sign in failed.", status: 401 }
    end

    token = generate_token user
    render json: { msg: "sign in ok", data: { token: token }, status: 200 }
  end

  def confirm_email

  end

  def send_mobile_code

  end


  def refresh_token
    old_token = params[:token]
    # extract jwt
    decoded = JWT.decode(old_token,
                         JWT_HMAC_SECRET,
                         true,
                         { verify_expiration: false, algorithm: 'HS256' })
    payload = decoded[0]

    exp = payload[:exp]
    if Time.now.utc.to_i > exp
      render json: { error: "token already expired" }
      return
    end

    sub = JSON.load(payload[:sub])
    user_id = sub[:id]
    username = sub[:un]
    counter = sub[:nu]

    user = User.find_by_id(user_id)
    if user.username != username
      render json: { error: "token invalid" }
      return
    end
    if counter > JWT_TOKEN_REFRESH_CYCLES
      render json: { error: "token invalid" }
      return
    end

    new_token = generate_token(user, counter + 1)
    render json: { data: { token: new_token }, status: 200}
  end


  private

  def generate_token(user, counter = 0)
    now = Time.now.utc.to_i
    expiration = JWT_TOKEN_EXP_DAYS * 86400
    sub = {
      id: user.id,
      un: user.username,
      nu: counter,
    }
    payload = {
      iss: "gibberish-server",  # TODO global settings
      iat: now,
      exp: now + expiration,
      sub: JSON.dump(sub),
    }

    JWT.encode(payload, JWT_HMAC_SECRET, "HS256")
  end

end
