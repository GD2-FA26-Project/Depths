# Upgrades and creature log

Open Surface Base and click Upgrades or Creature Log. Both pages have a Back to Base button.

## Creature log

`UI/creature_log/creature_log.tscn` uses an HBoxContainer: an ItemList on the left and a VBoxContainer on the right. The right column contains a TextureRect picture, a name Label, and a scrollable RichTextLabel description.

The ItemList's `item_selected` signal updates the details. Select a row with the mouse or use the arrow keys while the list has focus.

The three entries are draft content for Crab, Coral, and Worm. Edit the `CREATURES` array in `creature_log.gd` to change names, notes, and image paths. The monochrome SVGs in `placeholders/` can be replaced with finished pictures later.

## Upgrades

`UI/upgrades/upgrades.tscn` contains a simple two-column grid with Net, Shock Trap, Drill, and Pulse, using names from the HTML draft. Upgrade buttons are disabled placeholders. There is no resource spending or gameplay effect.

Edit the card Labels in the Inspector to change the upgrade names and descriptions. The script only handles returning to the base.
