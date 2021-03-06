extends Area2D

export var speed = 200
export var agro_distance = 100
export var max_agro_distance = 300
export var attack_distance = 60
export (float) var alpha_fade = .99


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
    if !dead:
        if alpha_level > 0.1:
            alpha_level *= alpha_fade
        else :
            alpha_level = 0
    else:
        alpha_level = 2
    
        
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
    
    #add alpha scaler via postit code
    if position.distance_to(player.global_position) < 300 and !agressive:
        alpha_level = 1.5 * (1 - position.distance_to(player.global_position)/300)
        pass

func agro():
    if !agressive and position.distance_to(player.global_position) < max_agro_distance and !dead:
        $AnimatedSprite.play("run")
        play_agro_sound()
        agressive = true

func play_agro_sound():
    var delay = rand_range(0, 1)
    $AgroSoundTimer.start(delay)

func show_on_shot():
    if position.distance_to(player.global_position) < 600:
        make_visible()
    #$PlayerCast.look_at(player.global_position)
    
    #var collider = $PlayerCast.get_collider()
    
   # print(player)
    #print(collider)
    
    #if collider and collider == player:
       # print("made vis")
        #make_visible()    

func die():
    $AnimatedSprite.play("death")
    $DeathSound.play()
    dead = true
    $CollisionShape2D.disabled = true
    $DeleteTimer.start(5)

func attack():
    attacking = true
    make_visible()
    $AnimatedSprite.play("attack")
    $AttackSound.play()

func make_visible():
    alpha_level = 2   

func _on_DeleteTimer_timeout():
   pass


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
        
        if frame == 6:
            $AttackArea/CollisionShape2D.disabled = false
        elif frame == 7:
            $AttackArea/CollisionShape2D.disabled = true


func _on_AgroSoundTimer_timeout():
    $AgroSound.play()
