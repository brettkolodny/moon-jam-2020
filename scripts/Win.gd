extends CanvasLayer

func _ready():
    $Label.visible = false


func _on_AudioStreamPlayer_finished():
    $Label.visible = true
