extends Node

var current_scene: Node = null

func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() - 1)

func _process(delta):
    if Input.is_action_just_pressed("ui_quit"):
        get_tree().quit()

func goto_scene(path):
    call_deferred("_deferred_goto_scene", path)
    
func _deferred_goto_scene(path):
    current_scene.free()
    
    var scene = ResourceLoader.load(path)
    
    current_scene = scene.instance()
    
    get_tree().get_root().add_child(current_scene)
    get_tree().set_current_scene(current_scene)
