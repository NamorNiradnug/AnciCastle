class_name Monster
extends Entity

export(int) var view_distance = 400

onready var player: Player = get_node("../Player")

var random_velocity: Vector2 = Vector2.ZERO
var time_from_last_velocity_changed: float = INF


func _physics_process(delta):
    var to_player: Vector2 = player.position - position
    time_from_last_velocity_changed += delta
    if player.is_dead() or to_player.length() > view_distance:
        if time_from_last_velocity_changed > rand_range(1, 4):
            var rr = randf()
            if rr < 0.33:
                random_velocity = Vector2.ZERO
            else:
                random_velocity = Vector2(randf() - 0.5, randf() - 0.5)
                if random_velocity.length() != 0:
                    random_velocity = random_velocity.normalized() * speed / 2
            time_from_last_velocity_changed = 0
        move(random_velocity)
    else:
        $Sword.parent_rotation = to_player.angle() + PI / 2
        if to_player.length() >= 40:
            var velocity: Vector2 = (player.position - position).normalized() * speed
            move(velocity)
        else:
            $Sword.hit()


func move(velocity: Vector2) -> void:
    if velocity != Vector2.ZERO:
        move_and_slide(velocity)
        $Ainmation.flip_h = velocity.x > 0
        $Sword.parent_rotation = velocity.angle() + PI / 2
    

func get_class() -> String:
    return "Monster"
