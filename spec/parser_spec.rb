require_relative "../main"

describe MainProgram do
  describe "#find_book_by_isbn" do
    context "given an ISBN" do
      isbn = "2145-8548-3325"
      
      it "searches for and returns the respective book's info" do
        parser = create_program_instance
        response = parser.find_book_by_isbn(isbn)
        expect(response.title).to eq "Das große GU-Kochbuch Kochen für Kinder"
      end

      it "returns nil when it can't find a book" do
        parser = create_program_instance
        response = parser.find_book_by_isbn("555555555555555")
        expect(response).to be_nil
      end
    end
  end

  describe "#find_magazine_by_isbn" do
    context "given an ISBN" do
      isbn = "2365-8745-7854"
      it "searches for and returns the respective magazine's info" do
        parser = create_program_instance
        response = parser.find_magazine_by_isbn(isbn)
      end
    end
  end

  describe "#find_all_books_by_author_email" do
    context "given an author's email" do
      email = "null-rabe@echocat.org"
      it "returns all books with that author's email" do
        parser = create_program_instance
        response = parser.find_all_books_by_author_email(email)
        titles = response.map { |item| item.title }
        expect(titles).to contain_exactly(
          "Das Piratenkochbuch. Ein Spezialitätenkochbuch mit den 150 leckersten Rezepten ",
          "Genial italienisch"
        )
      end
    end
  end

  xdescribe "#find_all_magazines_by_author_email" do
  end

  describe "#find_all_books_and_magazines_by_author_email" do
    context "given an author's email" do
      email = "null-gustafsson@echocat.org"
      it "finds all books and magazines with that author's email" do
        parser = create_program_instance
        response = parser.find_all_books_and_magazines_by_author_email(email)
        # p response
        # p response.size
      end
    end
  end
end

private

def create_program_instance
  MainProgram.new(
    authors_path: "data/authors.csv",
    books_path: "data/books.csv",
    magazines_path: "data/magazines.csv"
  )
end
