extends Camera2D

onready var timer : Timer = $"../ShakeTimer"

export var amplitude : = 6.8
export var duration : = 1.0 setget set_duration
export(float, EASE) var DAMP_EASING : = 1.0
export var shake : = false setget set_shake

var enabled : = false

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    set_process(false)
    self.duration = duration
    pass # Replace with function body.

func _process(delta: float) -> void:
    var damping : = ease(timer.time_left / timer.wait_time, DAMP_EASING)
    offset = Vector2(
        rand_range(amplitude, -amplitude) * damping,
        rand_range(amplitude, -amplitude) * damping)


func _on_ShakeTimer_timeout() -> void:
    self.shake = false

func _on_camera_shake_requested() -> void:
    if not enabled:
        return
    self.shake = true
    
func set_duration(value : float) -> void:
    if timer:
        duration = value
        timer.wait_time = duration
    
func set_shake(value : bool) -> void:
    if timer:
        shake = value
        set_process(shake)
        offset = Vector2()
        if shake:
            timer.start()

func _on_Player_player_shot():
    set_shake(true)
