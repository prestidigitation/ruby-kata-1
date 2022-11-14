require_relative "../main"

describe MainProgram do
  describe "#find_book_by_isbn" do
    context "given an ISBN" do
      it "searches for and returns the respective book's info" do
        parser = create_parser_instance
        response = parser.find_book_by_isbn("2145-8548-3325")
        expect(response[:title]).to eq "Das große GU-Kochbuch Kochen für Kinder"
      end
    end
  end
end

private

def create_parser_instance
  MainProgram.new(
    authors_path: "data/authors.csv",
    books_path: "data/books.csv",
    magazines_path: "data/magazines.csv"
  )
end
