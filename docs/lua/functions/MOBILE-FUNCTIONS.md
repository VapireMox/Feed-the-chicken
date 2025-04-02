# Mobike Functions API

Functions to interact with touch controls and vibration features in the game.

## Touch Controls

### `touchC()`
Returns the current state of the touch controls for the game.

- **Returns**: Current touch control state.

### `mobileControlsMode()`
Returns the current mobile controls mode.

- **Returns**: String value indicating the mobile control mode (e.g., `"hitbox"`).

### `extraHintPressed(hint)`
Checks if a specific extra hint button is pressed.

- **hint**: The hint name (e.g., `'second'`).
- **Returns**: Boolean value (`true` or `false`).

### `extraHintJustPressed(hint)`
Checks if a specific extra hint button was just pressed.

- **hint**: The hint name (e.g., `'second'`).
- **Returns**: Boolean value (`true` or `false`).

### `extraHintJustReleased(hint)`
Checks if a specific extra hint button was just released.

- **hint**: The hint name (e.g., `'second'`).
- **Returns**: Boolean value (`true` or `false`).

### `extraHintReleased(hint)`
Checks if a specific extra hint button has been released.

- **hint**: The hint name (e.g., `'second'`).
- **Returns**: Boolean value (`true` or `false`).

## Vibration

### `vibrate(duration, period)`
Triggers vibration on the device.

- **duration**: The duration of the vibration in milliseconds.
- **period** (optional): The period of vibration in milliseconds. Default is 0 (no periodic vibration).
- **Returns**: None.
