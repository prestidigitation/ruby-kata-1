require "csv"

class MainProgram
  attr_reader :books, :magazines
  def initialize(authors_path:, books_path:, magazines_path:)
    # @authors = Parser.new(file_path: authors_path).structured_data
    @books = Parser.new(file_path: books_path).structured_data
    @magazines = Parser.new(file_path: magazines_path).structured_data
  end

  def find_book_by_isbn(isbn)
    books.find { |book| book.isbn == isbn }
  end

  def find_magazine_by_isbn(isbn)
    magazines.find { |magazine| magazine.isbn == isbn }
  end

  def find_all_books_by_author_email(email)
    books.select { |book| book.authors.include?(email) }
  end

  def find_all_magazines_by_author_email(email)
    magazines.select { |magazine| magazine.authors.include?(email) }
  end

  def find_all_books_and_magazines_by_author_email(email)
    books = find_all_books_by_author_email(email)
    magazines = find_all_magazines_by_author_email(email)
    books.concat(magazines)
  end

  def print_book_info(book)
    puts "Title: #{book.title}"
    puts "ISBN: #{book.isbn}"
    puts "Authors: #{book.authors}"
    puts "Description: #{book.description}"
  end

  def print_magazine_info(magazine)
    puts "Title: #{magazine.title}"
    puts "ISBN: #{magazine.isbn}"
    puts "Authors: #{magazine.authors}"
    puts "Publication Date: #{magazine.published_on}"
  end

  def print_all_book_info(books)
    books.each_with_index do |book, i|
      print_book_info(book)
      puts "=" * 100 unless books[i + 1].nil?
    end
  end

  def all_authors(collection)
    collection.reduce([]) { |acc, item| acc << item.authors }
  end

  def print_all_magazine_info(magazines)
    magazines.each_with_index do |magazine, i|
      print_magazine_info(magazine)
      puts "=" * 100 unless magazines[i + 1].nil?
    end
  end

  def print_all_book_and_magazine_info_sorted
    sorted_books = books.sort_by { |book| book.title }
    print_all_book_info(sorted_books)
    puts "\n"
    sorted_magazines = magazines.sort_by { |magazine| magazine.title }
    print_all_magazine_info(sorted_magazines)
  end
end

class Parser
  attr_reader :csv, :structured_data, :type, :book_struct
  def initialize(file_path:)
    @type = file_path.split(/[\/.]/)[1]
    @csv = parse_file_into_csv_object(file_path)
    @structured_data = transform_csv_object_into_struct
  end

  def parse_file_into_csv_object(file_path)
    CSV.read(
      file_path,
      headers: true,
      header_converters: :symbol,
      col_sep: ";"
    )
  end

  # Struct.new("Author", :something)
  Book = Struct.new(:title, :isbn, :authors, :description)
  Magazine = Struct.new(:title, :isbn, :authors, :published_on)
  def transform_csv_object_into_struct
    if type == "books"
      csv.reduce([]) do |acc, row|
        acc << Book.new(
          row[:title],
          row[:isbn],
          row[:authors],
          row[:description]
        )
      end
    elsif type == "magazines"
      csv.reduce([]) do |acc, row|
        acc << Magazine.new(
          row[:title],
          row[:isbn],
          row[:authors],
          row[:publishedat]
        )
      end
    # elsif type == "authors"
    #   "something"
    end
  end
end

# parser = Parser.new(file_path: "data/magazines.csv")
program = MainProgram.new(
  authors_path: "data/authors.csv",
  books_path: "data/books.csv",
  magazines_path: "data/magazines.csv"
)

# program.print_all_book_and_magazine_info_sorted
