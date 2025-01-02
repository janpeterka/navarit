class Feedback::Connectors::Base
  # def initialize
  # it is expected that the child class will set @client to be used for API calls
  # end

  def upload_post(post)
    raise NotImplementedError
  end

  def synchronize_post(post)
    raise NotImplementedError
  end

  def upload_comment(comment)
    raise NotImplementedError
  end
end
