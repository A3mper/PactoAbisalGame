extends Node

@export var TorreEnableZone : Array[Area2D]

@export var CartasConTorres: Array[Node2D]


func _ready():
	for Cartas in CartasConTorres:
		if Cartas.has_signal("_on_torre_selected"):
			Cartas._on_torre_selected.connect(_on_torre_is_selected)
		if Cartas.has_signal("_on_torre_de_selected"):
			Cartas._on_torre_de_selected.connect(_on_torre_is_not_selected)

	for Zonas in TorreEnableZone:
		if Zonas.has_signal("_on_torre_zone_entered"):
			Zonas._on_torre_zone_entered.connect(_on_tez_entered)
		if Zonas.has_signal("_on_torre_zone_exited"):
			Zonas._on_torre_zone_exited.connect(_on_tez_exited)


func _on_torre_is_selected() -> void:
	for Zonas in TorreEnableZone:
		if Zonas.has_method("_on_torre_selected"):
			Zonas._on_torre_selected()

func _on_torre_is_not_selected() -> void:
	for Zonas in TorreEnableZone:
		if Zonas.has_method("_on_torre_de_selected"):
			Zonas._on_torre_de_selected()

func _on_tez_entered(_zona:Area2D) -> void:
	for Cartas in CartasConTorres:
		if Cartas.has_method("_on_torre_zone_in"):
			Cartas._on_torre_zone_in()

func _on_tez_exited(_zona:Area2D) -> void:
	for Cartas in CartasConTorres:
		if Cartas.has_method("_on_torre_zone_out"):
			Cartas._on_torre_zone_out()
