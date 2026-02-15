@tool
extends Control

@onready var _undo_button: Button = %UndoButton
@onready var _option_button: OptionButton = %OptionButton
@onready var _edit_button: Button = %EditButton

const RESOURCE_PATH := "res://addons/quick_load_scenario/data/custom_scenarios_list.tres"
const CONFIG_SAVER := preload("res://addons/quick_load_scenario/config_saver.gd")


var QuickLoadScenarioList := preload("res://addons/quick_load_scenario/quick_load_scenario_list.gd").new()

func _ready() -> void:
	if ResourceLoader.exists(RESOURCE_PATH):
		QuickLoadScenarioList = load(RESOURCE_PATH)
	else:
		ResourceSaver.save(QuickLoadScenarioList, RESOURCE_PATH)

	QuickLoadScenarioList.changed.connect(_regenerate_options)
	_regenerate_options()
	var last_saved := CONFIG_SAVER.load_scenario()
	_change_menu_selected_or_default(last_saved)
	
	_edit_button.icon = get_theme_icon("EditAddRemove", "EditorIcons")
	_undo_button.icon = get_theme_icon("UndoRedo", "EditorIcons")

	_undo_button.pressed.connect(func ():
		_option_button.selected = 0
		_save_scenario())
	_option_button.item_selected.connect(_save_scenario)
	_edit_button.pressed.connect(_handle_edit)


func _change_menu_selected_or_default(which: String) -> void:
	var idx := QuickLoadScenarioList.get_list().find(which)
	_option_button.select(idx)
	var new := _option_button.get_item_text(_option_button.selected)
	if new != which:
		CONFIG_SAVER.set_new_scenario(new)


func _regenerate_options() -> void:
	var prev := _option_button.get_item_text(_option_button.selected)
	for i in _option_button.item_count:
		_option_button.remove_item(0)
	for scenario in QuickLoadScenarioList.get_list():
		_option_button.add_item(scenario)
	_change_menu_selected_or_default(prev)


func _handle_edit() -> void:
	EditorInterface.inspect_object(QuickLoadScenarioList)


func _save_scenario(which: int = 0) -> void:
	var name := _option_button.get_item_text(which)
	CONFIG_SAVER.set_new_scenario(name)
