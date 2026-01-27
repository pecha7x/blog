module Admin
  class DashboardsController < Admin::BaseController
    def show
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
              link: edit_admin_category_path(category),
              items: category.articles.roots.map do |root_article|
                {
                  id: root_article.id,
                  name: root_article.title,
                  expanded: false,
                  link: edit_admin_article_path(root_article),
                  items: article_children_items(root_article, category)
                }
              end.append(
                {
                  id: "new",
                  name: "Add New +",
                  expanded: false,
                  link: new_admin_article_path(
                    category_id: category.id,
                    previous_article_id: category.articles.roots.last&.id
                  ),
                  items: []
                }
              )
            }
          end.append(
            {
              id: "new",
              name: "Add New +",
              expanded: false,
              link: new_admin_category_path(section_id: section.id),
              items: []
            }
          )
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
          link: edit_admin_article_path(child),
          items: child_items
        }
      end.append(
        {
          id: "new",
          name: "Add New +",
          expanded: false,
          link: new_admin_article_path(
            category_id: category.id,
            parent_id: article.id,
            previous_article_id: article.children.last&.id || article.id
          ),
          items: []
        }
      )
    end
  end
end
