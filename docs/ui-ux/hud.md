# Gameplay HUD

Open `UI/hud/hud.tscn` to edit the layout. It is already instanced as `HUD` in `Stage/stage.tscn`. Run the stage with F6, or use New Game → Go Diving → Start Diving.

The four corners contain:

- Top left: hull label and horizontal bar.
- Top right: resource count and depth in meters.
- Bottom left: two weapon slot placeholders.
- Bottom right: oxygen percentage and a vertical bar that fills upward.

## How the nodes work

`HUD` is a CanvasLayer, so it stays on the screen while the player's Camera2D moves. Its `Screen` Control fills the viewport. The four corner groups use anchors and offsets to stay near the edges.

PanelContainers provide plain gray panels. MarginContainers add space inside them. VBoxContainers stack labels and bars vertically; the weapon HBoxContainer arranges the two slots horizontally. Every Control ignores the mouse, so aiming and shooting can continue over the HUD.

The two ProgressBars share simple gray styles. `OxygenBar` uses the Bottom to Top fill mode. Weapon names are ordinary Label text and can be edited directly in the scene.

## Values in this draft

Select the HUD root to set `Hull Percent`, `Oxygen Percent`, and `Resource Count` in the Inspector. These are placeholders: damage, oxygen consumption, resource collection, and selected loadouts are not connected yet. Nothing automatically drains or awards resources.

The stage updates depth using downward distance from the player's spawn point. Godot's Y coordinate increases downward. The Stage Inspector's `Pixels Per Meter` setting defaults to 10, so moving down 100 pixels adds 10 meters. Moving above the starting height displays 0 meters.

The HUD script has four small functions for connecting future game systems:

```gdscript
$HUD.set_hull(75.0)
$HUD.set_oxygen(40.0)
$HUD.set_resources(12)
$HUD.set_depth(30.0)
```

These examples are called from the Stage after the HUD is ready. Hull and oxygen accept percentages from 0 to 100; resources and depth cannot display negative values. The stage already supplies depth each frame.
