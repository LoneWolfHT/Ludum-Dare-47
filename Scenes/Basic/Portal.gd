extends Area2D


export (String) var Target = "MainMenu"
export (float) var TELEPORT_TIME = 1.0

var counter = 0
var NEXT_SCENE = false

func _on_Portal_area_entered(_Area2D):
	if Target == "Node":
		pass

	NEXT_SCENE = true
	get_node("Particles").amount = 40
	get_node("Particles").color = ColorN("green")
	get_node("Texture").texture = load("res://Assets/PortalGreen.png")

	if Target == "GameOver":
		get_node("Nooo").visible = true

func _physics_process(delta):
	if NEXT_SCENE:
		counter += delta

		if counter >= TELEPORT_TIME:
			if Target != "GameOver":
				get_tree().change_scene("res://Scenes/" + Target + ".tscn")
			else:
				get_tree().quit()
