# frozen_string_literal: true

describe ArtistsHelper, type: :helper do
  describe '#initial_link_attributes' do
    it 'shoud receive the current_page and return the first_index, second_link and third_link attributes' do
      expect(helper.initial_link_attributes('1')).to eq([2, %w[1 1 selected], %w[2 2]])
      expect(helper.initial_link_attributes('2')).to eq([2, ['1', '...'], %w[2 2 selected]])
      expect(helper.initial_link_attributes('3')).to eq([3, ['2', '...'], %w[3 3 selected]])
      expect(helper.initial_link_attributes('4')).to eq([4, ['3', '...'], %w[4 4 selected]])
      expect(helper.initial_link_attributes('5')).to eq([5, ['4', '...'], %w[5 5 selected]])
    end
  end
  describe '#li_component' do
    let(:request) { double('request', path: '/') }
    before do
      allow(helper).to receive(:request).and_return(request)
      allow(helper).to receive(:action_name).and_return('index')
    end
    it 'shoud receive the link_attribute and return the li - first_link' do
      expected_li = "<li id='first_link' class=''><a href=\"/?page=1&amp;country=Brazil\">&lt;&lt;</a></li>"
      expect(helper.li_component(['first_link', ['1', '<<']], 'Brazil')).to eq(expected_li)
    end
    it 'shoud receive the link_attribute and return the li - second_link' do
      expected_li = "<li id='second_link' class='selected'><a href=\"/?page=1&amp;country=Brazil\">1</a></li>"
      expect(helper.li_component(['second_link', %w[1 1 selected]], 'Brazil')).to eq(expected_li)
    end
    it 'shoud receive the link_attribute and return the li - third_link' do
      expected_li = "<li id='first_middle_link' class=''><a href=\"/?page=2&amp;country=Brazil\">2</a></li>"
      expect(helper.li_component(['first_middle_link', %w[2 2]], 'Brazil')).to eq(expected_li)
    end
  end
  describe '#link_path' do
    let(:request) { double('request', path: '/') }
    before do
      allow(helper).to receive(:request).and_return(request)
    end
    context 'action_name == index' do
      before { allow(helper).to receive(:action_name).and_return('index') }
      it 'shoud return the correct link_path' do
        expect(helper.link_path('1', 'Brazil')).to eq('/?page=1&country=Brazil')
      end
    end
    context 'action_name == show' do
      before { allow(helper).to receive(:action_name).and_return('show') }
      it 'shoud return the correct link_path' do
        expect(helper.link_path('1', nil)).to eq('/?page=1')
      end
    end
  end
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

    it 'shoud receive the summary and a hash with the link_attributes' do
      expect_hash = {
        'first_link' => ['1', '<<'],
        'first_middle_link' => %w[200 200 selected],
        'last_link' => ['233602', '>>'],
        'previous_last_link' => ['203', '...'],
        'second_link' => ['199', '...'],
        'second_middle_link' => %w[201 201],
        'third_middle_link' => %w[202 202]
      }
      expect(helper.link_attributes(summary)).to eq(expect_hash)
    end
  end
end
