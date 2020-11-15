extends Node2D

func _ready():
	$Navigation2D/NavigationPolygonInstance.navpoly.add_polygon($Polygon2D.polygon)
