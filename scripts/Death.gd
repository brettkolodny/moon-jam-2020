extends AnimatedSprite

func _ready():
    var screen = get_viewport_rect().size
    position.x = screen.x / 2
    position.y = screen.y / 2
    play()

func _on_AnimatedSprite_animation_finished():
    Global.goto_scene("res://scenes/GameOver.tscn")
