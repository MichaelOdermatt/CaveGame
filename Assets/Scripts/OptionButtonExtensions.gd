class_name OptionButtonExtensions;

## Get the item text of the selected option in the given OptionButton.
static func get_selected_item_text(option_button: OptionButton) -> String:
	return option_button.get_item_text(option_button.selected);

## Searches through all options in the OptionButton and returns the index of the option with the given text. 
## If the option does not exist -1 is returned.
static func get_index_of_item_text(option_button: OptionButton, option: String) -> int:
	for i in range(option_button.item_count):
		var current_option = option_button.get_item_text(i);
		if (current_option == option):
			return i;
	return -1;