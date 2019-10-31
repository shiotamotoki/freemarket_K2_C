require 'rails_helper'
describe User do
  describe '#create' do
    context 'can`t save' do
      example "nicknameが空の場合、保存できない" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end

      example "e-mailが空の場合、保存できない" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      example "passwordが空の場合、保存できない" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
    end

    context 'can save' do
      example "nicknameとpasswordとemailがあると、保存できる" do
        expect(build(:user)).to be_valid
      end
    end 
  end
end