class_name Dialog
extends RichTextLabel

signal end

export(Array, String) var phrases;
var cur_phrase: int;
var timer: Timer;


func _ready() -> void:
    timer = Timer.new()
    cur_phrase = -1
    add_child(timer)
    timer.connect("timeout", self, "_on_timer_timeout")
    show_next_phrase()
    hide()
    start()


func _input(event) -> void:
    if event.is_action_released("ui_accept"):
        show_next_phrase()


func start() -> void:
    show()
    timer.start(0.1)


func _on_timer_timeout() -> void:
    if len(text) != visible_characters:
        visible_characters += 1


func show_next_phrase() -> void:
    cur_phrase += 1
    if cur_phrase >= len(phrases):
        self.hide()
        print("hide ", cur_phrase)
        timer.stop()
        cur_phrase = -1
        emit_signal("end")
    else:
        text = phrases[cur_phrase]
        visible = 0
