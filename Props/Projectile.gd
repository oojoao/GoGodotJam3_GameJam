class_name Projectile
extends KinematicBody2D

onready var hitbox := $Hitbox

var damage := 1.0
var speed := 300.0
var ally := true setget change_team

var direction : Vector2

var collided_player : Node

func change_team(var align : bool) -> void:
	ally = align
	if ally:
		hitbox.set_collision_mask(pow(2,2))
	else:
		hitbox.set_collision_mask(pow(2,1))

func projectile_action() -> void:
	collided_player.stats.deal_damage(damage)
	queue_free()
	
func _physics_process(_delta):
	move_and_slide(direction * speed) # warning-ignore:return_value_discarded

func _on_Hitbox_area_entered(area):
	collided_player = area.unit
	projectile_action()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
