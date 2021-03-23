require 'rails_helper'

RSpec.describe BooksHelper, type: :helper do
  describe "#show_book_image" do
    subject { show_book_image(book) }
    context "when arg is ok" do
      let(:book){ create :book }
      # imgタグが生成されることの保証はできている
      # ただし、imageを入れていないため、画像が正しくある場合どうするか保証できていない
      it { expect(subject).to match("<img") }
    end
  end

  describe "#show_book_small_image" do
    subject { show_book_small_image(book) }
    context "when arg is ok" do
      let(:book){ create :book }
      # imgタグが生成されることの保証はできている
      # ただし、imageを入れていないため、画像が正しくある場合どうするか保証できていない
      it { expect(subject).to match("<img") }
    end
  end
end
