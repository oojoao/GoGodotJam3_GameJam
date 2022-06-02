class_name Unit
extends KinematicBody2D

onready var projectile := preload("res://Props/Projectile.tscn")

onready var animPlayback = get_node("AnimationTree").get("parameters/playback")
onready var sprite := $Sprite
onready var stats := $Stats
onready var hitbox := $Hitbox
var velocity : Vector2

var ally := true setget change_team

func change_team(var align : bool) -> void:
	ally = align
	if ally:
		hitbox.set_collision_layer(pow(2,1))
	else:
		hitbox.set_collision_layer(pow(2,2))
	
func death() -> void:
	queue_free()
	if ally:
		get_tree().paused = true

func _ready():
	if name != "Player":
		self.ally = false
	stats.connect("no_health", self, "death") # warning-ignore:return_value_discarded

func _physics_process(_delta):
	velocity = move_and_slide(velocity)
	
	if velocity == Vector2.ZERO:
		animPlayback.travel("Idle")
	else:
		animPlayback.travel("Walk")
		if velocity.x != 0:
			sprite.flip_h = velocity.x < 0
