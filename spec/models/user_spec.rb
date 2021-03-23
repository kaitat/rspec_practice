require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#valie' do
    subject { user }
    context 'when user is ok' do
      let(:user) { build :user }
      it {is_expected.to be_valid }
    end

    context ' when email is nil' do
      let(:user) { build :user, email: nil }
      it {is_expected.to_not be_valid}
    end

    context ' when password is nil' do
      let(:user) { build :user, password: nil }
      it {is_expected.to_not be_valid}
    end

    context 'when password_confirmation is not password' do
      let(:user) { build :user, password_confirmation: 'password_test' }
      it { is_expected.to_not be_valid }
    end

    context ' when nick_name is nil' do
      let(:user) { build :user, nick_name: nil }
      it {is_expected.to be_valid}
    end
  end
end
