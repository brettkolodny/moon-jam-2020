extends Node

func _ready():
    $WhaleHighTimer.start(20)
    $WhaleMidTimer.start(50)


func play_thunder():
    $Thunder.play()
    
    
func _on_LightningTimer_timeout():
    play_thunder()


func _on_WhaleHighTimer_timeout():
    $WhaleHigh.play()
    var rand_delay = rand_range(80, 300)
    $WhaleHighTimer.start(rand_delay)
    

func _on_WhaleMidTimer_timeout():
    $WhaleMid.play()
    var rand_delay = rand_range(60, 200)
    $WhaleMidTimer.start(rand_delay)
