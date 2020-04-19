require 'rails_helper'

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

  it "is invalid without a unique email"      # emailが重複していた場合無効である
  it "is invalid without a password"      # passwordがない場合無効である
end
