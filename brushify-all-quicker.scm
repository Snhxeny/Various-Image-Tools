(;    
;;  Paul Cooney 2021
;;  Applies a painterly effect to all open images
;;  Designed to run faster, but may not look as nice
 )

(define (sfu-burshy-all-quicker2) 
  (let* ((i (car (gimp-image-list))) 
         (image)) 
    (while (> i 0) 
      (set! image (vector-ref (cadr (gimp-image-list)) (- i 1))) 

      (define drawable1 (car(gimp-image-get-active-layer image)))
      (brushyQuicker2 image drawable1)
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



(define (brushyQuicker2
	img
	drawable)

    (gimp-context-set-brush "Texture Hose 03")
    (gimp-context-set-brush-size 96)
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

    (gimp-layer-set-opacity brushLayer 65)

    (define spacing 36)
    (gimp-context-set-brush-size 64)

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

        (scribbleTwoPass img brushLayer cclayer xstart ystart width height spacing)
        (set! y (+ y spacing))
        )
        (gimp-displays-flush)
    (set! x (+ x spacing))
    )
    
    (define tolerance 30)
    (define spacing 16)
    (define size 16)
    (define sizeDivisor 2)
    (set! x spacing)
    (set! y spacing)
    (set! xstart x)
    (set! ystart y)
    (set! xMax (- width spacing))
    (set! yMax (- height spacing))

    (while (< x xMax)
    (set! y spacing)
    (while (< y yMax)
        (set! xstart(+ x (rand spacing) halfNeg))
        (set! ystart(+ y (rand spacing) halfNeg))
        (set! xstart (bound xstart width))
        (set! ystart (bound ystart height))
	(if (imgDifference img brushLayer cclayer xstart ystart tolerance)(begin 
            (define newSize (+ (- size (rand (/ size sizeDivisor))) (rand (/ size sizeDivisor))))
            (gimp-context-set-brush-size newSize)
            (scribbleFiner img brushLayer cclayer xstart ystart width height spacing)
        (set! xstart(+ x (rand spacing) halfNeg))
        (set! ystart(+ y (rand spacing) halfNeg))
        (set! xstart (bound xstart width))
        (set! ystart (bound ystart height))
	(if (imgDifference img brushLayer cclayer xstart ystart tolerance)(begin 
            (define newSize (+ (- size (rand (/ size sizeDivisor))) (rand (/ size sizeDivisor))))
            (gimp-context-set-brush-size newSize)
            (scribbleFiner img brushLayer cclayer xstart ystart width height spacing)
        (set! xstart(+ x (rand spacing) halfNeg))
        (set! ystart(+ y (rand spacing) halfNeg))
        (set! xstart (bound xstart width))
        (set! ystart (bound ystart height))
	(if (imgDifference img brushLayer cclayer xstart ystart tolerance)(begin 
            (define newSize (+ (- size (rand (/ size sizeDivisor))) (rand (/ size sizeDivisor))))
            (gimp-context-set-brush-size newSize)
            (scribbleFiner img brushLayer cclayer xstart ystart width height spacing)
        (set! xstart(+ x (rand spacing) halfNeg))
        (set! ystart(+ y (rand spacing) halfNeg))
        (set! xstart (bound xstart width))
        (set! ystart (bound ystart height))
	(if (imgDifference img brushLayer cclayer xstart ystart tolerance)(begin 
            (define newSize (+ (- size (rand (/ size sizeDivisor))) (rand (/ size sizeDivisor))))
            (gimp-context-set-brush-size newSize)
            (scribbleFiner img brushLayer cclayer xstart ystart width height spacing)
        (set! xstart(+ x (rand spacing) halfNeg))
        (set! ystart(+ y (rand spacing) halfNeg))
        (set! xstart (bound xstart width))
        (set! ystart (bound ystart height))
	(if (imgDifference img brushLayer cclayer xstart ystart tolerance)(begin 

            (define newSize (+ (- size (rand (/ size sizeDivisor))) (rand (/ size sizeDivisor))))

            (gimp-context-set-brush-size newSize)
            (scribbleFiner img brushLayer cclayer xstart ystart width height spacing)
        (set! xstart(+ x (rand spacing) halfNeg))
        (set! ystart(+ y (rand spacing) halfNeg))
        (set! xstart (bound xstart width))
        (set! ystart (bound ystart height))
	(if (imgDifference img brushLayer cclayer xstart ystart tolerance)(begin 
            (define newSize (+ (- size (rand (/ size sizeDivisor))) (rand (/ size sizeDivisor))))
            (gimp-context-set-brush-size newSize)
            (scribbleFiner img brushLayer cclayer xstart ystart width height spacing)
        (set! xstart(+ x (rand spacing) halfNeg))
        (set! ystart(+ y (rand spacing) halfNeg))
        (set! xstart (bound xstart width))
        (set! ystart (bound ystart height))
	(if (imgDifference img brushLayer cclayer xstart ystart tolerance)(begin 
            (define newSize (+ (- size (rand (/ size sizeDivisor))) (rand (/ size sizeDivisor))))
            (gimp-context-set-brush-size newSize)
            (scribbleFiner img brushLayer cclayer xstart ystart width height spacing)
        (set! xstart(+ x (rand spacing) halfNeg))
        (set! ystart(+ y (rand spacing) halfNeg))
        (set! xstart (bound xstart width))
        (set! ystart (bound ystart height))
	(if (imgDifference img brushLayer cclayer xstart ystart tolerance)(begin 
            (define newSize (+ (- size (rand (/ size sizeDivisor))) (rand (/ size sizeDivisor))))
            (gimp-context-set-brush-size newSize)
            (scribbleFiner img brushLayer cclayer xstart ystart width height spacing)
        )())
        )())
        )())
        )())
        )())
        )())
        )())
        )())

        (set! y (+ y spacing))
        )
        (gimp-displays-flush)
    (set! x (+ x spacing))
    )

    (gimp-image-merge-visible-layers img 0)

    (gimp-displays-flush)

)








(define (scribbleTwoPass
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

    (define rot (/ *pi* 2.0))

    (define sampDist spacing)
	
    (define seed (rand 360))
    (set! seed (/ seed 360.0))
    (set! seed (* seed (* 2 *pi*)))
    (define xadd1 (* sampDist (cos seed)))
    (define yadd1 (* sampDist (sin seed)))
    (define xend1 (+ xstart xadd1))
    (define yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (define color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (define distance1 (distance color color1))

    (define xend xend1)
    (define yend yend1)
    (define bestDistance distance1)
    (define bestColor color1)

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (gimp-context-set-foreground bestColor)
    (define points (cons-array 4 'double))
    (aset points 0 xstart)
    (aset points 1 ystart)
    (aset points 2 xend)
    (aset points 3 yend)

    (gimp-paintbrush-default drawTo 4 points)
)





(define (scribbleFiner
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

    (define rot (/ *pi* 4.0))

    (define sampDist spacing)
	
    (define seed (rand 360))
    (set! seed (/ seed 360.0))
    (set! seed (* seed (* 2 *pi*)))
    (define xadd1 (* sampDist (cos seed)))
    (define yadd1 (* sampDist (sin seed)))
    (define xend1 (+ xstart xadd1))
    (define yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (define color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (define distance1 (distance color color1))

    (define xend xend1)
    (define yend yend1)
    (define bestDistance distance1)
    (define bestColor color1)

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (gimp-context-set-foreground bestColor)
    (define points (cons-array 4 'double))
    (aset points 0 xstart)
    (aset points 1 ystart)
    (aset points 2 xend)
    (aset points 3 yend)

    (gimp-paintbrush-default drawTo 4 points)
)








(define (scribbleFinist
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

    (define rot (/ *pi* 8.0))

    (define sampDist spacing)
	
    (define seed (rand 360))
    (set! seed (/ seed 360.0))
    (set! seed (* seed (* 2 *pi*)))
    (define xadd1 (* sampDist (cos seed)))
    (define yadd1 (* sampDist (sin seed)))
    (define xend1 (+ xstart xadd1))
    (define yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (define color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (define distance1 (distance color color1))

    (define xend xend1)
    (define yend yend1)
    (define bestDistance distance1)
    (define bestColor color1)

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (set! seed (+ seed rot ))
    (set! xadd1 (* sampDist (cos seed)))
    (set! yadd1 (* sampDist (sin seed)))
    (set! xend1 (+ xstart xadd1))
    (set! yend1 (+ ystart yadd1))
    (set! xend1 (bound xend1 width))
    (set! yend1 (bound yend1 height))
    (set! color1 (car (gimp-image-pick-color img colorFrom xend1 yend1 FALSE TRUE 1)))
    (set! distance1 (distance color color1))

    (if (< distance1 bestDistance)(begin 
        (set! xend xend1)
        (set! yend yend1)
        (set! bestDistance distance1)
        (set! bestColor color1)
        )())

    (gimp-context-set-foreground bestColor)
    (define points (cons-array 4 'double))
    (aset points 0 xstart)
    (aset points 1 ystart)
    (aset points 2 xend)
    (aset points 3 yend)

    (gimp-paintbrush-default drawTo 4 points)
)









(define (imgDifference img drawA drawB x y tolerence)
    (define color1 (car (gimp-image-pick-color img drawA x y FALSE TRUE 1)))
    (define color2 (car (gimp-image-pick-color img drawB x y FALSE TRUE 1)))
    (define dif (distance color1 color2))
    (define back (< tolerence dif))
    back
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
  "sfu-burshy-all-quicker2"
  "<Image>/Filters/Brushify/Brushify-All-Quicker2"
  "brushstrokes all open images"
  "Paul"
  "Paul"
  "May 2021"
  "RGB*"
)