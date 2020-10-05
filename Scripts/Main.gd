extends Node2D

const MOUSE_CORRECTION: Vector2 = Vector2(10, 10)
const MAX_RAIL_COUNT: int = 9

export var rail_inventory: int = MAX_RAIL_COUNT setget _set_rail_count
export var camera_speed: float = 0.7

var rail_position: Vector2

onready var tilemap: TileMap = $TileMap
onready var popup: Control = $PopupMenu
onready var cell_selector: Node2D = $CellSelector
onready var camera: Camera2D = $Camera2D
onready var rail_counter: Label = $RailCount


#
#func _physics_process(delta):
#	camera.offset.x += camera_speed


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos: Vector2 = tilemap.map_to_world(tilemap.world_to_map(get_global_mouse_position()))
		var cell: int = tilemap.get_cellv(tilemap.world_to_map(pos))
		if (cell == tilemap.INVALID_CELL):
			if !popup.visible:
				popup.set_position(pos + MOUSE_CORRECTION)
				popup.show_modal()
				rail_position = pos
		else:
			tilemap.set_cellv(tilemap.world_to_map(pos), -1)
			rail_inventory += 1
			rail_inventory = clamp(rail_inventory, rail_inventory, MAX_RAIL_COUNT)


func _unhandled_input(_event: InputEvent) -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	rail_counter.set_position(mouse_position + MOUSE_CORRECTION)
	
	var world_to_map = tilemap.world_to_map(mouse_position)
	var map_to_world = tilemap.map_to_world(world_to_map)
	
	
	if !popup.visible:
		var position: Vector2 = map_to_world
		cell_selector.position = position


func _on_PopupMenu_rail_pressed(rail):
	if rail_inventory > 0:
		tilemap.set_cellv(tilemap.world_to_map(rail_position), tilemap.tile_set.find_tile_by_name(rail))
		rail_inventory -= 1
		


func _set_rail_count(value: int):
	rail_inventory += value
	rail_counter.text = str(rail_inventory)
