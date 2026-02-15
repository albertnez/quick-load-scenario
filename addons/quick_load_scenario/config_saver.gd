extends Node

const CONFIG_NAME := "res://addons/quick_load_scenario/data/scenario.cfg"

# We store the default scenario in ConfigFile, to persist it once the project is running.
static func set_new_scenario(value: String) -> void:
	var config := ConfigFile.new()
	config.set_value("QuickLoadScenario", "scenario", value)
	var err := config.save(CONFIG_NAME)
	if err != Error.OK:
		print("Error saving config: ", err)


static func load_scenario() -> String:
	var config = ConfigFile.new()
	config.load(CONFIG_NAME)
	var scenario : String = config.get_value("QuickLoadScenario", "scenario", "DEFAULT")
	if scenario.is_empty():
		scenario = "DEFAULT"
	return scenario
