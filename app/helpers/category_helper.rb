module CategoryHelper
  def icon_tag(category, zoom: 100, class: '')
    return "" unless category.icon.attached?

    size = (category.icon_height * zoom) / 100
      
    image_tag category.icon, size: "#{size}x#{size}", class:
  end
end
