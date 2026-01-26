class StaticPagesController < ApplicationController
  def about
    now = Time.now.utc.to_date
    dob = Date.new(1988, 4, 19)
    @age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def home
    sections = Section.includes(categories: :articles)

    @articles = sections.map do |section|
      {
        id: section.id,
        name: section.name,
        expanded: true,
        link: nil,
        items: section.categories.map do |category|
          {
            id: category.id,
            name: category.name,
            link: category_path(category),
            items: category.articles.roots.map do |root_article|
              {
                id: root_article.id,
                name: root_article.title,
                expanded: false,
                link: category_article_path(category, root_article),
                items: article_children_items(root_article, category)
              }
            end
          }
        end
      }
    end
  end

  private

  def article_children_items(article, category)
    article.children.map do |child|
      child_items = article_children_items(child, category)
      {
        id: child.id,
        name: child.title,
        expanded: false,
        link: category_article_path(category, child),
        items: child_items
      }
    end
  end
end
