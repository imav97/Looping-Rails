extends Node2D

const MOUSE_CORRECTION: Vector2 = Vector2(66, 66)
const MAX_RAIL_COUNT: int = 9

export var rail_inventory: int = MAX_RAIL_COUNT

var rail_position: Vector2

onready var tilemap: TileMap = $TileMap
onready var popup: Control = $PopupMenu


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos: Vector2 = event.position
		var cell: int = tilemap.get_cellv(tilemap.world_to_map(pos))
		if (cell == tilemap.INVALID_CELL):
			if !popup.visible:
				popup.set_position(pos - MOUSE_CORRECTION)
				popup.show_modal()
				rail_position = pos
		else:
			tilemap.set_cellv(tilemap.world_to_map(pos), -1)
			rail_inventory += 1
			rail_inventory = clamp(rail_inventory, rail_inventory, MAX_RAIL_COUNT)


func _unhandled_input(_event: InputEvent) -> void:
	if !popup.visible:
		var position: Vector2 = get_global_mouse_position().snapped(tilemap.cell_size)
		$Outline.position = position


func _on_PopupMenu_rail_pressed(rail):
	if rail_inventory > 0:
		tilemap.set_cellv(tilemap.world_to_map(rail_position), tilemap.tile_set.find_tile_by_name(rail))
		rail_inventory -= 1
