class Feedback::Connectors::Github < Feedback::Connectors::Base
  attr_reader :client, :repository, :repository_name

  PUBLIC_COMMENT_PREFIX = '@feedback'

  def initialize
    require 'octokit'
    @client = ::Octokit::Client.new(access_token: ENV['FEEDBACK_GITHUB_ACCESS_TOKEN'])
    @repository_name ||= ENV['FEEDBACK_GITHUB_REPOSITORY']
    @repository = @client.repository(repository_name)
  end

  def upload_post(post)
    response = @client.create_issue(@repository_name, post.description)
    post.update(issue_id: response.number, issue_url: response.html_url, status: :open)
  end

  def synchronize_post(post)
    issue = @client.issue(@repository_name, post.issue_id)

    post.update(status: issue.state.to_sym)

    # issue.comments.each do |comment|
    #   next if post.
    # end
  end

  def issues_by(creator)
    issues = []

    creator.feedback_posts.map(&:issue_id).each do |issue_id|
      issues << @client.issue(@repository_name, issue_id)
    end
  end

  def comments(post)
    comments = @client.issue_comments(@repository_name, post.issue_id)

    public_comments = comments.select { _1.body.starts_with?(PUBLIC_COMMENT_PREFIX) }

    return public_comments
  end

  # def upload_comment(post)
end
