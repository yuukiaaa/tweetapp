module ArticlesHelper
    def article_images(article)
        buffer = "".html_safe

        article.images.order(:id)[0..-1]&.each do |image|
            buffer << render_entry_image(image)
        end
        buffer
    end

    private def render_entry_image(image)
        content_tag(:div) do
            image_tag image.data.variant(resize: "530x>"), alt: image.alt_text, style: "display: block; margin: 0 auto 15px"
        end
    end

end
