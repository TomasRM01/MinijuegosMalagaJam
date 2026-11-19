extends AnimatedSprite2D

@onready var penguins_minigame_manager: Node = $"../.."

var step_right: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("default")
	penguins_minigame_manager.submetronome_ended.connect(_play_step_animation)

func _play_step_animation() -> void:
	speed_scale = 1.0 / penguins_minigame_manager.time_between_steps
	if step_right:
		play("step_right")
	else:
		play("step_left")
	step_right = !step_right


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
