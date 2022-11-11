require "csv"

class Parser
  def initialize(authors_path:, books_path:, magazines_path:)
    @authors = CSV.read(
      authors_path,
      headers: true,
      header_converters: :symbol,
      col_sep: ";"
    ).map(&:to_h)
    
    @books = CSV.read(
      books_path,
      headers: true,
      header_converters: :symbol,
      col_sep: ";"
    ).map(&:to_h)

    @magazines = CSV.read(
      magazines_path,
      headers: true,
      header_converters: :symbol,
      col_sep: ";"
    ).map(&:to_h)
  end

  def find_book_by_isbn(isbn)
    @books.find { |book| book[:isbn] == isbn}
  end
  
  def find_magazine_by_isbn(isbn)
    @magazines.find { |magazine| magazine[:isbn] == isbn }
  end

  def print_all_books
    @books.each_with_index do |book, i|
      puts "Title: #{book[:title]}"
      puts "ISBN: #{book[:isbn]}"
      puts "Authors: #{book[:authors]}"
      puts "Description: #{book[:description]}"
      puts "=" * 100 unless @books[i + 1].nil?
    end
  end

  def print_all_magazines
    @magazines.each_with_index do |magazine, i|
      puts "Title: #{magazine[:title]}"
      puts "ISBN: #{magazine[:isbn]}"
      puts "Authors: #{magazine[:authors]}"
      puts "Publication Date: #{magazine[:publishedat]}"
      puts "=" * 100 unless @magazines[i + 1].nil?
    end
  end
end

parser = Parser.new(
  authors_path: "data/authors.csv",
  books_path: "data/books.csv",
  magazines_path: "data/magazines.csv"
)

# p parser.find_book_by_isbn("2145-8548-3325")
# p parser.find_magazine_by_isbn("2365-8745-7854")
parser.print_all_books
