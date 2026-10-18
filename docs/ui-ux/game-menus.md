# Map and dive menu

Run `Stage/stage.tscn` with F6, or start a dive from the surface base.

- **M:** open/close the map. From the dive menu, M switches to the map.
- **Esc:** open the dive menu. If either page is open, Esc closes it and resumes.
- Both pages pause the player, enemies, projectiles, and timers.
- **Return to Surface Base:** leave the current dive and open the existing base scene. A subsequent dive starts a fresh stage; this draft has no run-saving or reward system.

The scenes are `UI/map_menu/map_menu.tscn` and `UI/pause_menu/pause_menu.tscn`. `UI/game_menus/game_menus.tscn` holds both in a CanvasLayer above the HUD. Its Process Mode is Always, so its input and buttons work during a pause. Its script handles opening, closing, and button connections.

## Cell layout

The existing stage is one test arena, without an assembled-room generator. The map therefore uses a sample layout. Select the Stage root in the Inspector to edit:

- `Map Cells`: grid coordinates of the cells, in display-number order.
- `Map Origin`: world position of the top-left corner of grid coordinate (0, 0).
- `Map Cell Size`: width and height of one world cell, in pixels. Both should be positive.

The defaults divide the test area into 700 × 500 pixel cells. The player starts in cell 5 at grid coordinate (1, 1). Position changes are reflected the next time the map opens. Moving outside the supplied cell coordinates shows “Outside mapped cells” and clears the highlight.

`cell_map.gd` draws rectangles and connects adjacent grid coordinates. The light cell marked YOU is the player's current cell. All supplied cells are visible; there is no exploration fog. This is a schematic grid, not a collision map of the current arena.

When a room generator exists, supply its actual grid coordinates, origin, and size in the Stage. If adjacent rooms can have closed walls, the map's connection logic will also need actual doorway data; this draft assumes every adjacent pair connects.

## Dive menu data

The Stage's exported `Current Objectives` and `Collected Items` arrays populate the two lists whenever the menu opens. Objectives are draft text and items start empty. Change these arrays in the Inspector to preview other content. Gameplay systems can update the same arrays later; this change does not add item collection or objective completion logic.

Depth uses the same calculation as the HUD, and resources read the HUD's current resource count. Both refresh when the dive menu opens.
