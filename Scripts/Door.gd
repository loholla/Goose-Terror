extends Node2D

func _on_area_2d_body_entered(body):
	if body.has_method("Player"):
		print("Door opened")
		$"Sprite2D-Closed".visible = false
		$"Sprite2D-Opened".visible = true
		$StaticBody2D.queue_free()
		$Area2D.queue_free()
