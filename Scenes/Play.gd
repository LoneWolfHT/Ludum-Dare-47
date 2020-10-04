extends Button

export (String) var LEVEL = "Tutorial"
func _on_Play_button_up():
	get_tree().change_scene("res://Scenes/Levels/"+LEVEL+".tscn")


func _on_Play_button_down():
	var effect = get_node_or_null("Effect")

	if effect:
		effect.playing = true
