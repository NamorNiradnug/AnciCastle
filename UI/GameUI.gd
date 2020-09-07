extends Control

onready var player: Player = get_node("../../Entities Layer/Player")


func _ready():
    $PlayerHealth.max_value = player.max_health
    $PlayerHealth.value = player.health
    $PlayerMana.max_value = player.max_mana
    $PlayerMana.value = player.mana
    player.connect("changed_health", self, "_on_player_changed_health")
    player.connect("changed_mana", self, "_on_player_changed_mana")


func _on_player_changed_health():
    $PlayerHealth.value = player.health


func _on_player_changed_mana():
    $PlayerMana.value = player.mana
    print("mana ", player.mana)
