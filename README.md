# Auto PNB BFG for Genta Hax

**by Elgato91169**

A Lua Auto PNB (Place and Break) script for Growtopia using the Genta Hax executor.

## Features
- Configurable placement and breaking item IDs.
- Adjustable target tile coordinates.
- Custom pseudo-random delay generator using LCG (no `math.random()`).
- Dynamic tile checking and repeated breaking attempts.
- Continuous execution loop.

## Configuration

```lua
place_id = 5640
break_id = 340

XCoords = {1, 2}
YCoords = 0
```

- `place_id`: Item ID to place.
- `break_id`: Target block ID.
- `XCoords`: Horizontal tile offsets.
- `YCoords`: Vertical tile offset.

## Requirements
- Genta Hax executor with the required Lua functions.
- Compatible Lua runtime.

## Disclaimer
For educational and experimental purposes only. Use responsibly and follow applicable game rules. Use at your own risk.
