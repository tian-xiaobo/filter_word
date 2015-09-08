# encoding: utf-8

require 'spec_helper'

describe FilterWord do

  describe 'local' do
    describe 'segment' do
      it 'should return harmonious word for sentence' do
        FilterWord.harmonious_words('戴秉国在中国').should == ['戴秉国']
      end

      it 'should return harmonious word for sentence under have model param' do
        FilterWord.harmonious_words('戴秉国在中国', 'user').should == ['戴秉国']
      end

      it 'should return english,url and chinese words' do
        FilterWord.harmonious_words('戴秉国 in china,watch cctv.com.let fuck it','user').should == ['戴秉国','fuck']
      end

      it 'should return english  words under have model param' do
        FilterWord.harmonious_words('Gruepin','user').should == ['Gruepin']
      end

    end

    it 'should find harmonious chinese  words' do
      FilterWord.clean?('李源潮在中国').should == false
    end

    it 'should find harmonious chinese words under have model param' do
      FilterWord.clean?('李源潮在中国', 'user').should == false
    end

    it 'should pass good words' do
      FilterWord.clean?('过去').should == true
    end

    it 'should pass good words under have model param' do
      FilterWord.clean?('过去', 'user').should == true
    end

    it 'should clean sentence by replace harmonious words by *' do
      FilterWord.clean('戴秉国在中国').should == '***在中国'
    end

    it 'should clean sentence by replace harmonious words by * under model param' do
      FilterWord.clean('戴秉国在中国', 'user').should == '***在中国'
    end

    it 'should replace harmonious with *' do
      FilterWord.clean_word_basic('大米').should == '**'
    end
  end

end
