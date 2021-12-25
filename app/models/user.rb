class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :items
  # has_many :orders

  with_options presence: true do
    # ニックネームがニックネームが必須かつ一意性であること
    validates :nickname

    # パスワードを入力した際に、半角英数字（空文字NG）以外の場合は、メッセージを表示
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'

    # お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/ }

    # お名前カナ(全角)は、全角（カタカナ）での入力が必須
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }

    # 生年月日が必須
    validates :birthday
  end
end
