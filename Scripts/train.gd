extends Control

@onready var troop_1: Button = $Panel2/TroopShow/troop1
@onready var troop_2: Button = $Panel2/TroopShow/troop2
@onready var troop_3: Button = $Panel2/TroopShow/troop3

signal troops(troop1:int,troop2:int,troop3:int)

func _ready() -> void:
	troop_1.text = "x %d" % [Globals.troop1]
	troop_2.text = "x %d" % [Globals.troop2]
	troop_3.text = "x %d" % [Globals.troop3]
	if Globals.troop1 == 0:
		troop_1.visible = false
	if Globals.troop2 == 0:
		troop_2.visible = false
	if Globals.troop3 == 0:
		troop_3.visible = false

func _on_troop_1_pressed() -> void:
	troop_1.visible = true
	var text = int(troop_1.text)
	troop_1.text = "x %d" % [text+1]


func _on_troop_2_pressed() -> void:
	troop_2.visible  = true
	var text = int(troop_2.text)
	troop_2.text = "x %d" % [text+1]


func _on_troop_3_pressed() -> void:
	troop_3.visible = true
	var text = int(troop_3.text)
	troop_3.text = "x %d" % [text+1]


func _on_back_pressed() -> void:
	Globals.troop1 = int(troop_1.text)
	Globals.troop2 = int(troop_2.text)
	Globals.troop3 = int(troop_3.text)
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
