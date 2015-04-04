# emacs two-window mode for diglossa & diglossa.org

stuff I use in emacs while hacking texts for diglossa.org

## Installation

clone diglossa.el somewhere - path-to-diglossa.el-dir

in your .emacs file:

````bash
(add-to-list 'load-path "~/.emacs.d/path-to-diglossa.el-dir")
(load "diglossa")
````

## how to use it

open two parallell texts in emacs, with Ctrl-x 3 or M-x split-window-horizontally

edit them with these shortcuts:

````bash
C-c C-t - both windows toggle (Toggle, Truncate)
C-c C-p - both windows scroll-down (Previous)
C-c C-n - both windows scroll-up (Next)
C-c C-x - both windows scroll some (20) lines up
C-c C-h - both windows  to home (Home)
C-c C-e - both windows to end (End)
C-c C-l - other window same position (Line)
````

there is useful sintactic sugar for the last shortcut: ````shift-left, shift-right````. In addition it recenters both texts.

and main method:

````bash
C-c c - compare number of sentences in parallell paragraphs
          if equal, go to the next paragraph
````


note, this shortcut without second Ctrl. So, create temporary macro F3, C-c c, F4

press F4 - both texts will run up to unequal paragraphs. Fix problem, and press F4 again


## License

  GNU GPL
