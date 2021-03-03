require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#valie' do
    subject { user }
    context 'when user is ok' do
      let(:user) { build :user }
      it {is_expected.to be_valid }
    end

    context ' when email is not ok' do
      let(:user) { build :user, email: nil }
      it {is_expected.to_not be_valid}
    end

    context ' when password is not ok' do
      let(:user) { build :user, password: nil }
      it {is_expected.to_not be_valid}
    end

    context ' when nick_name is not ok' do
      let(:user) { build :user, nick_name: nil }
      it {is_expected.to be_valid}
    end
  end
end
