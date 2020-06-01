extends Area2D

export (String) var key_color 

signal gold_pickup
signal silver_pickup
signal bronze_pickup

func _ready():
    if key_color == "gold":
        $Sprite.modulate = Color("ffd700")
    if key_color == "silver":
        $Sprite.modulate = Color("c0c0c0")
    if key_color == "bronze":
        $Sprite.modulate = Color("cd7f32")

func _on_Area2D_body_entered(body):
    if body.get_meta("type") == "player":
        if key_color == "gold":
            emit_signal("gold_pickup")
        if key_color == "silver":
            emit_signal("silver_pickup")
        if key_color == "bronze":
            emit_signal("bronze_pickup")
        $Sprite.visible = false
        
