extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const BULLET_VELOCITY = 200

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pivot = $GunPivot
@onready var muzzle = $GunPivot/MuzzlePoint

const BULLET = preload("res://components/bullet/bullet.tscn")

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Handle jump.
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Input direction: -1 ->  left, 0 -> none, 1 -> right
    var direction := Input.get_axis("move_left", "move_right")
    if direction > 0:
        animated_sprite.flip_h = false
    elif direction < 0:
        animated_sprite.flip_h = true
        
    if not is_on_floor():
        animated_sprite.play("jump")
    elif direction == 0:
        animated_sprite.play("idle")
    else:
        animated_sprite.play("run")
        
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    pivot.look_at(get_global_mouse_position())
    if Input.is_action_just_pressed("shoot"):
        var shootVector = (muzzle.global_position - pivot.global_position).normalized()
        shoot(shootVector)

    move_and_slide()
    
func shoot(direction: Vector2) -> void:
    var bullet := BULLET.instantiate()
    add_sibling(bullet)
    bullet.global_position = muzzle.global_position
    bullet.velocity = direction.normalized() * BULLET_VELOCITY
