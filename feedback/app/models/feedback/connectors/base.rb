class Feedback::Connectors::Base
  # def initialize
  # it is expected that the child class will set @client to be used for API calls
  # end

  def upload_post(post)
    raise NotImplementedError
  end

  def sync_post(post)
    raise NotImplementedError
  end

  def upload_comment(comment)
    raise NotImplementedError
  end

  def sync_comment(comment)
    raise NotImplementedError
  end

  def issues_by(creator)
    issues = []

    creator.feedback_posts.map(&:issue_id).each do |issue_id|
      issues << @client.issue(@repository_name, issue_id)
    end

    issues
  end
end
