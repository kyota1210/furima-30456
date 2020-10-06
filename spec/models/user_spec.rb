require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録がうまくいくとき' do
      it 'nickname、email、password、password_confirmation、first_name、last_name、read_first_name、read_last_name、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上かつ半角英数字混合であれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end
    end
    context '新規登録が上手く行かない時' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '既に登録されているemailでは登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が含まれていなければ登録できないこと' do
        @user.email = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できないこと' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英数字混合でなければ登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'password_cofirmationが空では登録できないこと' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが一致しなければ登録できないこと' do
        @user.password = 'a12345'
        @user.password_confirmation = 'b12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end
      it 'last_nameが空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
      end
      it 'first_nameが全角入力でなければ登録できないこと' do
        @user.first_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'last_nameが全角入力でなければ登録できないこと' do
        @user.last_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it 'read_first_nameが空では登録できないこと' do
        @user.read_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first name can't be blank")
      end
      it 'read_last_nameが空では登録できないこと' do
        @user.read_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read last name can't be blank")
      end
      it 'read_first_nameが全角カタカナでなければ登録できないこと' do
        @user.read_first_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Read first name is invalid')
      end
      it 'read_last_nameが全角カタカナでなければ登録できないこと' do
        @user.read_last_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Read last name is invalid')
      end
      it 'birthdayが空では登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
