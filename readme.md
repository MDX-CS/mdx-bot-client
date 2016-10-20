# MdxBot racket client

To use this library simply download the `GameClient.rkt` file and import it into your script via:
`(require "GameClient.rkt")`
Note that for the client to work, you have to be connected to the MDX VPN.

## Functions

### `getGoal`

The `getGoal` function returns a list of coordinates of the current goal.

```racket
(getGoal)

; '(7 8)
```

---

### `getCurPos`

The `getCurPos` function returns a list of coordinates of the mdx bot.
  
```racket
(getCurPos)

; '(1 2)
```

---

### `move`

The `move` function moves the bot in given direction and returns its new position. Accepted directions are as follows:
- `x+` moves the bot towards east
- `x-` moves the bot towards west
- `y+` moves the bot towards south
- `y-` moves the bot towards north
  
```racket
(getCurPos)
(move "x+")

; '(1 2)
; '(2 2)
```

---

### `newGame`

The `newGame` function resets the game and generates a new map.

---

### `getElapsedTime`

The `getElapsedTime` function returns the elapsed time in current session.
 
```racket
(getElapsedTime)

; 3.34
```

---

### `setName`

The `setName` function associates your username with the result. Note that this function will reset the position of the MdxBot when called before reaching the goal.

```racket
(setName "Your name")
```

---

## Example

```racket
#lang racket

(require "GameClient.rkt")

(newGame)
(define goal (getGoal))

(move "x+")
(move "y+")
```

