require 'rails_helper'
include SessionsHelper ## ここ
RSpec.describe Human, type: :model do
  # name と email と passwordを保持していることが正である
  it "is valid with a name ,email and password" do
     expect(FactoryBot.create(:human)).to be_valid
     # オブジェクトをexpectに渡した時に、有効である(be valid)という意味になります
  end
  
  # name が無いと無効である
  it "is invalid without a name" do
     expect(FactoryBot.build(:human, name: "")).to_not be_valid 
  end
  
  # emailの形式が正しくないと無効である
  it "is invalid without a valid format email" do
    expect(FactoryBot.build(:human).email)
    .to match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i)
  end
  
  # name が50文字以内でないと無効である
  it "is invalid with a name length over 50" do
     expect(FactoryBot.build(:human, name: "1"*60)).to_not be_valid 
  end

  # emailが重複していた場合無効である
  it "is invalid without a unique email" do
    # 重複するデータを先にDBに保存しておき、バリデーションエラーを期待する
    Human.create(email: 'foo@example.com')
    human = Human.new(email: 'foo@example.com')
    expect(human).not_to be_valid
  end

  # passwordがない場合無効である
  it "is invalid without a password" do   
    expect(FactoryBot.build(:human, email: " ")).to_not be_valid 
  end
end

RSpec.describe Human, type: :request do
  # Rails5からcontrollerのテストはtype: :controllerではなく、
  # type: :requestで書くことが推奨されているらしい
  # 参考:  https://qiita.com/t2kojima/items/ad7a8ade9e7a99fb4384

  # ログイン済みのユーザーの場合
  context "as an authorized user" do
    # 各example(it〜end)の前に「@user」「(@userの)@task」を作成  
    before do
      @human = FactoryBot.create(:human)
    end

    # 自身を退会させる事ができる事
    it "deletes my account" do
      # destroyメソッドを@humanに対して行い、Humanの数が1つ減ることを確認
      expect {
        @human.destroy
      }.to change(Human, :count).by(-1)
    end 
  end
  # ユーザ退会機能(destroyメソッド)のテスト
  # ユーザを削除したら、ユーザ、記録した物が削除されている事が正
end
