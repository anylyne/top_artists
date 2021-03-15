module ArtistsHelper
	def pagination_items pagination
		current_page = pagination["page"]
		total_pages = pagination["totalPages"]

		if current_page != "1"
			page_first_index = current_page.to_i - 1
			second_link =	["#{ page_first_index }", "..."]
			middle_link_1 =	["#{ page_first_index += 1 }", "#{ page_first_index }", "selected"]
		else
			page_first_index = current_page.to_i
			second_link = [current_page, current_page, "selected"]
			middle_link_1 =	["#{ page_first_index += 1 }", "#{ page_first_index }"]
		end
		
		# build hash containing page, id, item_selected, text, value 
		{
			'first_link'            => ["1", "<<"],
			'second_link'           => second_link,

			'middle_link_1'         => middle_link_1,
			'middle_link_2'         => ["#{ page_first_index += 1 }", "#{ page_first_index }"],
			'middle_link_3'         => ["#{ page_first_index += 1 }", "#{ page_first_index }"],

			'previous_last_link'    => ["#{ page_first_index += 1 }", "..."],
			'last_link'             => [total_pages, ">>"]
     	}
	end

	def pagination_element pagination_hash
		request_path = request.path
		if action_name == "index"
		  request_path << "?country=#{ pagination_hash['country'] }"
		end
		
		element = "<ul id='pagination'>"
		pagination_items(pagination_hash).each do |item|
			link_page = item[1][0]
			link_id = item[0]
			link_selected = item[1][2]

			link_text = item[1][1]
			link_path = (action_name == "index") ? "#{ request_path }&" : "#{ link_path }?"
			link_path << "page=#{ link_page }"

			element << "<li id='#{ link_id }' class='#{ link_selected }'>"
			element << link_to(link_text, "#{ link_path }")
			element << "</li>"
		end
		element << "</ul>"
		
		return element.html_safe
	end
end
