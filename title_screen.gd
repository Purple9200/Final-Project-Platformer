extends CenterContainer

@onready var start_game_button = $VBoxContainer/StartGameButton



func _ready():
	start_game_button.grab_focus()

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")



