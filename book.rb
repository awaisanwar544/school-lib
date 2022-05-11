class Book
  attr_reader :rental
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
    @rental = rental
  end
end
