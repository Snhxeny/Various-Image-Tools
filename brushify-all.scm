(;    
;;  Paul Cooney 2021
;;  Applies a painterly effect to all open images
 )

(define (sfu-burshy-all) 
  (let* ((i (car (gimp-image-list))) 
         (image)) 
    (while (> i 0) 
      (set! image (vector-ref (cadr (gimp-image-list)) (- i 1))) 

      (define drawable1 (car(gimp-image-get-active-layer image)))
      (brushy image drawable1)
      (define drawable2 (car(gimp-image-get-active-layer image)))
      (file-png-save-defaults 1 image drawable2 
           (car (gimp-image-get-filename image))
           (car (gimp-image-get-filename image))
      )
      (gimp-image-clean-all image) 
      (set! i (- i 1)))))

(define (brushy 
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

    ; Create backLayer
    (define backLayer (car (gimp-layer-copy cclayer 0)))
    (gimp-item-set-name backLayer "backLayer")
    (gimp-image-insert-layer img backLayer 0 0)

    (plug-in-oilify 1 img backLayer 8 1)
    (plug-in-unsharp-mask 1 img backLayer 2 1 0)
    (gimp-displays-flush)

    ; Create frontLayer
    (define frontLayer(car (gimp-layer-copy cclayer 0)))
    (gimp-item-set-name frontLayer "frontLayer")
    (gimp-image-insert-layer img frontLayer 0 0)

    (plug-in-oilify 1 img frontLayer 24 1)
    (gimp-displays-flush)

    ; Create brushLayer
    (define brushLayer(car (gimp-layer-copy frontLayer 0)))
    (gimp-item-set-name brushLayer "brushLayer")
    (gimp-image-insert-layer img brushLayer 0 0)
    (gimp-displays-flush)


    (define spacing 12)

    (define width (car (gimp-image-width img)))
    (define height (car (gimp-image-height img)))
    (define xMax (/ width spacing))
    (set! xMax (- xMax 1))
    (define yMax (/ height spacing))
    (set! yMax (- yMax 1))
    (define x 1)
    (define y 1)


    (while (< x xMax)
    (set! y 0)
    (while (< y yMax)
        (scribble img brushLayer backLayer x y width height)
        (gimp-displays-flush)
        (set! y (+ y 1))
        )
    (set! x (+ x 1))
    )

    (gimp-layer-set-opacity frontLayer 0)
    (gimp-layer-set-opacity brushLayer 40)

    ;(gimp-image-merge-visible-layers img 0)

    (gimp-displays-flush)
)

(define (scribble
	img
	drawTo
	colorFrom
	xi
	yi
	width
	height)

    (define spacing 12)

    (define halfNeg (* spacing -.5))
    (define color)
    (define xstart(+ (* xi spacing) (rand spacing) halfNeg))
    (define ystart(+ (* yi spacing) (rand spacing) halfNeg))
    (set! xstart (bound xstart width))
    (set! ystart (bound ystart height))

    (set! color (car (gimp-image-pick-color img colorFrom xstart ystart FALSE TRUE 1)))

    (define sampDist 12)
	
    (define seed (rand 360))
    (set! seed (/ seed 360.0))
    (set! seed (* seed (* 2 *pi*)))
    (define xadd1 (* sampDist (cos seed)))
    (define yadd1 (* sampDist (sin seed)))
    (define xend1 (+ xstart xadd1))
    (define yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (define color1 (car (gimp-image-pick-color img drawTo xend1 yend1 FALSE TRUE 1)))
    (define distance1 (distance color color1))

    (set! seed (+ seed (/ *pi* 2)))
    (define xadd2 (* sampDist (cos seed)))
    (define yadd2 (* sampDist (sin seed)))
    (define xend2 (+ xstart xadd2))
    (define yend2 (+ ystart yadd2))
    (set! xend2 (bound xend2 width))
    (set! yend2 (bound yend2 height))
    (define color2 (car (gimp-image-pick-color img drawTo xend2 yend2 FALSE TRUE 1)))
    (define distance2 (distance color color2))

    (set! seed (+ seed (/ *pi* 2)))
    (define xadd3 (* sampDist (cos seed)))
    (define yadd3 (* sampDist (sin seed)))
    (define xend3 (+ xstart xadd3))
    (define yend3 (+ ystart yadd3))
    (set! xend3 (bound xend3 width))
    (set! yend3 (bound yend3 height))
    (define color3 (car (gimp-image-pick-color img drawTo xend3 yend3 FALSE TRUE 1)))
    (define distance3 (distance color color3))

    (set! seed (+ seed (/ *pi* 2)))
    (define xadd4 (* sampDist (cos seed)))
    (define yadd4 (* sampDist (sin seed)))
    (define xend4 (+ xstart xadd4))
    (define yend4 (+ ystart yadd4))
    (set! xend4 (bound xend4 width))
    (set! yend4 (bound yend4 height))
    (define color4 (car (gimp-image-pick-color img drawTo xend4 yend4 FALSE TRUE 1)))
    (define distance4 (distance color color4))

    (define xend xend1)
    (define yend yend1)
    (define bestDistance distance1)
    (define bestColor color1)

    (if (< distance2 bestDistance)(begin 
        (set! xend xend2)
        (set! yend yend2)
        (set! bestDistance distance2)
        (set! bestColor color2)
        )())

    (if (< distance3 bestDistance)(begin 
        (set! xend xend3)
        (set! yend yend3)
        (set! bestDistance distance3)
        (set! bestColor color3)
        )())

    (if (< distance4 bestDistance)(begin 
        (set! xend xend4)
        (set! yend yend4)
        (set! bestDistance distance4)
        (set! bestColor color4)
        )())

    (gimp-context-set-foreground bestColor)
    (define points (cons-array 4 'double))
    (aset points 0 xstart)
    (aset points 1 ystart)
    (aset points 2 xend)
    (aset points 3 yend)

    (gimp-paintbrush-default drawTo 4 points)

)

(define (bound x max)
    (if (< x 0) (set! x 0) ())
    (if (<= max x) (set! x (- max 1)) ())
    x
)

(define (distance color1 color2)
    (define x1 (car color1))
    (define x2 (car color2))
    (define y1 (car (cdr color1)))
    (define y2 (car (cdr color2)))
    (define z1 (car (cdr (cdr color1))))
    (define z2 (car (cdr (cdr color2))))
    (define xdif (- x1 x2))
    (define xsqr (* xdif xdif))
    (define ydif (- y1 y2))
    (define ysqr (* ydif ydif))
    (define zdif (- z1 z2))
    (define zsqr (* zdif zdif))
    (define csqr (+ xsqr ysqr zsqr))
    (define c (sqrt csqr))
    c
)

(script-fu-register
  "sfu-burshy-all"
  "<Image>/Filters/Brushify/Brushify-All"
  "brushstrokes all open images"
  "Paul"
  "Paul"
  "May 2021"
  "RGB*"
)



