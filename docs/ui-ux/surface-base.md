# Surface base and dive preparation

Run `UI/surface_base/surface_base.tscn` with F6, or use New Game from the main menu.

- Go Diving hides the base buttons and moves Camera2D to the right over half a second.
- Once the camera stops, the weapon-selection panel appears on the right.
- Each OptionButton offers Harpoon and Submarine Gun as UI placeholders. Select either option in either slot; these choices do not change combat.
- Start Diving loads the existing `Stage/stage.tscn`.
- Back hides preparation, moves the camera back, and shows the base buttons. Choices remain selected while returning to the base and reopening preparation.

The existing shore and submarine polygons remain in SurfaceBase/Background. Their points, positions, scales, and colors are unchanged.

```text
SurfaceBase (Control + surface_base.gd)
├── Background                 # Existing artwork
├── Camera2D                   # Moves the world view
└── Interface (CanvasLayer)    # UI stays fixed while the camera moves
    ├── BaseMenu (VBoxContainer)
    │   ├── UpgradeButton
    │   ├── CreatureLogButton
    │   └── GoDivingButton
    └── DivePreparation        # Instance of dive_preparation.tscn
        └── WeaponMenu (VBoxContainer)
            ├── Slot1Label / Slot1Options
            ├── Slot2Label / Slot2Options
            ├── StartDivingButton
            └── BackButton
```

Base menu button signals connect to SurfaceBase in the scene file. Start and Back inside the instanced preparation scene are connected in `_ready()` so they remain connected after editor saves. `surface_base.gd` contains the camera movement and scene change. A Tween changes the camera's position over time; `await tween.finished` waits until it has arrived before showing the next menu.

Select SurfaceBase and adjust **Camera Shift** to move the submarine farther left or right in the preparation view. **Camera Move Duration** controls how long the movement takes. These values are exported by the script so they appear in the Inspector.

Open `dive_preparation.tscn` to edit the right-hand panel. Select an OptionButton and edit its **Items** to change the placeholder weapon names. Running this panel by itself only previews the layout; SurfaceBase connects its Start and Back actions.

Upgrades opens the placeholder upgrade grid. Creature Log opens the selectable list and creature details. Each page has a Back to Base button.
