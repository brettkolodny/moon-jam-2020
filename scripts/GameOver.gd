extends CanvasLayer

func _process(_delta):
    if Input.is_action_just_pressed("ui_accept"):
        Global.goto_scene("res://scenes/Main.tscn")