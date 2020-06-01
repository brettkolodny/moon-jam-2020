extends KinematicBody2D

export var speed: int = 200
export var refactory_period: float = 0.25
export (float) var maskStandard = 0.8
export (float) var maskShoot = 1
export (float) var maskScaling = 0.98

var play_backwards: bool
var can_shoot := true
var dead := true
var shrinking = false
var velocity = Vector2.ZERO

var num_bullets := 6


signal player_shot
signal player_reload

func _ready():
    set_meta("type", "player")
    $PlayerLight.texture_scale = maskStandard


func get_input():
    velocity = Vector2()
    
    if Input.is_action_pressed('ui_right'):
        velocity.x += 1
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    velocity = velocity.normalized() * speed


func _process(delta):
    if shrinking:
        $PlayerLight.texture_scale *= maskScaling
        if $PlayerLight.texture_scale < maskStandard:
            $PlayerLight.texture_scale = maskStandard
            shrinking = false
            
      # The player's movement vector.
    if Input.is_action_pressed("ui_right"):
        #velocity.x += 1
        
        if $AnimatedSprite.flip_h:
            play_backwards = true
        else:
            play_backwards = false

    if Input.is_action_pressed("ui_left"):
        #velocity.x -= 1
        
        if $AnimatedSprite.flip_h:
            play_backwards = false
        else:
            play_backwards = true

    if velocity != null:
        if velocity.length() > 0:
        #velocity = velocity.normalized() * speed
        

            $AnimatedSprite.play("run", play_backwards)
        else:
            $AnimatedSprite.play("idle")

    if Input.is_action_just_pressed("ui_shoot_gun"):
        shoot()
        
    if Input.is_action_just_pressed("ui_reload_gun"):
        reload_gun()

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


func _physics_process(delta):
    get_input()
    move_and_slide(velocity)
    
    
func shoot():
    if can_shoot and num_bullets > 0:
        can_shoot = false
        num_bullets -= 1
        $ShotTimer.start(refactory_period)
        
        $GunShotSound.play()
        
        if !$ReloadTimer.is_stopped():
            $ReloadTimer.stop()
        
        $PlayerLight.texture_scale = maskShoot
        shrinking = true
        
        var mouse_vector = get_global_mouse_position()
        
        $ArmJoint/ArmSprite/RayCast2D.look_at(mouse_vector)
        
        var collider = $ArmJoint/ArmSprite/RayCast2D.get_collider()
        
        if collider:
            if collider.get_meta("type") == "enemy":
                collider.call("die")
        
        $ArmJoint/ArmSprite/Gunshot.frame = 0
        $ArmJoint/ArmSprite/Gunshot.play("shoot")
        
        emit_signal("player_shot")
        get_tree().call_group("Enemy", "agro")
        get_tree().call_group("Enemy", "show_on_shot")
    
    if num_bullets == 0:
        reload_gun()


func reload_gun():
    if num_bullets < 6 and $ReloadTimer.is_stopped():
        $ReloadTimer.start(1)


func die():
    Global.goto_scene("res://scenes/Death.tscn")
    
func _on_ShotTimer_timeout():
    can_shoot = true
    

func _on_ReloadTimer_timeout():
    num_bullets += 1
    $ReloadSound.play()
    emit_signal("player_reload")
    
    if num_bullets == 6:
        $ReloadTimer.stop()
