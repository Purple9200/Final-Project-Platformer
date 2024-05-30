class_name TitleScreen
extends Control
@onready var start_button = $"MarginContainer/HBoxContainer/VBoxContainer/Start Button"
@onready var quit_button = $"MarginContainer/HBoxContainer/VBoxContainer/Quit Button"
@export var start_level = preload("res://scenes/game.tscn")


func _on_start_button_pressed():
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	LevelTransition.fade_from_black()

func _on_quit_button_pressed():
	get_tree().quit()
