extends Control

var bullet_count = 6
var have_bronze_key = false
var have_silver_key = false
var have_gold_key = false


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
    
    $gold_key.modulate = Color( 0.75, 0.75, 0.75, 1 )
    $silver_key.modulate = Color( 0.75, 0.75, 0.75, 1 )
    $bronze_key.modulate = Color( 0.75, 0.75, 0.75, 1 )
    
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
