@tool
extends Resource

@export var _custom_scenarios : Array[String] : set = _set_scenarios

func _set_scenarios(value: Array[String]) -> void:
	_custom_scenarios = value
	emit_changed()


const _default : Array[String] = ["DEFAULT"]
func get_list() -> Array[String]:
	return _default + _custom_scenarios.filter(func (s: String): return not s.is_empty())
