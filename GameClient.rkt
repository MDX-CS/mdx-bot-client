#lang racket

(require net/http-client)
(require net/uri-codec)
(require json)

(provide
  getGoal
  getCurPos
  scan
  move
  newGame
  getElapsedTime
  setName
)

#|
 | The server address.
 |
 | @var string
 |#
(define ADDRESS "10.14.121.75")

#|
 | Returns coordinates of the goal.
 |
 | @return list '(x y)
 |#
(define (getGoal)
  (bot-request "/goal/get/xy" (lambda (response)
    (list
      (hash-ref response 'x)
      (hash-ref response 'y)
    )
  ))
)

#|
 | Returns coordinates of the bot.
 |
 | @return list '(x y)
 |#
(define (getCurPos)
  (bot-request "/mdxBot/get/xy" (lambda (response)
    (list
      (hash-ref response 'x)
      (hash-ref response 'y)
    )
  ))
)

#|
 | Return a list of boleans where false means NO OBSTACLE, and true means
 | that an OBSTACLE IS PRESENT.
 |
 | @return list '(east west south north)
 |#
(define (scan)
  (bot-request "/mdxBot/scan/" (lambda (response)
    (list
      (hash-ref response 'east)
      (hash-ref response 'west)
      (hash-ref response 'south)
      (hash-ref response 'north)
    )
  ))
)

#|
 | Sends an http request to move the bot and returns its new coordinates.
 |
 | @param  string direction
 | @return list '(x y)
 |#
(define (move direction)
  (cond
    [(member direction (list "x+" "x-" "y+" "y-"))
      (bot-request (string-append "/mdxBot/move/" direction) (lambda (response)
        (list
          (hash-ref response 'x)
          (hash-ref response 'y)
        )
      ))
    ]
    [#t (list -1 -1)]
  )
)

#|
 | Creates a new game.
 |
 | @return void
 |#
(define (newGame)
  (bot-request "/game/new")
)

#|
 | Sets the username after the game has been completed.
 |
 | @param  string username
 | @return void
 |#
(define (setName username)
  (bot-request (string-append "/username/" username))
)

#|
 | Gets the elapsed time for the current session.
 |
 | @return float
 |#
(define (getElapsedTime)
  (bot-request "/game/elapsed" (lambda (response)
    (string->number (hash-ref response 'elapsed))
  ))
)

#|
 | Helper function to send an http request.
 |
 | @param  string uri
 | @param  callable response
 | @return mixed
 |#
(define (bot-request uri [callback #f])
  (define-values (status headers in)
    (http-sendrecv ADDRESS (uri-encode uri))
  )
  (define response (string->jsexpr (port->string in)))
  (close-input-port in)
  (if callback (callback response) response)
)
