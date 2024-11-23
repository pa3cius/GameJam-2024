extends CanvasLayer

class_name UI

@onready var jump_label : Label = %Jumps
@onready var double_jump_label : Label = %DoubleJumps

var jumps : int = 0:
	set(new_jumps):
		jumps = new_jumps
		_update_jump_label()

var double_jumps : int = 0:
	set(new_double_jumps):
		double_jumps = new_double_jumps
		_update_double_jump_label()
		
func _ready() -> void:
	_update_jump_label()
	_update_double_jump_label()

func _update_jump_label() -> void:
	jump_label.text = "jumps " + str(jumps)

func _update_double_jump_label() -> void:
	double_jump_label.text = "double jumps " + str(double_jumps)

func _on_jumped() -> void:
	jumps += 1

func _on_double_jumped() -> void:
	double_jumps += 1
