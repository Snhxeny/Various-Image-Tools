(;    
;;  Paul Cooney 2024
;;  Divides the image into overlaping layers 1024 pixels across
 )

(define (ChopUp_01 
	img
	drawable
	)
    (define layer (car (gimp-image-get-active-layer img)))
    (define nwidth 1024)
    (define nheight 1024)
    (define xpos 0)
    (define ypos 0)
    (define x 0)
    (define y 0)
    (define width (car (gimp-image-width img)))
    (define height (car (gimp-image-height img)))
    (define xMax width)
    (define yMax height)
    (define workingLayer(car (gimp-layer-copy layer 0)))
    (while (<= (+ y nheight) yMax)
    	(set! ypos  (- 0 y))
        (set! x 0)
        (while (<= (+ x nwidth) xMax)
    	    (set! xpos  (- 0 x))
	    (set! workingLayer(car (gimp-layer-copy layer 0)))
    	    (gimp-image-insert-layer img workingLayer 0 0)
    	    (gimp-layer-resize workingLayer nwidth nheight xpos ypos)
    	    (gimp-displays-flush)
    	    (set! x (+ x 512))
        )
    	(set! y (+ y 512))
    )
    (gimp-displays-flush)
)

(script-fu-register
  "ChopUp_01"
  "<Image>/Filters/4xChopUp/4xChopUp01"
  "Cops up the image into parts"
  "Paul"
  "Paul"
  "August 2024"
  "RGB*"
  SF-IMAGE 	"Image" 	0
  SF-DRAWABLE 	"Current Layer"	0
)
