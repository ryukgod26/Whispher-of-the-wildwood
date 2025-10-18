extends StaticBody2D


signal selected(building)

@export var grid_size: Vector2i = Vector2i(2,2)
@onready var placement_indicator: ColorRect = $PlacementIndicator
@onready var placement_tilemap: TileMapLayer = $"../../PlacementGrid"


var is_valid_placement = true

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		selected.emit(self)
		print("selected")
func check_validity(placement_grid):
	is_valid_placement = true
	
	var grid_pos = placement_grid.local_to_map(global_position)
	
	for x in range(grid_pos.x):
		for y in range(grid_pos.y):
			var tile_to_check = grid_pos + Vector2i(x,y)
			var data = placement_grid.get_cell_custom_data(tile_to_check,"Occupancy")
			if data != 0:
				is_valid_placement = false
				break
		if not is_valid_placement:
			break
	if is_valid_placement:
		placement_indicator.visible = true
	else:
		placement_indicator.visible = true
		placement_indicator.color = Color(1,0,0,0.5)	
		

func claim_tiles(placement_grid):
	var grid_pos = placement_grid.local_to_map(global_position)
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var tile_to_claim = grid_pos + Vector2i(x,y)
			placement_grid.set_cell_custom_data(tile_to_claim,"Occupancy",1)
			
func unclaim_tiles(placement_grid):
	var grid_pos = placement_grid.local_to_map(global_position)
	
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var tile_to_unclaim = grid_pos + Vector2i(x,y)
			var data = placement_tilemap.get_cell_tile_data(tile_to_unclaim)
			if data:
				print(data.get_custom_data("Occupancy"))
			else:
				data.set_custom_data("Occupancy",0)
