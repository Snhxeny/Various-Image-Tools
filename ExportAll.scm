(;    
;;  Paul Cooney 2021
;;  A simple script to image merge and export
;;  all open images.
 )

(define (sfu-export-all)
    (let* ((i (car (gimp-image-list))) (image) (drawable1))
        (while (> i 0)
            (set! image (vector-ref (cadr (gimp-image-list)) (- i 1)))
            (gimp-image-merge-visible-layers image 1)
            (set! drawable1 (car(gimp-image-get-active-layer image)))
            (file-png-save-defaults 1 image drawable1
                (car (gimp-image-get-filename image))
                (car (gimp-image-get-filename image))
            )
            (gimp-image-clean-all image)
            (set! i (- i 1))
        )
    )
)

(script-fu-register
    "sfu-export-all"
    "<Image>/Filters/Other/Export-All"
    "Exports all images over their original files"
    "Paul"
    "Paul"
    "May 2021"
    "RGB*"
)