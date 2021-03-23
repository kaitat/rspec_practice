require 'rails_helper'

# rails ガイド コントローラの機能テストより
# なんのテストをすると良いか
# Webリクエストが成功したか
# 正しいページにリダイレクトされたか
# ユーザ認証が成功したか
# レスポンスのテンプレートに正しいオブジェクトが保存されたか
# ビューに表示されたメッセージは適切化

describe BooksController, type: :request do
  describe '#index' do
    before { get books_path, params: { q: { title_or_description_cont: keyword } } }
    context 'when request is ok' do
      let(:keyword) { '' }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when send correct params' do
      let(:keyword) { 'プロを目指す人のためのRuby入門' }
      let!(:book) {create :book}
      it {
        expect(response.body).to include book.title
        expect(response).to have_http_status(:ok)
      }
    end
  end

  describe '#new' do
    before { get new_book_path, params: {} }
    context 'when send accsess' do
      it {expect(response).to have_http_status(:ok)}
    end
  end

  describe '#create' do
    context 'when send correct params' do
      let(:title) {'test'}
      let(:price) {1999}
      let(:publish_date) {Time.now}
      let(:description) {'testデータ'}
      let!(:category) {create :category}
      let(:category_id) { category.id }
      it {
        post books_path, params: { book: { title: title, price: price, publish_date: publish_date, description: description, category_id: category_id } }
        expect(response).to have_http_status(302)}
      # ↓↓解決 category_idに直接数値いれていたためエラーでていた
      #createの @book.saveができていない
      # なので、countも増えないし、リダイレクトもしていない
      it {
        expect{
          post books_path, params: { book: { title: title, price: price, publish_date: publish_date, description: description, category_id: category_id } }
        }.to change(Book, :count).by(1)}
      it {
        post books_path, params: { book: { title: title, price: price, publish_date: publish_date, description: description, category_id: category_id } }
        expect(response).to redirect_to book_path Book.last}
    end

    context 'when send only title param' do
      let(:title) {'test'}
      it {
        post books_path, params: { book: {title: title} }
        expect(response).to have_http_status(:ok)}
      it {
        expect{
          post books_path, params: { book: {title: title} }
        }.to change(Book, :count).by(0)}
    end
  end

  describe '#show' do
    before { get book_path book_id }
    context 'when send correct params' do
      let!(:book) { create :book }
      let(:book_id) { book.id }
      it {
        expect(response).to have_http_status(:ok)
        expect(response.body).to include "<h2>#{book.title}</h2>"
      }
    end
  end

  describe '#update' do

    context 'when send correct params' do
      let(:title) {'test'}
      let(:price) {1999}
      let(:publish_date) {Time.now}
      let(:description) {'testデータ'}
      let!(:category) {create :category}
      let(:category_id) { category.id }
      let(:book) {create :book}
      let(:book_id) { book.id }

      # changeを使う時は"expect(ここ)"にブロックで渡さないといけない
      # そこで、lamdaを使うとjsでいう無名関数みたいなことができるため、それで解決させる
      # ちなみにexpect{}これでかけば解決する
      # ↑でかいけつできないsubjectは"->"をつかう
      it {expect(
        -> {patch book_path book_id, params: { id: book_id, book: { title: title, price: price, publish_date: publish_date, description: description, category_id: category_id } } }
      ).to change{Book.find(book_id).title}.from('プロを目指す人のためのRuby入門').to('test')}

      it {
        patch book_path book_id, params: { id: book_id, book: { title: title, price: price, publish_date: publish_date, description: description, category_id: category_id } }
        expect(response).to have_http_status(302)}


      it {expect(
        patch book_path book_id, params: { id: book_id, book: { title: title, price: price, publish_date: publish_date, description: description, category_id: category_id } }
      ).to redirect_to book_path book_id}
    end
  end
  describe '#destroy' do

    context 'when send correct params' do
      let!(:book) {create_list :book, 3}
      # リクエスト送るとBookデータが一つ減ること
      it {expect{
        delete book_path book[0].id
      }.to change(Book, :count).by(-1)}

      it {
        delete book_path book[1].id
        expect(response).to have_http_status 302 }

      # /booksにリダイレクトする
      it {
        delete book_path book[2].id
        expect(response).to redirect_to books_path }
    end
  end
end
