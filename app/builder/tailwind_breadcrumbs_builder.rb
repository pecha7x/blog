class TailwindBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    return "" if @elements.nil? || @elements.empty?

    position_attrs = "fixed bottom-5 right-1/2 transform translate-x-1/2 z-1"
    @context.content_tag(:nav, class: position_attrs+ " flex py-3 px-5", aria: { label: "Breadcrumb" }) do
      @context.content_tag(:ol, class: "inline-flex items-center space-x-1 md:space-x-3") do
        @elements.collect do |element|
          render_element(element)
        end.join.html_safe
      end
    end
  end

  def render_element(element)
    current = @context.current_page?(compute_path(element))
    aria = current ? { aria: { current: "page" } } : {}

    @context.content_tag(:li, aria) do
      @context.content_tag(:div, class: "flex items-center") do
        link_or_text = @context.link_to_unless_current(compute_name(element), compute_path(element), element.options.merge(class: "text-white bg-gradient-to-r from-[#8680ff] to-[#6f68fc] py-2 px-5 rounded"))
        # divider = @context.content_tag(:span, (@options[:separator] || '>').html_safe, class: 'divider') unless current

        # link_or_text + (divider || '')

        '<svg class="w-6" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 25 22" class="w-6 h-6 ml-2"><path d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>'


        link_or_text
      end
    end
  end
end


# <%= link_to category_articles_path(@category) do %>
#   <div class="fixed bottom-5 right-1/2 transform translate-x-1/2 z-1 flex inline-flex gap-2 justify-center items-center text-white bg-gradient-to-r from-[#8680ff] to-[#6f68fc] py-2 px-5 rounded">
#     <span><b>View More</b></span>
#     <svg class="w-6" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 25 22" class="w-6 h-6 ml-2">
#       <path d="M14 5l7 7m0 0l-7 7m7-7H3"></path>
#     </svg>
#   </div>
# <% end %>
