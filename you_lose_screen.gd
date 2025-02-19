extends Control
signal retry_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$PanelContainer/VBoxContainer/HBoxContainer/RetryButton.connect("pressed", _retry_pressed)

func set_labels(score: int, coins: int):
	$PanelContainer/VBoxContainer/FinalScoreLabel.text = "Total Score: " + str(score)
	$PanelContainer/VBoxContainer/CoinsCollectedLabel.text = "Coins Collected: " + str(coins)
	

func _retry_pressed():
	emit_signal("retry_game")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
