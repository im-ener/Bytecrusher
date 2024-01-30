extends ScriptCreateDialog

@onready var gun_sprite = $CanvasLayer/Control/Gunsprite
@onready var gun_rays = $GunRays.get_children()

var can_shoot = true

func _ready():
	gun_sprite.play("idle")
	
func check_hit():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("shoot") and can_shoot:
		gun_sprite.play("shoot")
		check_hit()
		can_shoot = false
		await (gun_sprite)
		
		can_shoot = true
		gun_sprite.play("idle")
