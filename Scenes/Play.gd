extends Button

export (String) var LEVEL = "Level1"

func _on_Play_button_up():
	get_tree().change_scene("res://Scenes/Levels/"+LEVEL+".tscn")
