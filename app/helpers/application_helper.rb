module ApplicationHelper
  # Métodos existentes para nested forms
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

  # Método mejorado para contenido Quill
  def display_quill_content(content)
    return "" unless content.present?

    # Si el contenido ya es HTML (formato antiguo)
    return sanitize(content) if content.include?('<') && !content.start_with?('{')

    # Procesamiento para contenido en formato Delta (JSON)
    if content.is_a?(Hash) || (content.is_a?(String) && content.start_with?('{'))
      begin
        parsed = JSON.parse(content.to_s)
        
        # Caso 1: Contiene HTML directamente
        if parsed["html"]
          return sanitize(parsed["html"], 
                         tags: allowed_quill_tags, 
                         attributes: allowed_quill_attributes)
        
        # Caso 2: Formato Delta (ops)
        elsif parsed["ops"]
          return sanitize(quill_delta_to_html(parsed["ops"]), 
                         tags: allowed_quill_tags, 
                         attributes: allowed_quill_attributes)
        end
      rescue JSON::ParserError
        # Si falla el parseo JSON, devolver el contenido original sanitizado
        return sanitize(content.to_s)
      end
    end

    # Para cualquier otro caso
    sanitize(content.to_s)
  end

  private

  # Tags HTML permitidos
  def allowed_quill_tags
    %w[p br ul ol li strong em u s a img h1 h2 h3 h4 h5 h6 blockquote pre iframe div span table tr td th]
  end

  # Atributos HTML permitidos
  def allowed_quill_attributes
    %w[href src alt title class style width height frameborder allowfullscreen data-id data-url data-align]
  end

  # Convertir Delta ops a HTML
  def quill_delta_to_html(ops)
    html = []
    current_paragraph = []
    
    ops.each do |op|
      if op['insert'].is_a?(String)
        text = op['insert']
        
        # Manejo de saltos de línea (nuevos párrafos)
        if text == "\n"
          unless current_paragraph.empty?
            html << "<p>#{current_paragraph.join}</p>"
            current_paragraph = []
          end
          next
        end
        
        # Aplicar formatos
        formatted_text = text
        if op['attributes']
          formatted_text = apply_text_attributes(formatted_text, op['attributes'])
        end
        
        current_paragraph << formatted_text
      elsif op['insert']['image']
        # Manejo de imágenes embebidas
        html << "<img src=\"#{op['insert']['image']}\" class=\"quill-image\">"
      end
    end
    
    # Añadir el último párrafo si existe
    html << "<p>#{current_paragraph.join}</p>" unless current_paragraph.empty?
    
    html.join
  end

  # Aplicar atributos de formato al texto
  def apply_text_attributes(text, attributes)
    attributes.each do |attr, value|
      case attr
      when 'bold'
        text = "<strong>#{text}</strong>"
      when 'italic'
        text = "<em>#{text}</em>"
      when 'underline'
        text = "<u>#{text}</u>"
      when 'strike'
        text = "<s>#{text}</s>"
      when 'link'
        text = "<a href=\"#{value}\">#{text}</a>"
      end
    end
    text
  end
end