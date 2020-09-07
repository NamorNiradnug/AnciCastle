class_name Player
extends Entity

signal changed_mana

onready var world: Node2D = get_node("../..")

export(int) var max_mana: int = 1000
export(int) var homing_view_distance: int = 1000
export(int) var mana_regen_speed: int = 1
export(int) var shot_mana: int = 100

var Bullet = preload("res://Objects/Bullet.tscn")
var mana: int
var ready_to_wiz: bool = true
var ready_to_wiz_timer: Timer = Timer.new()
var mana_regen_timer: Timer = Timer.new()


func _ready():
    mana = max_mana
    add_child(ready_to_wiz_timer)
    add_child(mana_regen_timer)
    ready_to_wiz_timer.connect("timeout", self, "set_ready_to_wiz")
    mana_regen_timer.connect("timeout", self, "regen_mana")
    ready_to_wiz_timer.one_shot = true
    mana_regen_timer.start(0.5)


func _physics_process(delta):
    if is_dead():
        return
    var velocity: Vector2
    if Input.is_mouse_button_pressed(BUTTON_RIGHT):
        velocity = get_local_mouse_position()
        if velocity.length() >= 10:
            velocity = velocity.normalized() * speed
            $Animation.flip_h = velocity.x > 0
            move_and_slide(velocity)
    if Input.is_action_pressed("ui_shot"):
        wiz()


func get_class() -> String:
    return "Player"


func set_ready_to_wiz() -> void:
    ready_to_wiz = true    


func regen_mana() -> void:
    mana = min(mana + mana_regen_speed, max_mana)
    emit_signal("changed_mana")


func wiz() -> void:
    if not ready_to_wiz or mana < shot_mana:
        return
    var route: Vector2 = get_local_mouse_position().normalized() * homing_view_distance
    var distance: float
    for monster in get_tree().get_nodes_in_group("Monsters"):
        distance = position.distance_to(monster.position)
        if distance <= route.length():
            route = monster.position - position
    ready_to_wiz = false   
    world.add_child(Bullet.instance().init(route, self))
    mana = max(0, mana - shot_mana)
    emit_signal("changed_mana")
    ready_to_wiz_timer.start(0.5)


func die() -> void:
    $Animation.hide()
    $Hitbox.set_deferred('disabled', true)


func is_dead() -> bool:
    return health <= 0
