extends Popup

signal rail_pressed(rail)


onready var animation_player: AnimationPlayer = $AnimationPlayer


func close():
	animation_player.play_backwards("default")
	visible = false


func _on_PopupMenu_visibility_changed():
	if visible:
		animation_player.play("default")


func _on_Button_pressed(btn: String):
	emit_signal("rail_pressed", btn)
	close()


