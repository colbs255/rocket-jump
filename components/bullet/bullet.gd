extends Area2D

var velocity := Vector2.ZERO

func _physics_process(delta):
    position += velocity * delta

func _on_body_entered(body):
    queue_free()  # destroy on impact
