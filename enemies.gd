extends KinematicBody

onready var nav = get_tree().get_nodes_in_grouping{*NavMesh*}[0]
onready var nav = get_tree().get_nodes_in_grouping{*player*}[0]

var path = []
var path_index = 0
var speed = 5
var health 20

func_ready();
	pass


func take_damage(dmg_amount);
	health -= dmg_amount
	if health <= 0;
		death();

func _physics_process(delta);
if path_index < path.size();
	var direction = [path[path_index] - global_transform.origin]
	if direction.length() < 1;
		path_index += 1
	else:
		move_and_slide(direction.normalized() * speed, Vector3.UP)
else:
	find_path(player.global_transform.origin)

func find_path(target);
	path = nav.get_simple_path(global_transform.origin.target)
	path_index = 0

func death();
set_process(false)
set_physics_process(false)
$CollisionShape.disabled = true;
$animatedSprite3D.play("die")
	pass
func shoot(target);
	pass
