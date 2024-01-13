class Feedback::Connectors::Github < Feedback::Connectors::Base
  attr_reader :client, :repository, :repository_name

  PUBLIC_COMMENT_PREFIX = '#feedback:'.freeze

  def initialize # rubocop:disable Lint/MissingSuper
    require 'octokit'
    @client = ::Octokit::Client.new(access_token: ENV['FEEDBACK_GITHUB_ACCESS_TOKEN'])
    @repository_name ||= ENV['FEEDBACK_GITHUB_REPOSITORY']
    @repository = @client.repository(repository_name)
  end

  def upload_post(post)
    response = @client.create_issue(@repository_name, post.description.truncate(30), post.description,
                                    labels: ['feedback'])
    post.update(issue_id: response.number, issue_url: response.html_url, status: :open)
  end

  def synchronize_post(post)
    issue = @client.issue(@repository_name, post.issue_id)

    post.update(status: issue.state.to_sym)

    comments = @client.issue_comments(@repository_name, post.issue_id)

    comments.each do |comment|
      next unless comment.body.starts_with?(PUBLIC_COMMENT_PREFIX)
      next if comment.id.in?(post.comments.map(&:comment_id))

      # it's a new comment!
      new_comment = post.comments.create(comment_url: comment.url,  comment_id: comment.id,
                                         content: comment.body.gsub!(PUBLIC_COMMENT_PREFIX, "") , user_id: nil)
      new_comment.save!
    end
  end

  def issues_by(creator)
    issues = []

    creator.feedback_posts.map(&:issue_id).each do |issue_id|
      issues << @client.issue(@repository_name, issue_id)
    end
  end

  def upload_comment(comment)
    response = @client.add_comment(@repository_name, comment.post.issue_id, comment.content_with_creator_info)
    comment.update(comment_url: response.html_url, comment_id: response.id)
  end
end
