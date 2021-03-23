require 'rails_helper'

describe ReviewsController, type: :request do

  describe '#create' do
    # routes.rb
    # resources :books do
    #   resources :reviews, except: :index
    # end

    # エラー ` no route match解消`
    # ネストされているため、book_idをもたせる必要があった
    context 'when send correct params and logined' do
      before do
        # spec/support/controller_macros.rb
        # ログイン
        sign_in user
        post book_reviews_path book_id, params: { book_id: book_id, review: { title: 'テスト変更', body: 'テスト・テスト変更', evaluation: 1, book_id: book_id } }
      end
      let!(:user) { create :user }
      let(:book) { create :book }
      let(:book_id) { book.id }
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(book_path(book)) }
    end
  end

  describe '#show' do
    # no match error出ていた
    # rails routesを見たところ、`/books/:book_id/reviews/:id`となっていたため、book_idを渡したところ通った
    # rails routes見るの大事、
    before { get book_review_path book_id, review_id, params: { book_id: book_id, id: review_id } }
    context 'when send correct params' do
      let(:review) { create :review }
      let(:review_id) { review.id }
      let(:book_id) { review.book.id }
      it { expect(response).to have_http_status(:ok) }
    end
  end

  describe '#edit' do
    before { get edit_book_review_path book_id, review_id }
    context 'when send correct params' do
      let(:review) { create :review }
      let(:review_id) { review.id }
      let(:book_id) { review.book.id }
      it { expect(response).to have_http_status(:ok) }
    end
  end

  describe '#update' do
    context 'when send corect params' do
      before do
        sign_in user
        patch book_review_path book_id, review_id, params: { id: review_id, review: { title: 'テスト変更', body: 'テスト・テスト変更', evaluation: 1,} }
      end
      let!(:user) { create :user }
      let(:review) { create :review }
      let(:review_id) { review.id }
      let(:book_id) { review.book.id }
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(book_path(book_id)) }
    end
  end

  describe '#destroy' do
    context 'when send corect params' do
      before do
        sign_in user
        delete book_path book_id, review_id
      end
      let!(:user) { create :user }
      let(:review) { create :review }
      let(:review_id) { review.id }
      let(:book_id) { review.book.id }
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to books_path }
    end
  end
end
