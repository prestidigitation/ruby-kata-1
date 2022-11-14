require "csv"

class MainProgram
  attr_reader :books, :magazines
  def initialize(authors_path:, books_path:, magazines_path:)
    @authors = Parser.new(file_path: authors_path).parsed_object
    @books = Parser.new(file_path: books_path).parsed_object
    @magazines = Parser.new(file_path: magazines_path).parsed_object
  end

  def find_book_by_isbn(isbn)
    books.find { |book| book[:isbn] == isbn}
  end
  
  def find_magazine_by_isbn(isbn)
    magazines.find { |magazine| magazine[:isbn] == isbn }
  end

  def find_all_books_by_author_email(email)
    books.select { |book| book[:authors].include?(email) }
  end

  def find_all_magazines_by_author_email(email)
    magazines.select { |magazine| magazine[:authors].include?(email) }
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

  def print_all_book_info(books)
    books.each_with_index do |book, i|
      print_book_info(book)
      puts "=" * 100 unless books[i + 1].nil?
    end
  end

  def print_all_magazine_info(magazines)
    magazines.each_with_index do |magazine, i|
      print_magazine_info(magazine)
      puts "=" * 100 unless magazines[i + 1].nil?
    end
  end

  def print_all_book_and_magazine_info_sorted
    sorted_books = books.sort_by { |book| book[:title]}
    print_all_book_info(sorted_books)
    puts "\n"
    sorted_magazines = magazines.sort_by { |magazine| magazine[:title] }
    print_all_magazine_info(sorted_magazines)
  end
end

class Parser
  attr_reader :parsed_object
  def initialize(file_path:)
    @parsed_object = parse_file(file_path)
  end

  private

  def parse_file(file_path)
    CSV.read(
      file_path,
      headers: true,
      header_converters: :symbol,
      col_sep: ";"
    ).map(&:to_h)
  end
end

# p parser.find_magazine_by_isbn("2365-8745-7854")
# parser.print_all_book_info
# p parser.find_all_books_by_author_email("")
# p parser.find_all_books_by_author_email("null-rabe@echocat.org").map { |book| book[:title] }
# p parser.books
# p parser.books.reduce([]) { |acc, book| acc.append(book[:authors]) }
# parser.print_all_book_and_magazine_info_sorted
