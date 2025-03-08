extends Node2D
var biteable

func _on_area_2d_body_entered(body):
	if body.has_method("Player"):
		biteable = true

func _process(_delta):
	if GameManager.biting and biteable:
		$Timer.start()


func _on_area_2d_body_exited(body):
	if body.has_method("Player"):
		biteable = false


func _on_timer_timeout():
	print("Barricade destroyed")
	self.queue_free()
