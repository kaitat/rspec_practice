require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#valie' do
    subject { review }
    context 'when review is ok' do
      let(:review) { build :review }
      it {is_expected.to be_valid }
    end

    context ' when title is not ok' do
      let(:review) { build :review, title: nil }
      it {is_expected.to_not be_valid}
    end

    context ' when title is more 50' do
      let(:review) { build :review, title: 'a'*51 }
      it {is_expected.to_not be_valid}
    end

    context ' when body is not ok' do
      let(:review) { build :review, body: nil }
      it {is_expected.to_not be_valid}
    end

    context ' when body is more 500' do
      let(:review) { build :review, body: 'a'*501 }
      it {is_expected.to_not be_valid}
    end

    context ' when body is not ok' do
      let(:review) { build :review, evaluation: nil }
      it {is_expected.to_not be_valid}
    end
  end
end
