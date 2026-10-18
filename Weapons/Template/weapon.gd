class_name WeaponData extends Resource

@export var name: StringName
@export_category("Visuals")
@export var weapon_sprite: Texture2D
@export var bullet_sprite: Texture2D

@export_category("Stats")
@export var cooldown: int = 0
@export var ammo: int = 0
@export var speed: int = 0
