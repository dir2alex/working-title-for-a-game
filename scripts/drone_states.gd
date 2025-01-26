extends CharacterBody3D


var previous_state = "idle"
var current_state = "idle"
var next_state

var speed = 3
var player

@onready var anim_states: AnimationPlayer = $DRONE_LFRB/AnimationPlayer


func _process(delta: float) -> void:
	var direction = navi.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, delta * 10.0)
	
	move_and_slide()
	
func _physics_process(delta: float) -> void:
	previous_state = current_state
	current_state = next_state
	
	match current_state:
		"idle":
			idle()
		"attack":
			attack()
		"chase":
			chase()
			
@onready var navi: NavigationAgent3D = $agent

func chase():
	look_at(player.position)
	navi.target_position = player.global_position
	
func idle():
	$DRONE_LFRB/AnimationPlayer.play("idle")
	
func attack():
	$DRONE_LFRB/AnimationPlayer.play("attack")
	


func _on_area_of_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		next_state = attack()


func _on_area_of_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		next_state = idle()
		
