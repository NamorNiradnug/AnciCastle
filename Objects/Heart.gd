class_name Heart
extends Area2D

export(int) var hp_plus = 100


func _on_body_entered(entity: Node2D) -> void:
    if entity.get_class() == "Player":
        entity.get_damage(-hp_plus)
        queue_free()
