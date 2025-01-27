(;    
;;  Paul Cooney 2024
;;  Remove all guides from the current image
 )

(define (DeleteAllGuides_01
	img
	drawable
	)
    (define guide (car (gimp-image-find-next-guide img 0)))

    (while (not (= guide 0))
    	(gimp-image-delete-guide img guide )
    	(set! guide (car (gimp-image-find-next-guide img 0)))
    )

    (gimp-displays-flush)
)

(script-fu-register
  "DeleteAllGuides_01"
  "<Image>/Filters/4xChopUp/DeleteAllGuides"
  "Adds guide at 512 pixel intervals"
  "Paul"
  "Paul"
  "August 2024"
  "RGB*"
  SF-IMAGE 	"Image" 	0
  SF-DRAWABLE 	"Current Layer"	0
)