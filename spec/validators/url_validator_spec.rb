require 'rails_helper'

RSpec.describe UrlValidator do
  subject(:dummy_model) { Dummy.new(url: url) }

  class Dummy
    include ActiveModel::Model
    attr_accessor :url

    validates :url, url: true
  end

  context 'when the url is valid' do
    let(:url) { 'http://www.example.com' }

    it { is_expected.to be_valid }
  end

  context 'when the url is invalid' do
    let(:url) { 'invalid' }

    it { is_expected.to be_invalid }
  end

  context 'when the url is blank' do
    let(:params) { [nil, ''] }

    it 'is invalid' do      
      params.each do |param|
        expect(Dummy.new(url: param)).to be_invalid
      end
    end
  end
end
