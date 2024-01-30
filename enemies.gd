extends CharacterBody3D

#@onready var nav = get_tree().get_nodes_in_group("NavMesh")[0]
#@onready var player= get_tree().get_nodes_in_group("Player")[0]

#var path = [] #hold the path coordinate from the enemy to the player
#var path_index = 0 #keep track of which coordinate to go to
#var speed = 3 #change if needed
#var health = 20 #change if needed

func _ready():
	pass

#func take_damage(dmg_amount):
#	health -= dmg_amount
#	if health <= 0:
#		death()

#func _physics_process(_delta):
#	if path_index < path.size():
#		var direction = (path[path_index] - global_transform.origin)
#		if direction.length() <1:
#			path_index += 1
#		else:
#			velocity = direction * speed
#			move_and_slide()
	else:
		find_path(player.global_transform.origin)

func find_path(target):
	path = nav.get_simple_path(global_transform.origin,target)
	path_index = 0

func death():
	set_process(false)
	set_physics_process(false)
	$CollisionShape.disabled = true
	$AnimatedSprite3D.play("die")

func shoot(_target):
	pass
