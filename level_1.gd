extends Node3D

@onready var timer_node =$Timer
@onready var timer_label = $TimerLabel 
@onready var win_screen = $YouWinScreen
@onready var lose_screen = $YouLoseScreen

var score = 0
var total_coins = 0
var coins_collected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_screen.hide()
	lose_screen.hide()
	
	timer_node.wait_time = 120
	timer_node.one_shot = true
	timer_node.connect("timeout", _on_timer_timeout)
	timer_node.start()
	
	total_coins = get_tree().get_nodes_in_group("Coins").size()
	
	for coin in $Coins.get_children():
		coin.connect("coin_collected", collect_coin)
	
	win_screen.connect("retry_game", _on_retry_pressed)
	lose_screen.connect("retry_game", _on_retry_pressed)
		
	update_score_display()

func collect_coin():
	score += 10
	coins_collected += 1
	
	print("coin collected")
	
	update_score_display()
	
	if coins_collected >= total_coins:
		game_win()

func update_score_display():
	$ScoreLabel.text = "Score: " + str(score) + "\nCoins: " + str(coins_collected) + "/" + str(total_coins)

func _on_timer_timeout():
	if coins_collected < total_coins:
		game_over()

func game_win():
	timer_node.stop()
	get_tree().paused = true
	win_screen.show()
	win_screen.set_labels(score, coins_collected)

func game_over():
	get_tree().paused = true
	lose_screen.show()
	lose_screen.set_labels(score, coins_collected)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time_left = timer_node.time_left
	var minutes = floor(time_left / 60)
	var seconds = int(floor(time_left)) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]  # Format: "01:30"
	
	
func _on_retry_pressed():
	get_tree().paused = false
	score = 0
	coins_collected = 0
	get_tree().reload_current_scene()
