extends CharacterBody3D

@onready var animated_sprite_2d = $CanvasLayer/gunbase/AnimatedSprite2D
@onready var ray_cast_3d = $RayCast3D
@onready var shoot_sound = $shootsound
@onready var camera = $Camera3D
@export var fall_acceleration = 75

const SPEED = 8.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

const MOUSE_SENS = 0.5

var can_shoot = true
var dead = false
var jump_strength = 25

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animated_sprite_2d.animation_finished.connect(shoot_anim_done)
	$CanvasLayer/deathscreen/Panel/Button.button_up.connect(restart)

func _input(event):
	if dead:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENS
		camera.rotation_degrees.x -= event.relative.y * MOUSE_SENS
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x,-88,90)



func jump():
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_strength

func _process(_delta):
	
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	
	if dead:
		return
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(_delta):
	if not is_on_floor():
		velocity.y -= gravity * _delta
	if dead:
		return
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()

func restart():
	get_tree().reload_current_scene()

func shoot():
	if !can_shoot:
		return
	can_shoot = false
	animated_sprite_2d.play("shoot")
	shoot_sound.play()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill"):
		ray_cast_3d.get_collider().kill()

func shoot_anim_done():
	can_shoot = true
	animated_sprite_2d.play("idle")

func kill():
	dead = true
	$CanvasLayer/deathscreen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
