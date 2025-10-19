extends Node2D

@onready var objects: Node = $Objects
@onready var placement_grid: TileMapLayer = $PlacementGrid
var selected_building = null
var last_valid_position = Vector2.ZERO
var TILE_SIZE = 64



func _ready() -> void:
	print(Globals.troop1,Globals.troop2,Globals.troop3)
	for object in objects.get_children():
		if object.has_signal('selected'):
			object.selected.connect(_on_object_selected)
		if object is Area2D:
			object.claim_tiles(placement_grid)


func _on_object_selected(building):
	if selected_building:
		_place_selected_building()
	selected_building =  building
	
	last_valid_position  = building.global_position
	selected_building.unclaim_tiles(placement_grid)
	selected_building.placement_indicator.show()

func _process(delta: float) -> void:
	if selected_building:
		var mouse_pos = get_global_mouse_position()
		var grid_pos = placement_grid.local_to_map(mouse_pos)
		var snapped_pos = placement_grid.map_to_local(grid_pos)
		
		selected_building.global_position = snapped_pos
		selected_building.check_validity(placement_grid)
		
func _input(event: InputEvent) -> void:
	if selected_building and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		pass
		if event.position.distance_to(selected_building.global_position) > TILE_SIZE:
			_place_selected_building()

func _place_selected_building():
	if not selected_building:
		return
	selected_building.check_validity(placement_grid)
	if selected_building.is_valid_placement:
		selected_building.claim_tiles(placement_grid)
	else:
		selected_building.global_position = last_valid_position
		selected_building.claim_tiles(placement_grid)
	selected_building.placement_indicator.hide()
	selected_building = null




func _on_attack_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/enemy_base.tscn")


func _on_train_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/train.tscn")
