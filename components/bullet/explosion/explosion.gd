extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
func _ready():
    animated_sprite.animation_finished.connect(queue_free)
    animated_sprite.play("default")
