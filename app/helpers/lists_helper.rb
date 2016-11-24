module ListsHelper
  def custom_options_from_collection_for_select(collection, value_method, text_method, selected)
    
    selected[:title]="Choose sublist"
  	collection = collection.unshift(selected) # Unshift method is similar to .push put puts the object first in order.

    options = collection.map do |element|
      [value_for_collection(element, text_method), value_for_collection(element, value_method), option_html_attributes(element)]
    end

    default_selected, disabled = extract_selected_and_disabled(default_selected)

    select_deselect = {
      selected: extract_values_from_collection(collection, value_method, selected),
      disabled: extract_values_from_collection(collection, value_method, disabled)
    }

    options_for_select(options, select_deselect)
  end
end
