extends Node
class_name State

@export var state_name : String
@export var is_loud : bool
@export var is_sneaky : bool

var state_machine : StateMachine
var is_in_state = false

func _ready() -> void:
	var p = get_parent()
	if not p or p is not StateMachine:
		push_error("Parent of state is not a state machine!")
		return
	state_machine = p as StateMachine
	
	prepare()

func prepare() -> void:
	pass

func enter(_options := {}) -> void:
	is_in_state = true

func exit() -> void:
	is_in_state = false

func fixed_update(_delta : float) -> void:
	pass
