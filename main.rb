require "csv"

authors = CSV.read(
  "data/authors.csv",
  headers: true,
  header_converters: :symbol,
  col_sep: ";"
).map(&:to_h)

books = CSV.read(
  "data/books.csv",
  headers: true,
  header_converters: :symbol,
  col_sep: ";"
).map(&:to_h)

magazines = CSV.read(
  "data/magazines.csv",
  headers: true,
  header_converters: :symbol,
  col_sep: ";"
).map(&:to_h)

books.each_with_index do |book, i|
  puts "Title: #{book[:title]}"
  puts "ISBN: #{book[:isbn]}"
  puts "Authors: #{book[:authors]}"
  puts "Description: #{book[:description]}"
  puts "=" * 100 unless books[i + 1].nil?
end

magazines.each_with_index do |magazine, i|
  puts "Title: #{magazine[:title]}"
  puts "ISBN: #{magazine[:isbn]}"
  puts "Authors: #{magazine[:authors]}"
  puts "Publication Date: #{magazine[:publishedat]}"
  puts "=" * 100 unless magazines[i + 1].nil?
end