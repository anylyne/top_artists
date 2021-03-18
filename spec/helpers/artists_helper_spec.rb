# frozen_string_literal: true

require 'rails_helper'
describe ArtistsHelper, type: :helper do
  describe '#link_attributes' do
    let(:request) { double('request', path: '/') }
    let(:summary) do
      { 'country' => 'Brazil',
        'page' => '200',
        'perPage' => '5',
        'totalPages' => '233602',
        'total' => '1168008' }
    end

    before do
      allow(helper).to receive(:request).and_return(request)
      allow(helper).to receive(:action_name).and_return('index')
    end

    it 'shoud receive the summary and return the ul' do
      expected_ui_component = "<ul id='pagination'><li id='first_link' class=''><a href=\"/?page=1&country=Brazil\"><<</a></li><li id='second_link' class=''><a href=\"/?page=199&country=Brazil\">...</a></li><li id='first_middle_link' class='selected'><a href=\"/?page=200&country=Brazil\">200</a></li><li id='second_middle_link' class=''><a href=\"/?page=201&country=Brazil\">201</a></li><li id='third_middle_link' class=''><a href=\"/?page=202&country=Brazil\">202</a></li><li id='previous_last_link' class=''><a href=\"/?page=203&country=Brazil\">...</a></li><li id='last_link' class=''><a href=\"/?page=233602&country=Brazil\">>></a></li></ul>"
      expect(helper.paginate(summary)).to eq(expected_ui_component)
    end
    it 'shoud receive the summary and present the country name' do
      expect(helper.show_country(summary)).to eq('Brazil')
    end
    describe '' do
      let(:summary) do
        { 'artist' => 'Rihanna',
          'page' => '200',
          'perPage' => '5',
          'totalPages' => '233602',
          'total' => '1168008' }
      end
      it 'shoud receive the summary and present the artist name' do
        expect(helper.show_artist(summary)).to eq('Rihanna')
      end
    end
  end
end
