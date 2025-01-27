(;    
;;  Paul Cooney 2022
;;  Applies a painterly effect to all open images
;;  Applies the oil and unsharp plugins for an alternate effect
 )


(define (sfu-burshy-all-zealous3) 
  (let* ((i (car (gimp-image-list))) 
         (image)) 
    (while (> i 0) 
      (set! image (vector-ref (cadr (gimp-image-list)) (- i 1))) 

      (define drawable1 (car(gimp-image-get-active-layer image)))
      (brushyZealous3 image drawable1)
      (define drawable2 (car(gimp-image-get-active-layer image)))
      (file-png-save-defaults 1 image drawable2 
           (car (gimp-image-get-filename image))
           (car (gimp-image-get-filename image))
      )
      (gimp-image-clean-all image) 
      (set! i (- i 1))
    )
  )
)



(define (brushyZealous3
	img
	drawable)

    (gimp-context-set-brush "Texture Hose 03")
    (gimp-context-set-brush-size 20)
    (gimp-context-set-brush-aspect-ratio 0)
    (gimp-context-set-brush-angle 0)
    (gimp-context-set-brush-spacing 0.25)
    (gimp-context-set-brush-hardness 0.975)
    (gimp-context-set-brush-force 0.85)
    (gimp-context-set-dynamics "Water Color")
    (gimp-context-set-opacity 100)
    ; Create a new layer
    (define cclayer (car (gimp-layer-copy drawable 0)))
    (gimp-item-set-name cclayer "Color Correction")
    (gimp-image-insert-layer img cclayer 0 0)

    ;spline values must be divided by 256
    (gimp-drawable-curves-spline cclayer 0 8 (
        list->vector '(0.0 0.0 0.2852 0.1914 0.5938 0.7656 1.0 1.0)));1
    (gimp-displays-flush)

    (plug-in-oilify 1 img cclayer 8 1)
    (plug-in-unsharp-mask 1 img cclayer 2 1 0)
    (gimp-displays-flush)

    ; Create brushLayer
    (define brushLayer(car (gimp-layer-copy cclayer 0)))
    (gimp-item-set-name brushLayer "brushLayer")
    (gimp-image-insert-layer img brushLayer 0 0)
    (gimp-displays-flush)

    (gimp-layer-set-opacity brushLayer 40)
    (gimp-layer-set-opacity cclayer 0)

    (define spacing 5)

    (define width (car (gimp-image-width img)))
    (define height (car (gimp-image-height img)))
    (define xMax width)
    (define yMax height)
    (define halfNeg 0)
    (define x 0)
    (define y 0)
    (define xstart x)
    (define ystart y)
    (while (< x xMax)
    (set! y 0)
    (while (< y yMax)

        (set! xstart(+ x (rand spacing) halfNeg))
        (set! ystart(+ y (rand spacing) halfNeg))
        (set! xstart (bound xstart width))
        (set! ystart (bound ystart height))

        (scribbleBlot img brushLayer cclayer xstart ystart width height spacing)
        (set! y (+ y spacing))
        )
        (gimp-displays-flush)
    (set! x (+ x spacing))
    )

    (gimp-image-merge-visible-layers img 0)

    (gimp-displays-flush)

)

(define (scribbleBlot
	img
	drawTo
	colorFrom
	xstart
	ystart
	width
	height
	spacing)


    (define color)

    (set! color (car (gimp-image-pick-color img colorFrom xstart ystart FALSE TRUE 1)))

    (gimp-context-set-foreground color)
    (define points (cons-array 4 'double))
    (aset points 0 xstart)
    (aset points 1 ystart)
    (aset points 2 xstart)
    (aset points 3 ystart)

    (gimp-paintbrush-default drawTo 4 points)
)


(script-fu-register
  "sfu-burshy-all-zealous3"
  "<Image>/Filters/Brushify/Brushify-All-Zealous3"
  "brushstrokes all open images"
  "Paul"
  "Paul"
  "April 2022"
  "RGB*"
)