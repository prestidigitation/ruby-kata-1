require "csv"

class Parser
  attr_reader :books
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

  def find_all_books_by_author_email(email)
    @books.select { |book| book[:authors].include?(email) }
  end

  def find_all_magazines_by_author_email(email)
    @magazines.select { |magazine| magazine[:authors].include?(email) }
  end

  def print_book_info(book)
    puts "Title: #{book[:title]}"
    puts "ISBN: #{book[:isbn]}"
    puts "Authors: #{book[:authors]}"
    puts "Description: #{book[:description]}"
  end

  def print_magazine_info(magazine)
    puts "Title: #{magazine[:title]}"
    puts "ISBN: #{magazine[:isbn]}"
    puts "Authors: #{magazine[:authors]}"
    puts "Publication Date: #{magazine[:publishedat]}"
  end

  def print_all_book_info
    @books.each_with_index do |book, i|
      print_book_info(book)
      puts "=" * 100 unless @books[i + 1].nil?
    end
  end

  def print_all_magazine_info
    @magazines.each_with_index do |magazine, i|
      print_magazine_info(magazine)
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
parser.print_all_book_info
# p parser.find_all_books_by_author_email("")
# p parser.find_all_books_by_author_email("null-rabe@echocat.org").map { |book| book[:title] }
# p parser.books
# p parser.books.reduce([]) { |acc, book| acc.append(book[:authors]) }
