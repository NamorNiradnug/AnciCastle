extends Area2D 

const SPEED: int = 10

var velocity: Vector2
var parent: Node2D
var damage = 150
var damaged: bool = false

func init(velocity_: Vector2, parent_: KinematicBody2D):
    velocity = velocity_.normalized()
    parent = parent_
    position = parent.position
    connect("body_entered", self, "hit")
    return self


func _physics_process(delta) -> void:
    # becouse hitbox can be small
    for _counter in range(SPEED):
        position += velocity


func hit(object: Node2D) -> void:
    if object == parent:
        return
    if object.get_class() == "Monster" and !damaged:
        object.get_damage(damage)
        damaged = true
    queue_free()
