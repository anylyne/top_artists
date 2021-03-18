class Paginator
  def initialize(summary, path = '/', action_name = 'index')
    @summary = summary
    @path = path
    @action_name = action_name
  end

  def paginate
    element = "<ul id='pagination'>"
    link_attributes.each do |item|
      element << li_component(item, @summary['country'])
    end
    element << '</ul>'
    element.html_safe
  end

  # a hash with page, id, item_selected, text, value
  def link_attributes
    first_index, second_link, third_link = initial_link_attributes(@summary['page'])
    {
      'first_link' => ['1', '<<'],
      'second_link' => second_link,
      'first_middle_link' => third_link,
      'second_middle_link' => [(first_index += 1).to_s, first_index.to_s],
      'third_middle_link' => [(first_index += 1).to_s, first_index.to_s],
      'previous_last_link' => [(first_index + 1).to_s, '...'],
      'last_link' => [@summary['totalPages'], '>>']
    }
  end

  def initial_link_attributes(current_page)
    first_index = current_page.to_i
    if current_page != '1'
      first_index -= 1
      second_link = [first_index.to_s, '...']
      third_link = [(first_index += 1).to_s, first_index.to_s, 'selected']
    else
      second_link = [current_page, current_page, 'selected']
      third_link = [(first_index += 1).to_s, first_index.to_s]
    end
    [first_index, second_link, third_link]
  end

  def li_component(item, country)
    element = "<li id='#{item[0]}' class='#{item[1][2]}'>"
    element << "<a href=\"#{link_path(item[1][0], country)}\">#{item[1][1]}</a>"
    element << '</li>'
  end

  def link_path(page, country)
    request_path = "#{@path}?page=#{page}"
    request_path += "&country=#{country}" if @action_name == 'index'
    request_path
  end
end
