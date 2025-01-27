(;    
;;  Paul Cooney 2024
;;  Adds guides every 512 pxiels
 )

(define (AddGuides_01
	img
	drawable
	)
    (define width (car (gimp-image-width img)))
    (define height (car (gimp-image-height img)))
    (define xMax width)
    (define yMax height)
    (define x 0)
    (define y 0)

    (while (< (+ x 512) xMax)
    	(set! x (+ x 512))
    	(gimp-image-add-vguide img x)
    )
    (while (< (+ y 512) yMax)
    	(set! y (+ y 512))
    	(gimp-image-add-hguide img y)
    	
    )

    (gimp-displays-flush)
)

(script-fu-register
  "AddGuides_01"
  "<Image>/Filters/4xChopUp/4xAddGuides"
  "Adds guide at 512 pixel intervals"
  "Paul"
  "Paul"
  "August 2024"
  "RGB*"
  SF-IMAGE 	"Image" 	0
  SF-DRAWABLE 	"Current Layer"	0
)