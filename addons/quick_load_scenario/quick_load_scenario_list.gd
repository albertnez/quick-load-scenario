@tool
extends Resource

@export var _custom_scenarios : Array[String] : set = _set_scenarios

func _set_scenarios(value: Array[String]) -> void:
	_custom_scenarios = value
	emit_changed()

func get_list() -> Array[String]:
	# Unnecessary temporary variables because we can't return as Array[String] directly.
	var result : Array[String] = ["DEFAULT"]
	result += _custom_scenarios.filter(func (s: String): return not s.is_empty())
	return result
