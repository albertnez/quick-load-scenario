@tool
extends EditorPlugin

var dropdown_menu

func _enter_tree():
	add_autoload_singleton("QuickLoadScenario", "res://addons/quick_load_scenario/quick_load_scenario.gd")

	dropdown_menu = preload("res://addons/quick_load_scenario/menu_options.tscn").instantiate()
	add_control_to_container(CONTAINER_TOOLBAR, dropdown_menu)

	# Let's place the dropdown right before the Play buttons.
	var toolbar = dropdown_menu.get_parent()
	toolbar.move_child(dropdown_menu, 4)

func _exit_tree():
	remove_autoload_singleton("QuickLoadScenario")
	remove_control_from_container(CONTAINER_TOOLBAR, dropdown_menu)
	dropdown_menu.queue_free()
