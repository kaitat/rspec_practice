require 'rails_helper'

# 基本形
# describe '#テスト対象'
#   subject { テスト内容 }
#   context '〇〇のとき/場合' do
#     it '〇〇であること' do
#       検証内容
# contextはrubocopを通したあとwith, whenが引数でないとエラー出す

describe Book, type: :model do
  describe "#valid?" do
    subject { book }
    context "when book is ok" do
      let(:book){ build :book }
      it { is_expected.to be_valid }
    end
    context "when title is not ok" do
      let(:book){ build :book, title: nil }
      it { is_expected.to_not be_valid }
    end
    context "when title is more 50" do
      let(:book){ build :book, title: 'a'*51 }
      it { is_expected.to_not be_valid }
    end

    context "when price is not ok" do
      let(:book){ build :book, price: nil }
      it { is_expected.to_not be_valid }
    end

    context "when price is not more 0" do
      let(:book){ build :book, price: 0 }
      it { is_expected.to_not be_valid }
    end

    context "when publish_date is not ok" do
      let(:book){ build :book, publish_date: nil }
      it { is_expected.to_not be_valid }
    end
    context "when description is not ok" do
      let(:book){ build :book, description: nil }
      it { is_expected.to_not be_valid }
    end
    context "when description is more 1000" do
      let(:book){ build :book, description: 'a'*1001 }
      it { is_expected.to_not be_valid }
    end
  end
end
