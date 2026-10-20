# Main menu draft

Open `UI/main_menu/main_menu.tscn` in Godot and press F6, or press F5 to run the project.

The menu is one title and three default Godot buttons, centered by a CenterContainer and VBoxContainer.

- New Game opens `UI/surface_base/surface_base.tscn`. Use Go Diving, then Start Diving to enter gameplay.
- Continue is disabled until saving is implemented.
- Settings opens a basic volume/fullscreen dialog. Changes last for the current run.

Edit labels and button text in the scene Inspector. Button actions are in `UI/main_menu/main_menu.gd`.

There are no background assets, decorations, custom themes, animations, or transitions.
