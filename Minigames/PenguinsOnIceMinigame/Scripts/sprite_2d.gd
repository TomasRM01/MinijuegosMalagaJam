extends Sprite2D

var movement = 0.0

@onready var penguins_minigame_manager: Node = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	penguins_minigame_manager.submetronome_ended.connect(_move_background_on_step)


func _move_background_on_step() -> void:
	var tween = get_tree().create_tween()
	movement = movement + 24.0
	if movement > 192.0:
		movement = 24.0
		region_rect = Rect2(0, 0, 192.0, 108.0)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "region_rect", Rect2(movement, 0, 192.0, 108.0), 0.2)

# 1    2 3 4 5 6 7 8 10
# 19.2 - - - - - - - 192.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
