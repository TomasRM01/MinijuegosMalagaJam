extends MinigameBase
class_name MinigamePenguinsOnIce

func OnMinigameStarted() -> void:
	print("OnMinigameStarted")

func GameEnded(winner:int)-> void:
	print("GameEnded, winner: " + str(winner))

func OnPlayerPressed(playerId: int) -> void:
	print("OnPlayerPressed, playerId: " + str(playerId))
