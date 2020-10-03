extends Node2D


onready var tilemap: TileMap = $TileMap



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos: Vector2 = event.position
		var cell: int = tilemap.get_cellv(pos)
		var tileset: TileSet = tilemap.tile_set
		if (cell == tilemap.INVALID_CELL):
			for tile in tileset.get_tiles_ids():
				var sprite: Sprite = Sprite.new()
				sprite.position = pos
				sprite.texture = tileset.tile_get_texture(tile)
				add_child(sprite)
