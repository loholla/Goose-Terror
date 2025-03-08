extends Node2D

func _on_area_2d_body_entered(body):
	if body.has_method("Player"):
		print("Double Jump skill acquired")
		GameManager.skillDJ = true
		self.queue_free()
