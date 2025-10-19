extends Node2D

@onready var troop_1: Button = $TroopsButton/troop1
@onready var troop_2: Button = $TroopsButton/troop2
@onready var troop_3: Button = $TroopsButton/troop3
var selected
@onready var labeltimer: Timer = $Labeltimer
@onready var notrooplbl: Label = $notroop

var troop1_scene = preload("res://Scenes/wood_cutter.tscn")
var troop2_scene = preload("res://Scenes/grave_robber.tscn")
var troop3_scene = preload("res://Scenes/steam_man.tscn")

func _ready() -> void:
	update()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Spawn"):
		var mouse_pos = get_global_mouse_position()
		if selected == null:
			get_tree().call_group('troop','get_target_position',mouse_pos)
			return
		if selected == troop_1:
			if int(troop_1.text) <= 0:
				notrooplbl.visible = true
				labeltimer.start()
				return
			var troop1 = troop1_scene.instantiate()
			troop1.global_position = mouse_pos
			Globals.troop1 = Globals.troop1 - 1
			add_child(troop1)
			update()
		
		elif selected == troop_2:
			if int(troop_2.text) <= 0:
				notrooplbl.visible = true
				labeltimer.start()
				return
			var troop2 = troop2_scene.instantiate()
			add_child(troop2)
			troop2.global_position = mouse_pos
			Globals.troop2 = Globals.troop2 -1 
			update()
		elif selected == troop_3:
			if int(troop_3.text) <= 0:
				notrooplbl.visible = true
				labeltimer.start()
				return
			var troop3 = troop3_scene.instantiate()
			add_child(troop3)
			troop3.global_position = mouse_pos
			Globals.troop3 = Globals.troop3 - 1 
			update()
		


func _on_end_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_troop_1_pressed() -> void:
	if selected == troop_1:
		selected = null
	selected = troop_1


func _on_troop_2_pressed() -> void:
	if selected == troop_2:
		selected = null
	selected = troop_2


func _on_troop_3_pressed() -> void:
	if selected == troop_3:
		selected = null
	selected = troop_3

func update():
	troop_1.text = "x%d" % [Globals.troop1]
	troop_2.text = "x%d" % [Globals.troop2]
	troop_3.text = "x%d" % [Globals.troop3] 


func _on_labeltimer_timeout() -> void:
	notrooplbl.visible = false


#func _on_troop_1_toggled(toggled_on: bool) -> void:
	#if toggled_on:
		#print("Selected Troop 1")
		#selected = troop_1
	#else:
		#print("Unselected Troop 1")
		#selected = null
#
#
#func _on_troop_2_toggled(toggled_on: bool) -> void:
	#if toggled_on:
		#selected = troop_2
	#else:
		#selected = null
#
#
#
#func _on_troop_3_toggled(toggled_on: bool) -> void:
	#if toggled_on:
		#selected = troop_3
	#else:
		#selected = null


func _on_empty_pressed() -> void:
	selected = null
	
