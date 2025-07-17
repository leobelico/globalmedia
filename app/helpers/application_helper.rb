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
end