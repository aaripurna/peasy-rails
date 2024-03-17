module ApplicationHelper
  def not_funny_is_it(var)
    "#{var} is not funny"
  end

  def full_name(name)
    [
      name['title'],
      name['first'],
      name['last']
    ].join(' ')
  end

  def pagination_view(pagination) # rubocop:disable Metrics/MethodLength
    current_page = pagination['page']
    total_page = pagination['pages']
    html = String.new
    html += first_page_tag(current_page)

    PaginationSeriesService.new(current_page:, total_page:).each do |page|
      if page == :gap
        html += %(<span class="p-3 border-solid border-2 mx-1 rounded-lg inline-block">...</span>)
        next
      end

      html += if page == current_page
                %(<span class="p-3 border-solid border-2 mx-1 rounded-lg inline-block">#{page}</span>)
              else
                %(<a class="border-emerald-200 hover:bg-emerald-200 p-3 border-solid border-2 mx-1 rounded-lg inline-block" href="#{root_path(page:)}">#{page}</a>)
              end
    end

    html += last_page_tag(current_page, total_page)

    html
  end

  def first_page_tag(current_page)
    if current_page == 1
      '<span class="p-3 border-solid border-2 mx-1 rounded-lg inline-block"><<</span>'
    else
      %(<a class="border-emerald-200 p-3 border-solid border-2 mx-1 rounded-lg inline-block" href="#{root_path(page: 1)}"><<</a>)
    end
  end

  def last_page_tag(current_page, total_page)
    if current_page == total_page
      '<span class="p-3 border-solid border-2 mx-1 rounded-lg inline-block">>></span>'
    else
      %(<a class="border-emerald-200 p-3 border-solid border-2 mx-1 rounded-lg inline-block" href="#{root_path(page: total_page)}">>></a>)
    end
  end
end
