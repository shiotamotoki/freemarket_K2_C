require 'rails_helper'
describe Personal_Information do
  describe '#create' do
    context 'can`t save' do
      example "first_nameが空の場合、保存できない" do
        personal_information = build(:personal_information, first_name: nil)
        personal_information.valid?
        expect(personal_information.errors[:first_name]).to include("を入力してください")
      end

      example "first_nameが35文字以上の場合、保存できない" do
        personal_information = build(:personal_information, first_name: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        personal_information.valid?
        expect(personal_information.errors[:first_name]).to include("は35文字以内で入力してください")
      end

      example "last_nameが空の場合、保存できない" do
        personal_information = build(:personal_information, last_name: nil)
        personal_information.valid?
        expect(personal_information.errors[:last_name]).to include("を入力してください")
      end

      example "last_nameが35文字以上の場合、保存できない" do
        personal_information = build(:personal_information, last_name: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        personal_information.valid?
        expect(personal_information.errors[:last_name]).to include("は35文字以内で入力してください")
      end

      example "first_name_kanaが空の場合、保存できない" do
        personal_information = build(:personal_information, first_name_kana: nil)
        personal_information.valid?
        expect(personal_information.errors[:first_name_kana]).to include("を入力してください")
      end

      example "first_name_kanaが35文字以上の場合、保存できない" do
        personal_information = build(:personal_information, first_name_kana: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
        personal_information.valid?
        expect(personal_information.errors[:first_name_kana]).to include("は35文字以内で入力してください")
      end

      example "first_name_kanaがカタカナ以外の場合、保存できない" do
        personal_information = build(:personal_information, first_name_kana: "a")
        personal_information.valid?
        expect(personal_information.errors[:first_name_kana]).to include("は不正な値です")
      end

      example "last_name_kanaが空の場合、保存できない" do
        personal_information = build(:personal_information, last_name_kana: nil)
        personal_information.valid?
        expect(personal_information.errors[:last_name_kana]).to include("を入力してください")
      end

      example "last_name_kanaが35文字以上の場合、保存できない" do
        personal_information = build(:personal_information, last_name_kana: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
        personal_information.valid?
        expect(personal_information.errors[:last_name_kana]).to include("は35文字以内で入力してください")
      end

      example "last_name_kanaがカタカナ以外の場合、保存できない" do
        personal_information = build(:personal_information, last_name_kana: "a")
        personal_information.valid?
        expect(personal_information.errors[:last_name_kana]).to include("は不正な値です")
      end

      example "birthが空の場合、保存できない" do
        personal_information = build(:personal_information, birth: nil)
        personal_information.valid?
        expect(personal_information.errors[:birth]).to include("を正しく入力してください")
      end
    end

    context 'can save' do
      example "first_nameとlast_nameとfirst_name_kanaとlast_name_kanaとbirthがあると、保存できる" do
        expect(build(:personal_information)).to be_valid
      end
    end
  end
end