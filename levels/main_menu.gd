extends Node3D

@onready var hSliderMaster: HSlider = $ui/settings/Panel/MarginContainer/VBoxContainer/master_volume
@onready var hSliderMusic: HSlider = $ui/settings/Panel/MarginContainer/VBoxContainer/music_volume
@onready var hSliderEffects: HSlider = $ui/settings/Panel/MarginContainer/VBoxContainer/sound_effects_volume

@onready var audioStreamPlayerMusic: AudioStreamPlayer = $AudioStreamPlayerMusic
@onready var audioStreamPlayerEffects: AudioStreamPlayer = $AudioStreamPlayerEffects

@onready var sceneLoader = get_node("/root/SceneLoader")

func _ready() -> void:
	hSliderMaster.value = AudioControl.get_master_bus_volume_linear()
	hSliderMusic.value = AudioControl.get_music_bus_volume_linear()
	hSliderMusic.value = 1
	hSliderEffects.value = AudioControl.get_effects_bus_volume_linear()
	hSliderMusic.value = 1

func _on_play_pressed():
	sceneLoader.goToGame()

func _on_settings_pressed() -> void:
	get_node("/root/main_menu/ui/settings").show()
	get_node("/root/main_menu/ui/main_menu").hide()

func _on_back_pressed() -> void:
	get_node("/root/main_menu/ui/settings").hide()
	get_node("/root/main_menu/ui/main_menu").show()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_master_volume_value_changed(value: float) -> void:
	AudioControl.set_master_bus_volume_linear(value)

func _on_music_volume_value_changed(value: float) -> void:
	AudioControl.set_music_bus_volume_linear(value)

func _on_sound_effects_volume_value_changed(value: float) -> void:
	AudioControl.set_effects_bus_volume_linear(value)
