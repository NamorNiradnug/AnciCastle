class_name Sword
extends Area2D

const HIT_ANGLE: float = PI / 1.5

export(int) var damage = 50

var active: bool = false
var ready: bool = true
var parent_rotation: float = 0
var self_rotation: float = 0
var ready_timer: Timer = Timer.new()


func _ready() -> void:
    add_child(ready_timer)
    ready_timer.connect("timeout", self, "set_ready")
    connect("body_entered", self, "_on_hit")


func _physics_process(delta):
    if self_rotation >= HIT_ANGLE / 2:
        active = false
        $Hitbox.disabled = true
        self_rotation = 0
    if active:
        self_rotation += PI / 12
    rotation = self_rotation + parent_rotation


func hit():
    if !active and ready:
        active = true
        $Hitbox.disabled = false
        self_rotation = - HIT_ANGLE / 2
        ready = false
        ready_timer.start(1)


func _on_hit(object: Node2D) -> void:
    if object.get_class() == "Player":
        object.get_damage(damage)


func set_ready():
    ready = true