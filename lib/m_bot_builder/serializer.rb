module Serializer
  class << self
    def extract(hash)
      p "In Serializer"
      {
        attachment: get_attachment(hash["attachment"])
      }
    end

    def get_attachment(hash)
      {
        type: "template",
        payload: get_payload(hash["payload"])
      }
    end

    def get_payload(hash)
      case hash["template_type"]
      when "button"
        get_button_template(hash)
      when "generic"
        get_generic_template(hash)
      end
    end

    def get_button_template(hash)
      {
        text:           hash["text"],
        template_type:  "button",
        buttons:       get_buttons(hash["buttons"])
      }
    end

    def get_buttons(hash)
      output = []
      hash.each do |button|
        h = {
          type: button["type"],
          url: button["url"],
          title: button["title"],
          payload: button["payload"]
        }
        output << h
      end
      output
    end

    def get_generic_template(hash)
      {
        template_type: "generic",
        elements: get_elements(hash["elements"]) 
      }
    end

    def get_elements(hash)
      p "In Get elements"
      p hash
      output = []
      hash.each do |element|
        h = {
          title: element["title"],
          item_url: element["item_url"],
          image_url: element["image_url"],
          subtitle: element["subtitle"],
          buttons:  get_buttons(element["buttons"])
        }
        output << h
      end
      output
    end
  end
end