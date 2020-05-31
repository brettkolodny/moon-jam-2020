extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var alpha_level = 0
export (float) var alpha_fade = .95

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _process(delta):
    if alpha_level > 0.1:
        alpha_level *= alpha_fade
    else :
        alpha_level = 0
    modulate = Color(1,1,1,alpha_level)
    pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Man_gun_shot(player_position):
    $RayCast2D.look_at(player_position) 
    if $RayCast2D.get_collider() != null:
        if $RayCast2D.get_collider().name == "Man":
            #print("seen")
            alpha_level = 1;
    pass # Replace with function body.


func _on_Lightning_timer_timeout():
    alpha_level = 2;
    pass # Replace with function body.
