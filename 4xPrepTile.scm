(;    
;;  Paul Cooney 2024
;;  Converts a heightmap with hard edges into a stamp that can 
;;  be applied to other heightmaps
 )

(define (PrepTiles02
	img
	_drawable
	)
    (define top 512)
    (define left 512)
    (define bot 1536)
    (define right 1536)
    (define height 2048)
    (define width 2048)
    (gimp-image-resize img width height left top)

    (define layers (gimp-image-get-layers img))
    (set! layers (cdr layers))
    (set! layers (car layers))
    (set! layers (vector->list layers))

    (PrepTile02sRecurse02 img layers)


    (plug-in-autocrop 1 img _drawable)
    (gimp-displays-flush)
    (gimp-image-clean-all img) 
    
)
(define (PrepTile02sRecurse02
	img
	layers
	)
 
	(define l (car layers))
        ;(gimp-message (number->string l))
        (PrepTile02 img l)
	(gimp-item-set-visible l FALSE)

	(define tail (cdr layers))
    	(if (not (null? tail)) (PrepTile02sRecurse02 img tail))

	(gimp-item-set-visible l TRUE)
)


(define (PrepTile02
	img
	drawable
	)
    (define top 512)
    (define left 512)
    (define bot 1536)
    (define right 1536)
    (define height 2048)
    (define width 2048)
    (gimp-layer-add-alpha drawable)
    (gimp-layer-resize-to-image-size drawable)
    (gimp-displays-flush)

    (set! drawable (CloneTerainOutward img drawable))
    (gimp-drawable-transform-rotate-simple drawable 0 TRUE 0 0 FALSE)
    (gimp-displays-flush)

    (set! drawable (CloneTerainOutward img drawable))
    (gimp-drawable-transform-rotate-simple drawable 0 TRUE 0 0 FALSE)
    (gimp-displays-flush)

    (set! drawable (CloneTerainOutward img drawable))
    (gimp-drawable-transform-rotate-simple drawable 0 TRUE 0 0 FALSE)
    (gimp-displays-flush)

    (set! drawable (CloneTerainOutward img drawable))
    (gimp-drawable-transform-rotate-simple drawable 0 TRUE 0 0 FALSE)
    (gimp-displays-flush)

    (CercleCut02 img drawable)
    (gimp-displays-flush)
    (plug-in-autocrop-layer 1 img drawable)
    (gimp-displays-flush)
)

(define (CercleCut02
	img
	drawable
	)
    (define top 512)
    (define left 512)
    (define bot 1536)
    (define right 1536)
    (define height 2048)
    (define width 2048)
    (define center 1024)
    (define size 1144)

    (define topRight (- center (/ size 2)))

    (gimp-image-select-ellipse img 0 topRight topRight size size)
    (gimp-selection-invert img)
    (gimp-selection-feather img 182)
    (gimp-edit-cut drawable)
    (gimp-displays-flush)
    (gimp-selection-none img)
)

