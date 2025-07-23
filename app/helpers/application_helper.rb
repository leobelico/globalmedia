module ApplicationHelper
  def link_to_remove_fields(name, f, css_class)
    f.hidden_field(:_destroy) + 
    link_to(name, '#', class: css_class, data: { action: 'remove-fields' })
  end

  def link_to_add_fields(name, f, association, css_class, title)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end
    
    link_to(name, '#', 
            class: css_class, 
            title: title,
            data: {
              id: id,
              action: 'add-fields',
              association: association,
              fields: fields.gsub("\n", "")
            })
  end
  def display_quill_content(content)
    return "" unless content.present?

    if content.is_a?(Hash) || (content.is_a?(String) && content.start_with?('{'))
      begin
        parsed = JSON.parse(content.to_s)
        html_content = parsed["html"] || content.to_s
      rescue JSON::ParserError
        html_content = content.to_s
      end
    else
      html_content = content.to_s
    end

    sanitize(html_content, tags: %w[p br ul ol li strong em u s a img h1 h2 h3 h4 h5 h6 blockquote pre iframe div span],
                    attributes: %w[href src alt title class style width height frameborder allowfullscreen data-id data-url])
  end
end