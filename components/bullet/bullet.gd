extends Area2D

var velocity := Vector2.ZERO

func _ready():
    body_entered.connect(_on_body_entered)

func _physics_process(delta):
    position += velocity * delta

func _on_body_entered(body):
    queue_free()  # destroy on impact
