extends CanvasLayer

var game_started = false

func _process(delta):
    if !game_started and Input.is_action_just_pressed("ui_accept"):
        Global.goto_scene("res://scenes/Main.tscn")
        game_started = true