extends KinematicBody2D

export var speed: int = 200
export var refactory_period: float = 0.25
export (float) var maskStandard = 0.8
export (float) var maskShoot = 1
export (float) var maskScaling = 0.98

var screen_size: Vector2
var play_backwards: bool
var can_shoot: bool = true
var dead: bool = true
var shrinking = false

signal player_shot

func _ready():
    screen_size = get_viewport_rect().size
    set_meta("type", "player")

func _process(delta):
    if shrinking:
        $PlayerLight.texture_scale *= maskScaling
        if $PlayerLight.texture_scale < maskStandard:
            $PlayerLight.texture_scale = maskStandard
            shrinking = false
            
    var velocity = Vector2()  # The player's movement vector.
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
        
        if $AnimatedSprite.flip_h:
            play_backwards = true
        else:
            play_backwards = false

    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
        
        if $AnimatedSprite.flip_h:
            play_backwards = false
        else:
            play_backwards = true

    if Input.is_action_pressed("ui_down"):
        velocity.y += 1

    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1

    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        
        position += velocity * delta
        position.x = clamp(position.x, 0, screen_size.x)
        position.y = clamp(position.y, 0, screen_size.y)

        $AnimatedSprite.play("run", play_backwards)
    else:
        $AnimatedSprite.play("idle")

    if Input.is_action_just_pressed("ui_shoot_gun"):
        shoot()

    var local_mouse_pos = get_local_mouse_position()
    
    var ray_gun_offset = 12
    if local_mouse_pos.x > 0:
        if $AnimatedSprite.flip_h:
            $AnimatedSprite.flip_h = false
        
            $ArmJoint.position.x += 15
            $ArmJoint.position.y -= 3
            
            $ArmJoint/ArmSprite/Gunshot.position.y -= ray_gun_offset
            
            $ArmJoint/ArmSprite/RayCast2D.position.y -= ray_gun_offset
            
            $ArmJoint/ArmSprite.flip_v = false
    else:
        if !$AnimatedSprite.flip_h:
            $AnimatedSprite.flip_h = true
            
            $ArmJoint.position.x -= 15
            $ArmJoint.position.y += 3
            
            $ArmJoint/ArmSprite/Gunshot.position.y += ray_gun_offset
            
            $ArmJoint/ArmSprite/RayCast2D.position.y += ray_gun_offset
            
            $ArmJoint/ArmSprite.flip_v = true
        
    $ArmJoint.look_at(get_global_mouse_position())
    
func shoot():
    if can_shoot:
        can_shoot = false
        $ShotTimer.start(refactory_period)
        
        $PlayerLight.texture_scale = maskShoot
        shrinking = true
        
        emit_signal("player_shot")
        
        var mouse_vector = get_global_mouse_position()
        
        $ArmJoint/ArmSprite/RayCast2D.look_at(mouse_vector)
        
        var collider = $ArmJoint/ArmSprite/RayCast2D.get_collider()
        
        if collider:
            if collider.get_meta("type") == "enemy":
                collider.call("die")
        
        $ArmJoint/ArmSprite/Gunshot.frame = 0
        $ArmJoint/ArmSprite/Gunshot.play("shoot")
        
        get_tree().call_group("Enemy", "agro")
        get_tree().call_group("Enemy", "show_on_shot")
        
        
func die():
    print("Player has died")

func _on_ShotTimer_timeout():
    can_shoot = true
