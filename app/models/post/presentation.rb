module Post::Presentation
  
  def like_count
    "#{self.get_upvotes.count} #{singular_or_plural}"
  end

  private

  def singular_or_plural
    self.get_upvotes.count == 1 ? 'like' : 'likes'
  end
end