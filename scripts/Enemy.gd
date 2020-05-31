extends Area2D

export var speed = 200
export var agro_distance = 100
export var max_agro_distance = 1000
export var attack_distance = 100
export (float) var alpha_fade = .95


var player
var agressive = false
var dead = false
var attacking = false
var alpha_level = 0

func _ready():
    set_meta("type", "enemy")
    add_to_group("Enemy")
    
    if $"../Player":
        player = $"../Player"
        
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var frame = rng.randi_range(0, 4)
    $AnimatedSprite.play("idle")
    $AnimatedSprite.frame = frame

    
func _process(delta):
    if alpha_level > 0.1:
        alpha_level *= alpha_fade
    else :
        alpha_level = 0
        
    modulate = Color(1,1,1,alpha_level)
    
    if dead:
        return
        
    if agressive and player and !attacking:
        if position.distance_to(player.global_position) < attack_distance:
            attack()
        
        else:
            var velocity = position.direction_to(player.global_position).normalized() * speed
            position += velocity * delta
    
    elif player:
        if !agressive and position.distance_to(player.global_position) < agro_distance:
            get_tree().call_group("Enemy", "agro")
    
    if position.distance_to(player.global_position) < 100:
        make_visible()

func agro():
    if !agressive and position.distance_to(player.global_position) < max_agro_distance and !dead:
        $AnimatedSprite.play("run")
        agressive = true

func show_on_shot():
    $PlayerCast.look_at(player.position)
    
    var collider = $PlayerCast.get_collider()
    
    if collider and collider.get_meta("type", "player"):
        make_visible()    

func die():
    $AnimatedSprite.play("death")
    dead = true
    $CollisionShape2D.disabled = true
    $DeleteTimer.start(5)

func attack():
    attacking = true
    $AnimatedSprite.play("attack")

func make_visible():
    #print("added alpha")
    alpha_level = 2    

func _on_DeleteTimer_timeout():
    queue_free()


func _on_AnimatedSprite_animation_finished():
    if $AnimatedSprite.animation == "attack":
        attacking = false
        $AnimatedSprite.play("run")

func _on_AttackArea_body_entered(body):
    if body.get_meta("type") == "player":
        body.call("die")

func _on_AnimatedSprite_frame_changed():
    if $AnimatedSprite.animation == "attack":
        var frame: int = $AnimatedSprite.frame
        
        if frame == 4:
            $AttackArea/CollisionShape2D.disabled = false
        elif frame == 7:
            $AttackArea/CollisionShape2D.disabled = true