(define (CloneTerainOutward
	img
	drawable
	)
    (define top 512)
    (define left 512)
    (define bot 1536)
    (define right 1536)
    (define height 2048)
    (define width 2048)

    (define worklayer (car (gimp-layer-copy drawable 0)))
    (gimp-image-insert-layer img worklayer 0 0)
    (gimp-drawable-edit-clear worklayer)
    (gimp-displays-flush)

    (define brushsize 230)

    (gimp-context-set-brush "2. Hardness 025")
    (gimp-context-set-brush-angle 0)
    (gimp-context-set-brush-aspect-ratio 0)
    (gimp-context-set-brush-force 1)
    (gimp-context-set-brush-hardness 0)
    (gimp-context-set-brush-size brushsize)
    (gimp-context-set-brush-spacing .05)
    (gimp-context-set-dynamics "Dynamics Off")
    (gimp-context-set-opacity 100)
    (gimp-context-set-paint-mode 28)
    (gimp-displays-flush)

    (define xsrc 0)
    (define ysrc 0)
    (set! xsrc (- right (* brushsize .5)))
    (set! ysrc (- bot (* brushsize 1)))

    (define alen2 2)
    (define points2 (cons-array alen2 'double))
    (aset points2 0 xsrc)
    (aset points2 1 ysrc)


    (define x0 xsrc)
    (define y0 bot)

    (define xhead (+ right (* brushsize .5)))
    (define yhead (+ bot (* brushsize .5)))

    (define xmove (* brushsize .25))
    (set! xmove (+ xmove 25))
    (define ymove (* brushsize 1))

    (define x0 xsrc)
    (define y0 bot)
    (define x1 xhead)(set! xhead (- xhead xmove))
    (define y1 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize .84))
    (define x2 xhead)(set! xhead (- xhead xmove))
    (define y2 yhead)(set! yhead (+ yhead ymove)) 
    (define x3 xhead)(set! xhead (- xhead xmove))
    (define y3 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize 1.04))
    (define x4 xhead)(set! xhead (- xhead xmove))
    (define y4 yhead)(set! yhead (+ yhead ymove)) 
    (define x5 xhead)(set! xhead (- xhead xmove))
    (define y5 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize .75))
    (define x6 xhead)(set! xhead (- xhead xmove))
    (define y6 yhead)(set! yhead (+ yhead ymove))
    (define x7 xhead)(set! xhead (- xhead xmove))
    (define y7 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize .95))
    (define x8 xhead)(set! xhead (- xhead xmove))
    (define y8 yhead)(set! yhead (+ yhead ymove))
    (define x9 xhead)(set! xhead (- xhead xmove))
    (define y9 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize 1.05))
    (define x10 xhead)(set! xhead (- xhead xmove))
    (define y10 yhead)(set! yhead (+ yhead ymove))
    (define x11 xhead)(set! xhead (- xhead xmove))
    (define y11 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize .88))
    (define x12 xhead)(set! xhead (- xhead xmove))
    (define y12 yhead)(set! yhead (+ yhead ymove))
    (define x13 xhead)(set! xhead (- xhead xmove))
    (define y13 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize .78))
    (define x14 xhead)(set! xhead (- xhead xmove))
    (define y14 yhead)(set! yhead (+ yhead ymove))
    (define x15 xhead)(set! xhead (- xhead xmove))
    (define y15 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize 1.03))
    (define x16 xhead)(set! xhead (- xhead xmove))
    (define y16 yhead)(set! yhead (+ yhead ymove))
    (define x17 xhead)(set! xhead (- xhead xmove))
    (define y17 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize .95))
    (define x18 xhead)(set! xhead (- xhead xmove))
    (define y18 yhead)(set! yhead (+ yhead ymove))
    (define x19 xhead)(set! xhead (- xhead xmove))
    (define y19 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize 1.06))
    (define x20 xhead)(set! xhead (- xhead xmove))
    (define y20 yhead)(set! yhead (+ yhead ymove))
    (define x21 xhead)(set! xhead (- xhead xmove))
    (define y21 yhead)(set! yhead (- yhead ymove)) (set! ymove (* brushsize 1.00))
    (define x22 xhead)(set! xhead (- xhead xmove))
    (define y22 yhead)(set! yhead (+ yhead ymove))

    (define alen 46)
    (define points (cons-array alen 'double))

    (aset points 0 x0)
    (aset points 1 y0)
    (aset points 2 x1)
    (aset points 3 y1)
    (aset points 4 x2)
    (aset points 5 y2)
    (aset points 6 x3)
    (aset points 7 y3)
    (aset points 8 x4)
    (aset points 9 y4)
    (aset points 10 x5)
    (aset points 11 y5)
    (aset points 12 x6)
    (aset points 13 y6)
    (aset points 14 x7)
    (aset points 15 y7)
    (aset points 16 x8)
    (aset points 17 y8)
    (aset points 18 x9)
    (aset points 19 y9)
    (aset points 20 x10)
    (aset points 21 y10)
    (aset points 22 x11)
    (aset points 23 y11)
    (aset points 24 x12)
    (aset points 25 y12)
    (aset points 26 x13)
    (aset points 27 y13)
    (aset points 28 x14)
    (aset points 29 y14)
    (aset points 30 x15)
    (aset points 31 y15)
    (aset points 32 x16)
    (aset points 33 y16)
    (aset points 34 x17)
    (aset points 35 y17)
    (aset points 36 x18)
    (aset points 37 y18)
    (aset points 38 x19)
    (aset points 39 y19)
    (aset points 40 x20)
    (aset points 41 y20)
    (aset points 42 x21)
    (aset points 43 y21)
    (aset points 44 x22)
    (aset points 45 y22)


    ;(gimp-paintbrush-default worklayer 2 points)
    ;(gimp-paintbrush-default worklayer alen points)
    ;(gimp-paintbrush-default worklayer alen2 points2)
    (gimp-clone worklayer drawable 0 xsrc ysrc alen points)
    (gimp-displays-flush)

    (gimp-image-select-rectangle img 0 512 1306 1024 460)
    (define topaste (car (gimp-item-transform-flip-simple worklayer 1 TRUE 0)))
    (gimp-displays-flush)
    (gimp-floating-sel-anchor topaste)
    (gimp-selection-none img)
    (safe-merge-down img worklayer drawable)
    drawable
    ;(define back (car (gimp-image-merge-down img worklayer 0)))
    ;back
)

(define (safe-merge-down
	img
	top
	bot
	)
    (gimp-selection-all img)
    (gimp-edit-copy top)
    (gimp-floating-sel-anchor (car (gimp-edit-paste bot FALSE)))
    (gimp-image-remove-layer img top)
    (gimp-selection-none img)
)


(script-fu-register
  "PrepTiles02"
  "<Image>/Filters/PrepTile/PrepTile02"
  "Prepaires a stack of terrain tiles"
  "Paul"
  "Paul"
  "August 2024"
  "RGB*"
  SF-IMAGE 	"Image" 	0
  SF-DRAWABLE 	"Current Layer"	0
)