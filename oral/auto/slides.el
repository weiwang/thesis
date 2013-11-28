(TeX-add-style-hook "slides"
 (lambda ()
    (LaTeX-add-labels
     "eq:fpo")
    (TeX-add-symbols
     "independent"
     "independenT")
    (TeX-run-style-hooks
     "bm"
     "footmisc"
     "algorithmic"
     "algorithm"
     "amsfonts"
     "epsfig"
     "amsmath"
     "ucs"
     "subfig"
     "lotdepth"
     "lofdepth"
     "xltxtra"
     "fontspec"
     "latex2e"
     "beamer10"
     "beamer"
     "xetex"
     "mathserif"
     "serif")))

