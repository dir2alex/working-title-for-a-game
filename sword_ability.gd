extends MovementAbility3D
class_name SwordAbility3D


@onready var sword_anim: AnimationPlayer = $SWORD_ANIM
@onready var weapon_swing: Key
@onready var sword_sfx: AudioStreamPlayer3D = $"../../sword sfx"

func _physics_process(float):
	if Input.is_key_label_pressed(KEY_Z):
		sword_anim.play("sword_test1")
		sword_anim.set_speed_scale(8.0)
		$"../../sword sfx".play()
