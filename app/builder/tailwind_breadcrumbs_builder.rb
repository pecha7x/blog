class TailwindBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    return "" if @elements.nil? || @elements.empty?

    position_attrs = "fixed bottom-0 md:bottom-5 right-1/2 transform translate-x-1/2 z-1"
    @context.content_tag(:nav, class: position_attrs+ " flex w-full py-3 px-5", aria: { label: "Breadcrumb" }) do
      @context.content_tag(:ol, class: "inline-flex items-center w-full justify-around md:justify-center space-x-3 md:space-x-5") do
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
        @context.link_to_unless_current(compute_name(element), compute_path(element), element.options.merge(class: "whitespace-nowrap text-white bg-gradient-to-r from-[#8680ff] to-[#6f68fc] py-2 px-5 rounded"))
      end
    end
  end
end
