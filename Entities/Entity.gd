class_name Entity
extends KinematicBody2D

signal changed_health

export(int) var max_health: int = 1000
export(int) var speed = 200

var health: int


func _ready():
    health = max_health


func _physics_process(delta):
    z_index = position.y


func get_class() -> String:
    return "Entity"


func get_damage(damage: int) -> void:
    health -= damage
    health = min(max_health, health)
    emit_signal("changed_health")
    if health <= 0:
        die()


func die():
    queue_free()
