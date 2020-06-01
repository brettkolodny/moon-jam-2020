extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()
var mod_color = .04
var mod_target = .04

# Called when the node enters the scene tree for the first time.
func _ready():
    rng.randomize()
    wait_time = rng.randi_range(10,30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#	pass
#	pass
 
func _process(delta):
    if mod_color > mod_target:
        mod_color -= 0.005
        $"../CanvasModulate".color = Color(mod_color, mod_color, mod_color, 1)
    pass


func _on_LightningTimer_timeout():
    #print("lightning Strike")
    mod_color = 0.5
    $"../CanvasModulate".color = Color(mod_color, mod_color, mod_color, 1)
    get_tree().call_group("Enemy", "make_visible")
    pass # Replace with function body.
