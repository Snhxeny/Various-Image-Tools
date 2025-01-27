(;    
;;  Paul Cooney 2021
;;  Adds a layer at 40% oppacity to all open images
 )

(define (sfu-clear-40-all)
    (let* ((i (car (gimp-image-list))) (image) (newLayer))
        (while (> i 0)
            (set! image (vector-ref (cadr (gimp-image-list)) (- i 1)))
            (set! newLayer (car(gimp-layer-new image 1 1 0 "draw" 100 28)))
            (gimp-image-insert-layer image newLayer 0 0)
            (gimp-layer-resize-to-image-size newLayer)
            (gimp-layer-add-alpha newLayer)
            (gimp-layer-set-opacity newLayer 40)
            (gimp-drawable-edit-clear newLayer)
            (gimp-displays-flush)
            (set! i (- i 1))
        )
    )
)

(script-fu-register
    "sfu-clear-40-all"
    "<Image>/Filters/Other/AddClearLayer-40-All"
    "Adds a transparent layer to all open images"
    "Paul"
    "Paul"
    "May 2021"
    "RGB*"
)