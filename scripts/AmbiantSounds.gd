extends Node

func play_thunder():
    $Thunder.play()

func _on_LightningTimer_timeout():
    play_thunder()
