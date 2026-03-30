extends CharacterBody3D
class_name EnemyBase

@export var VIEW_ANGLE : float
@export var VIEW_DISTANCE : float
@export var HEAR_DISTANCE : float
@export var INACTIVE_DISTANCE : float
@export var MOVE_SPEED : float
@export var ATTACK_RANGE : float
@export var UPDATE_POS_COOLDOWN : float

@export var food_area : Area3D
@export var favourite_food : ItemResource
@export var agent : NavigationAgent3D
@export var points : Array[Node3D]
@export var walk_sound_timer : Timer

var cur_point = 0
var near_favourite_food = false
var last_sneaky_pos : Vector3
var can_update_pos = true

func _ready() -> void:
	walk_sound_timer.timeout.connect(_on_walk_sound_timer_timeout)

func _on_walk_sound_timer_timeout() -> void:
	if velocity != Vector3.ZERO:
		SFXController.play_sound("skeleton_walk", global_position)

func can_see_fav_food() -> bool:
	return get_food_nearby() != null

func get_near_favourite_foods() -> Array[Item]:
	var arr : Array[Item]
	for a in food_area.get_overlapping_areas():
		var item = a.get_parent() as Item
		if item and item.item_name == favourite_food.item_name:
			arr.append(item)
	return arr

func get_food_nearby() -> Item:
	for food in get_near_favourite_foods():
		var res = raycast_to(food.global_position) as Item
		if res and res.item_name == favourite_food.item_name:
			return res
	return null

func distance_to_player() -> float:
	return (GameController.player.global_position - global_position).length()

func raycast_to(pos : Vector3):
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(
		global_position + Vector3.UP,
		pos
	)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	
	return result.collider if result else null

func raycast_to_player() -> bool:
	return raycast_to(GameController.player.global_position + Vector3.UP) == GameController.player

func angle_to_player() -> float:
	var vec = (GameController.player.global_position - global_position).normalized()
	return rad_to_deg((-global_basis.z).angle_to(vec))

func can_see_player() -> bool:
	return	not GameController.player.is_dead() \
			and !GameController.player.state_machine.get_current_state().is_sneaky \
			and angle_to_player() < VIEW_ANGLE \
			and distance_to_player() < VIEW_DISTANCE \
			and raycast_to_player()

func can_hear_player() -> bool:
	return 	not GameController.player.is_dead() \
			and distance_to_player() < HEAR_DISTANCE \
			and GameController.player.state_machine.get_current_state().is_loud

func move_to_and_rotate(pos : Vector3) -> void:
	velocity = global_position.direction_to(pos) * MOVE_SPEED
	if velocity != Vector3.ZERO:
		look_at(global_position + velocity)

func look_at_player() -> void:
	var vec = GameController.player.global_position - global_position
	vec.y = 0
	look_at(global_position + vec)

func next_point() -> void:
	cur_point = (cur_point + 1) % points.size()
	agent.set_target_position(get_cur_point())

func get_cur_point() -> Vector3:
	return points[cur_point].global_position

# TODO: skeletons with close enough points are broken, they cant update 
# position in time before reaching destination, and on destination they
# forgot about it
