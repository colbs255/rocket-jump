extends Area2D

var velocity := Vector2.ZERO
const EXPLOSION_SCENE := preload("res://components/bullet/explosion/explosion.tscn")

func _ready():
    body_entered.connect(_on_body_entered)

func _physics_process(delta):
    position += velocity * delta

func _on_body_entered(body):
    var explosion := EXPLOSION_SCENE.instantiate()
    explosion.position = position
    add_sibling(explosion)
    queue_free()
