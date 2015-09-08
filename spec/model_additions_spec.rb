# encoding: utf-8
require 'spec_helper'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :posts do |t|
    t.string :title
    t.text   :body
    t.text   :note
  end
end

class Post < ActiveRecord::Base
  extend FilterWord::ModelAdditions
  validate_harmonious_of [:title,:body], model: :post
end

describe FilterWord::ModelAdditions do
  let(:post) { @post = Post.create title:'戴秉国在中国',body:'戴秉国在中国',note:'戴秉国在中国' }

  describe 'use local' do
    it 'should validate for harmonious' do
      post.errors[:title].should == ['不能含有敏感词']
    end

    it 'should have error on title' do
      post.errors[:body].should == ['不能含有敏感词']
    end

    it 'should allow empty input value' do
      p = Post.create body:'戴秉国在中国',note:'戴秉国在中国'
      post.errors[:body].should == ['不能含有敏感词']
    end

    it 'should filter! any harmonious words' do
      FilterWord.clean(post.body).should == '***在中国'
    end
  end

end

