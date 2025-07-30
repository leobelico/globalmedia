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
    if content.include?('<') && !content.start_with?('{')
      return sanitize(content, tags: allowed_quill_tags, attributes: allowed_quill_attributes)
    end

    # Procesamiento para contenido en formato Delta (JSON)
    if content.is_a?(String) && content.start_with?('{')
      begin
        parsed = JSON.parse(content)
        
        if parsed["html"]
          wrapped_content(parsed["html"])
        elsif parsed["ops"]
          html = quill_delta_to_html(parsed["ops"])
          wrapped_content(html)
        else
          wrapped_content(content.to_s)
        end
      rescue JSON::ParserError
        wrapped_content(content.to_s)
      end
    else
      wrapped_content(content.to_s)
    end
  end

  private

def wrapped_content(html)
  styles = <<-CSS
    .quill-content {
      font-family: Arial, Helvetica, serif;
      font-size: 16px;
      line-height: 28px;
      font-weight: 400;
    }

    .quill-content p {
      margin-top: 0;
      margin-bottom: 1rem;
      padding: 0;
    }

    .quill-content img {
      max-width: 100%;
      height: auto;
      margin: 0.5rem 0;
    }

    .quill-content .ql-align-justify {
      text-align: justify;
    }

    .quill-content ol,
    .quill-content ul,
    .quill-content pre,
    .quill-content blockquote,
    .quill-content h1, h2, h3, h4, h5, h6 {
      margin: 0;
      padding: 0;
      counter-reset: list-1 list-2 list-3 list-4 list-5 list-6 list-7 list-8 list-9;
    }
  CSS

  # Agrega el style en el HEAD de la página (una sola vez preferentemente)
  content_for :head_styles do
    "<style>#{styles}</style>".html_safe
  end

  <<-HTML.html_safe
    <div class="quill-content">
      #{html}
    </div>
  HTML
end


  def allowed_quill_tags
    %w[p br ul ol li strong em u s a img h1 h2 h3 h4 h5 h6 blockquote pre iframe div span table tr td th]
  end

  def allowed_quill_attributes
    %w[href src alt title class style width height frameborder allowfullscreen data-id data-url data-align]
  end

  def quill_delta_to_html(ops)
    return "" unless ops.is_a?(Array)

    html = []
    current_block = []
    current_attrs = {}

    ops.each do |op|
      next unless op.is_a?(Hash)

      if op['insert'].is_a?(String)
        text = op['insert']
        
        if text == "\n"
          unless current_block.empty?
            html << wrap_with_attrs(current_block.join, current_attrs)
            current_block = []
            current_attrs = {}
          end
          next
        end

        formatted_text = text.dup
        if op['attributes'].is_a?(Hash)
          formatted_text = apply_text_attributes(formatted_text, op['attributes'])
          current_attrs = op['attributes'].merge(current_attrs)
        end
        
        current_block << formatted_text
      elsif op['insert'].is_a?(Hash) && op['insert']['image']
        html << "<img src=\"#{op['insert']['image']}\" class=\"quill-image\">"
      end
    end

    html << wrap_with_attrs(current_block.join, current_attrs) unless current_block.empty?
    html.join("\n")
  end

  def wrap_with_attrs(content, attrs)
    return content if content.blank?

    if attrs['align'] == 'justify'
      "<p class=\"ql-align-justify\">#{content}</p>"
    elsif attrs['align']
      "<p style=\"text-align:#{attrs['align']}\">#{content}</p>"
    else
      "<p>#{content}</p>"
    end
  end

  def apply_text_attributes(text, attributes)
    return text unless attributes.is_a?(Hash)

    attributes.each do |attr, value|
      case attr.to_s
      when 'bold' then text = "<strong>#{text}</strong>"
      when 'italic' then text = "<em>#{text}</em>"
      when 'underline' then text = "<u>#{text}</u>"
      when 'strike' then text = "<s>#{text}</s>"
      when 'link' then text = "<a href=\"#{ERB::Util.html_escape(value)}\" target=\"_blank\" rel=\"noopener\">#{text}</a>"
      end
    end
    text
  end
end