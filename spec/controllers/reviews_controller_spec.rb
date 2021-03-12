require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  describe '#create' do
    subject { post :create, params: { book_id: book_id, review: { title: 'テスト変更', body: 'テスト・テスト変更', evaluation: 1, book_id: book_id } } }
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
        login_user(user)
      end
      let!(:user) { create :user }
      let(:book) { create :book }
      let(:book_id) { book.id }
      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(book_path(book)) }
    end

    # ログインしていないバージョンを書こうと思った
    # そもそもその機能がなかった、追記すべき(一旦飛ばして他を書いていく)
    # 現状ログインしていない状態でレビュー投稿のユーザ導線はない
    # TODO: 見る
    xcontext 'when send correct params and not logined' do
      let(:user) { create :user }
      let(:book) { create :book }
      let(:book_id) { book.id }
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe '#show' do
    # no match error出ていた
    # rails routesを見たところ、`/books/:book_id/reviews/:id`となっていたため、book_idを渡したところ通った
    # rails routes見るの大事、
    subject { get :show, params: { book_id: book_id, id: review_id } }
    context 'when send correct params' do
      let(:review) { create :review }
      let(:review_id) { review.id }
      let(:book_id) { review.book.id }
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe '#edit' do
    subject { get :edit, params: { book_id: book_id, id: review_id } }
    context 'when send correct params' do
      let(:review) { create :review }
      let(:review_id) { review.id }
      let(:book_id) { review.book.id }
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe '#update' do
    subject { patch :update, params: { book_id: book_id, id: review_id, review: { title: 'テスト変更', body: 'テスト・テスト変更', evaluation: 1, book_id: book_id } } }
    context 'when send corect params' do
      before do
        login_user(user)
      end
      let!(:user) { create :user }
      let(:review) { create :review }
      let(:review_id) { review.id }
      let(:book_id) { review.book.id }
      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(book_path(book_id)) }
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: { book_id: book_id, id: review_id } }
    context 'when send corect params' do
      before do
        login_user(user)
      end
      let!(:user) { create :user }
      let(:review) { create :review }
      let(:review_id) { review.id }
      let(:book_id) { review.book.id }
      it { is_expected.to have_http_status(302) }
      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(book_path(book_id)) }
    end
  end
end
