extends MinigameBase
class_name MinigamePenguinsOnIce

@export var minigame_time: float
@export var number_of_steps: int

@onready var penguins_minigame_manager = $PenguinsMinigameManager
@onready var players_ids = PlayersController.GetCurrentPlayersIds()

func _ready() -> void:
	penguins_minigame_manager.timer_ended.connect(GameEnded)

func OnMinigameStarted() -> void:
	print("OnMinigameStarted")
	penguins_minigame_manager.setup_minigame(minigame_time, players_ids, number_of_steps)

func GameEnded(winner: int)-> void:
	print("GameEnded, winner: " + str(winner))

func OnPlayerPressed(playerId: int) -> void:
	print("OnPlayerPressed, playerId: " + str(playerId))
	penguins_minigame_manager.on_player_pressed(playerId)
