extends Control

var bullet_count = 6
var have_bronze_key = false
var have_silver_key = false
var have_gold_key = false

var key_color = Color(.25,.25,.25,1)

func _ready():
    drawUI()
    
    
func key_trigger():
    #set a have_color_key to true then call the drawUI()
    pass


func bullet_count_up():
     if bullet_count < 6:
        bullet_count += 1
        drawUI()
    
    
func bullet_count_down():
    if bullet_count > 0:
        bullet_count -= 1
        drawUI()
   
 
func drawUI():
    $UI_Bullet1.visible = false
    $UI_Bullet2.visible = false
    $UI_Bullet3.visible = false
    $UI_Bullet4.visible = false
    $UI_Bullet5.visible = false
    $UI_Bullet6.visible = false
    
    $gold_key.modulate = key_color
    $silver_key.modulate = key_color
    $bronze_key.modulate = key_color
    
    if bullet_count == 1:
        $UI_Bullet1.visible = true
        $UI_Bullet2.visible = false
        $UI_Bullet3.visible = false
        $UI_Bullet4.visible = false
        $UI_Bullet5.visible = false
        $UI_Bullet6.visible = false
    if bullet_count == 2:
        $UI_Bullet1.visible = true
        $UI_Bullet2.visible = true
        $UI_Bullet3.visible = false
        $UI_Bullet4.visible = false
        $UI_Bullet5.visible = false
        $UI_Bullet6.visible = false
    if bullet_count == 3:
        $UI_Bullet1.visible = true
        $UI_Bullet2.visible = true
        $UI_Bullet3.visible = true
        $UI_Bullet4.visible = false
        $UI_Bullet5.visible = false
        $UI_Bullet6.visible = false
    if bullet_count == 4:
        $UI_Bullet1.visible = true
        $UI_Bullet2.visible = true
        $UI_Bullet3.visible = true
        $UI_Bullet4.visible = true
        $UI_Bullet5.visible = false
        $UI_Bullet6.visible = false
    if bullet_count == 5:
        $UI_Bullet1.visible = true
        $UI_Bullet2.visible = true
        $UI_Bullet3.visible = true
        $UI_Bullet4.visible = true
        $UI_Bullet5.visible = true
        $UI_Bullet6.visible = false
    if bullet_count == 6:
        $UI_Bullet1.visible = true
        $UI_Bullet2.visible = true
        $UI_Bullet3.visible = true
        $UI_Bullet4.visible = true
        $UI_Bullet5.visible = true
        $UI_Bullet6.visible = true
        
    if have_bronze_key:
        $bronze_key.modulate = Color("cd7f32")
    
    if have_silver_key:
        $silver_key.modulate = Color("c0c0c0")
    
    if have_gold_key:
        $gold_key.modulate = Color("ffd700")


func _on_Player_player_shot():
    bullet_count_down()


func _on_Player_player_reload():
    bullet_count_up()


func _on_SilverKey_silver_pickup():
    if !have_silver_key:
        print("Pick up!")
        $KeyPickUpNoise.play()
        have_silver_key = true
        drawUI()
    pass # Replace with function body.


func _on_GoldKey_gold_pickup():
    if !have_gold_key:
        print("Pick up!")
        $KeyPickUpNoise.play()
        have_gold_key = true
        drawUI()
    pass # Replace with function body.


func _on_BronzeKey_bronze_pickup():
    if !have_bronze_key:
        print("Pick up!")
        $KeyPickUpNoise.play()
        have_bronze_key = true
        drawUI()
    pass # Replace with function body.


func _on_Door_body_entered(body):
    if have_bronze_key and have_silver_key and have_gold_key:
        print("winnner")
    else :
        print("locked")
    pass # Replace with function body.
