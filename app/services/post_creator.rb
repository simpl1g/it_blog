class PostCreator < ApplicationService
  attr_reader :post

  option :title, default: -> { '' }
  option :body,  default: -> { '' }
  option :ip,    default: -> { '' }
  option :login, default: -> { '' }

  Schema = Dry::Validation.Schema do
    configure do
      config.messages_file = 'config/locales/errors.yml'

      def ip?(value)
        IPAddr.new(value).ipv4?
      rescue IPAddr::InvalidAddressError
        false
      end
    end

    required(:title).filled(:str?)
    required(:body).filled(:str?)
    required(:ip).filled(:ip?)
    required(:login).filled(:str?)
  end

  def create_post
    return false unless valid?

    _create_post

    true
  end

  private

  def validator
    @validator ||= Schema.call(title: title, body: body, ip: ip, login: login)
  end

  def _create_post
    Post.transaction do
      @post = Post.create!(user: user, title: title, body: body, ip: ip)
      save_ip_usage_info
    end
  end

  def user
    @user ||= User.find_or_create_by!(login: login)
  end

  def save_ip_usage_info
    ip_usage = IpUsage.find_or_create_by!(ip: ip)
    ip_usage.used_by = ip_usage.used_by | [login]
    ip_usage.save!
  end
end