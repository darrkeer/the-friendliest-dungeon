extends UsableItem
class_name HealthBar

func use() -> void:
	if GameController.player.cur_hp == GameController.player.MAX_HP:
		return
	GameController.player.inventory.remove_held_item()
	GameController.player.change_health(2)
	SFXController.play_sound("chips", GameController.player.global_position)
