# my sicp
I decide to read sicp at 2017 summer vacation.
this git record my reading.

## reason
I know Linux as OS, write few javascript and web programing,
but lack some theorem about computer science,
so I decide to read some book.

I love javascript as a functional programing language,
and <http://yinwang.org> say lisp/scheme wonderful,
so I try to use emacs and lisp, and so on choose sicp.

## [筆記](exercise)
每讀完一節會寫筆記，努力認真中。

## install
To read it local, first I use wget download from
<https://mitpress.mit.edu/sicp/> , put them in `./html` .

then I find texinfo format,
and download from <http://www.neilvandyke.org/sicp-texi/> .

to install need `makeinfo` or `texi2any` convert texi to info file.
or you can just use info file convert by me.

convert to single info file:

    cd texinfo 
    make sicp.info
    make sicp.html # if you want html version
    make sicp.pdf # work if you have TeX installed
    make install # if you want to put sicp.info into your info path
    INFOPATH=$HOME/.local/share/info make install # spec info path


in `Makefile`:

  - `--force` for some syntax error in sicp.texi,
    maybe because of old version.
    
  - `--no-split` cause makeinfo output into single file,
    default makeinfo auto split file.


## read info format
you can read it by command `info` or using emacs.

    info ./sicp.info

### emacs
you can directly read it or add to your info dir.

    ;; directly read it
    (info "~/sicp/texinfo/sicp.info") 

or add it into a info dir, just add a man-page into manual system.

 1. by using info dir, check this 2 variable in emacs,
    `Info-default-directory-list` `Info-additional-directory-list` ,
    choose a dir you like, or create new then add it to addtional list.

 2. put `sicp.info` into that dir, 
    then use `install-info` command init that dir.

        install-info sicp.info dir

 3. now press `C-h i` in emacs, 
    you should see all info in your system,
    include sicp.info just install.
    

## [numbbbbb's read record](https://github.com/numbbbbb/sicp)
when i cannot figure out answer, i would see his answer.
