# Android Functions API

Functions to interact with Android-specific features in the game.

## Android Device Information

### `isDolbyAtmos()`
Checks if the device supports Dolby Atmos.

- **Returns**: Boolean value (`true` or `false`).

### `isAndroidTV()`
Checks if the device is running Android TV.

- **Returns**: Boolean value (`true` or `false`).

### `isTablet()`
Checks if the device is a tablet.

- **Returns**: Boolean value (`true` or `false`).

### `isChromebook()`
Checks if the device is a Chromebook.

- **Returns**: Boolean value (`true` or `false`).

### `isDeXMode()`
Checks if the device is in DeX mode (Samsung's desktop-like environment).

- **Returns**: Boolean value (`true` or `false`).

## Android Input Handling

### `backJustPressed()`
Checks if the back button was just pressed.

- **Returns**: Boolean value (`true` or `false`).

### `backPressed()`
Checks if the back button is currently pressed.

- **Returns**: Boolean value (`true` or `false`).

### `backJustReleased()`
Checks if the back button was just released.

- **Returns**: Boolean value (`true` or `false`).

### `menuJustPressed()`
Checks if the menu button was just pressed.

- **Returns**: Boolean value (`true` or `false`).

### `menuPressed()`
Checks if the menu button is currently pressed.

- **Returns**: Boolean value (`true` or `false`).

### `menuJustReleased()`
Checks if the menu button was just released.

- **Returns**: Boolean value (`true` or `false`).

## Device Orientation

### `getCurrentOrientation()`
Gets the current orientation of the device.

- **Returns**: String value representing the current orientation (e.g., "Portrait", "Landscape").

### `setOrientation(hint)`
Sets the orientation of the device.

- **hint**: The orientation to set. Possible values include:
  - `'Portrait'`
  - `'PortraitUpsideDown'`
  - `'LandscapeLeft'`
  - `'LandscapeRight'`
- **Returns**: None. Logs an error if no valid orientation is provided.

## System Controls

### `minimizeWindow()`
Minimizes the application window.

- **Returns**: None.

### `showToast(text, duration, xOffset = 0, yOffset = 0)`
Displays a toast message on the screen.

- **text**: The text to display in the toast.
- **duration**: Duration of the toast message (e.g., `Toast.LENGTH_SHORT`, `Toast.LENGTH_LONG`).
- **xOffset** (optional): Horizontal offset for the toast position.
- **yOffset** (optional): Vertical offset for the toast position.
- **Returns**: None.

### `isScreenKeyboardShown()`
Checks if the on-screen keyboard is currently displayed.

- **Returns**: Boolean value (`true` or `false`).

### `clipboardHasText()`
Checks if there is text currently in the clipboard.

- **Returns**: Boolean value (`true` or `false`).

### `clipboardGetText()`
Gets the current text from the clipboard.

- **Returns**: String value representing the clipboard text.

### `clipboardSetText(text)`
Sets the provided text to the clipboard.

- **text**: The text to copy to the clipboard.
- **Returns**: None.

### `manualBackButton()`
Simulates pressing the back button manually.

- **Returns**: None.

### `setActivityTitle(text)`
Sets the title of the activity.

- **text**: The title text to display for the activity.
- **Returns**: None.
