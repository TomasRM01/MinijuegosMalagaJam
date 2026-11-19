extends Control

@onready var metronome_text: Label = $Metronome
@onready var points_j1_text: Label = $PointsJ1
@onready var points_j2_text: Label = $PointsJ2
@onready var points_j3_text: Label = $PointsJ3
@onready var points_j4_text: Label = $PointsJ4

@onready var penguins_minigame_manager: Node = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	metronome_text.text = str("%.2f" % penguins_minigame_manager.metronome_timer.time_left)
	points_j1_text.text = str("%.2f" %penguins_minigame_manager.rhythm_points_array[0])
	points_j2_text.text = str("%.2f" %penguins_minigame_manager.rhythm_points_array[1])
	points_j3_text.text = str("%.2f" %penguins_minigame_manager.rhythm_points_array[2])
	points_j4_text.text = str("%.2f" %penguins_minigame_manager.rhythm_points_array[3])
