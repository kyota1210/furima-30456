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
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '既に登録されているemailでは登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'emailに@が含まれていなければ登録できないこと' do
        @user.email = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下では登録できないこと' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'passwordが半角数字のみの場合は登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'passwordが半角英字のみの場合は登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'password_cofirmationが空では登録できないこと' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordとpassword_confirmationが一致しなければ登録できないこと' do
        @user.password = 'a12345'
        @user.password_confirmation = 'b12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("性を入力してください")
      end
      it 'last_nameが空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名を入力してください")
      end
      it 'first_nameが全角入力でなければ登録できないこと' do
        @user.first_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include("性は全角（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'last_nameが全角入力でなければ登録できないこと' do
        @user.last_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名は全角（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'read_first_nameが空では登録できないこと' do
        @user.read_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("セイを入力してください")
      end
      it 'read_last_nameが空では登録できないこと' do
        @user.read_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メイを入力してください")
      end
      it 'read_first_nameが全角カタカナでなければ登録できないこと' do
        @user.read_first_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include("セイは全角（カタカナ）で入力してください")
      end
      it 'read_last_nameが全角カタカナでなければ登録できないこと' do
        @user.read_last_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include("メイは全角（カタカナ）で入力してください")
      end
      it 'birthdayが空では登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
