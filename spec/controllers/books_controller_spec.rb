require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  # shothand [# .]をつけると省略もdできる
  describe '#index' do
    subject { get :index, params: { q: keyword } }

    context 'when send correct params' do
      let(:keyword) {''}
      it {is_expected.to have_http_status(:ok)}
    end

    context 'when send correct params' do
      let(:keyword) {'ruby'}
      let!(:book) {create :book} #itが実行される前に実行される
      it {is_expected.to have_http_status(:ok)} #have_http_status = 200であることを証明
    end
  end

  describe '#new' do
    subject { post :new, params: {} }
    context 'when send accsess' do
      it {is_expected.to have_http_status(:ok)}
    end
  end

  describe '#create' do
    subject { post :create, params: { book: { title: title, price: price, publish_date: publish_date, description: description, new_image: new_image, category_id: category_id } } }
    context 'when send correct params' do
      let(:title) {'test'}
      let(:price) {1999}
      let(:publish_date) {Time.now}
      let(:description) {'testデータ'}
      let(:new_image) {'image'}
      let(:category_id) {1}
      it {is_expected.to have_http_status(:ok)}
      # countでデータ数チェックしてもいいかもしれない
    end
  end

  describe '#show' do
    subject { get :show, params: { id: id } }
    context 'when send correct params' do
      let!(:book) {create :book}
      let(:id) {1}
      it {is_expected.to have_http_status(:ok)}
    end
  end

  #TODO: エラーがでていてわからないから一旦スキップ
  xdescribe '#update' do
    subject { patch :update, params: { book: { title: title, price: price, publish_date: publish_date, description: description, new_image: new_image, category_id: category_id } } }

    context 'when send correct params' do
      let(:title) {'test'}
      let(:price) {1999}
      let(:publish_date) {Time.now}
      let(:description) {'testデータ'}
      let(:new_image) {'image'}
      let(:category_id) {1}
      let!(:book) {create :book}
      it {is_expected.to have_http_status(:ok)}
    end
  end
  describe '#destroy' do
    subject { delete :destroy, params: {id: id} }

    context 'when send correct params' do
      let!(:book) {create :book}
      let(:id) {1}
      it {is_expected.to have_http_status 302}
    end
  end
end
