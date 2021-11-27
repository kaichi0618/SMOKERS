require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nicknameが空だと登録できない" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nicknameを入力してください")
    end
    it "first_nameが空だと登録できない" do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First_name can't be blank")
    end
    it "last_nameが空だと登録できない" do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last_name can't be blank")
    end
    it "emailが空だと登録できない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "emailに一意性がないと登録できない" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "パスワードが空欄だと登録できない" do
      @user = build(:user, password: nil)
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it "パスワードが6文字以上であれば登録できる" do
      password = Faker::Internet.password(min_length: 6, max_length: 6)
      @user = build(:user, password: password, password_confirmation: password)
      expect(@user).to be_valid
    end

    it "パスワードが5文字以下だと登録できない" do
      password = Faker::Internet.password(min_length: 5, max_length: 5)
      @user = build(:user, password: password, password_confirmation: password)
      @user.valid?
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "パスワードと確認が一致していないと登録できない" do
      @user = build(:user, password_confirmation: "")
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end
end
