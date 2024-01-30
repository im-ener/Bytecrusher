extends Node3D

@onready var gun_sprite = $CanvasLayer/Control/Gunsprite
@onready var gun_rays = $GunRays.get_children()


var can_shoot = true
var damage = 8
func _ready():
	gun_sprite.play("idle")
	
func check_hit():
	for ray in gun_rays:
		if ray.is_colliding():
			if ray.get_collider(is_in_group("Enemy")):
				ray.get.collider().take_damage(damage)
	




func _process(delta):
	if Input.is_action_just_pressed("shoot") and can_shoot and PlayerStats.ammo_pistol > 0:
		gun_sprite.play("shoot")
		check_hit()
		PlayerStats.change_pistol_ammo(-1)
		can_shoot = false
		
		await (gun_sprite)
		
		can_shoot = true
		gun_sprite.play("idle")
