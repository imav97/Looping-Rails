extends StaticBody2D


export onready var path_player

#function to delete the coin once the player gets it
func _on_Coin_body_entered(body):
	if body.name == "Player":
		get_tree().queue_delete(self)
