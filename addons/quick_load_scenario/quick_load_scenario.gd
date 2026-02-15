## The main AutoLoad script. Access at runtime the scenario via [member scenario].
@tool
extends Node
## QuickLoadScenario

const CONFIG_SAVER := preload("res://addons/quick_load_scenario/config_saver.gd")

## The exposed scenario name to check against at runtime.
var scenario : String = "DEFAULT"

func _ready() -> void:
	scenario = CONFIG_SAVER.load_scenario()
