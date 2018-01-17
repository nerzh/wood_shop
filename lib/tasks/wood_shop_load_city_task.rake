require 'byebug'
require 'unicode'
require 'nokogiri'
require 'open-uri'

# module WoodShop
  namespace :init do
    task city: :environment do
      def add_to_hash(child, hash)
        child.children.each do |nested_child|
          if nested_child.name == 'li'
            city = nil
            area = nil

            if nested_child.xpath(".//a[@title]").size > 1
              nested_child.children.each do |nested_child_2|
                if nested_child_2.name == 'a' and nested_child_2.attributes['title']
                  area = nested_child_2.children.text.gsub(/область/, '').strip if city
                  city ||= nested_child_2.children.text
                end
              end
            else
              nested_child.children.each do |nested_child_2|
                city ||= nested_child_2&.children&.text if nested_child_2.attributes['title']
                if nested_child_2&.children.size == 0
                  if nested_child_2&.text[/^[\s\S]*(—|-)\s*([\s\S]+)$/]
                    area = $2
                    area = area.gsub(/область/, '').strip
                  end
                end
              end
            end
          end
          if area
            area = 'Киевская' if area == 'город со специальным статусом Киев'
            area = 'Автономная Республика Крым' if area == 'город со специальным статусом Севастополь'
            hash[area] ||= []
            hash[area] << city
          end
        end
        hash
      end

      doc = Nokogiri::HTML(open("https://ru.wikipedia.org/wiki/%D0%93%D0%BE%D1%80%D0%BE%D0%B4%D0%B0_%D0%A3%D0%BA%D1%80%D0%B0%D0%B8%D0%BD%D1%8B"))
      trigger = false
      hash    = {}
      doc.xpath("//div[@class='mw-parser-output']").children.each do |child|
        if child.name == 'h2'
          trigger = child.xpath(".//span[@class='mw-headline']")&.first&.text[/^[^\d\s]$/]
        end
        if child.name == 'ul'
          if trigger
            add_to_hash(child, hash)
          end
        end
      end

      array_cities_object = []

      hash.each do |area, cities|
        area_object = WoodShop::Area.create(description_ru: area)
        cities.each do |city|
          array_cities_object << WoodShop::City.new(area_id: area_object.id, description_ru: city)
        end
      end

      WoodShop::City.import(array_cities_object)
    end
  end
# end