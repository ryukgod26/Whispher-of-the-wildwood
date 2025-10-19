extends CanvasLayer

@onready var gold: ProgressBar = $Gold
@onready var elixir: ProgressBar = $Elixir


func _ready() -> void:
	gold.value = Globals.gold
	elixir.value = Globals.elixir	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
