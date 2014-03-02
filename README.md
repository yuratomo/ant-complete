ant-complete
=================
Vim omnifunc for build.xml.

Install
-------
Set your .vimrc as follows.

    " Vundle
    Bundle 'yuratomo/ant-complete'

Settings
--------
Set your .vimrc as follows.
### autoload ant-complete
    au BufNewFile,BufRead *.html    setl omnifunc=ant-complete#complete
    
### show status refarence
    au CompleteDone build.xml          call ant-complete#showRef()
    au BufNewFile,BufRead build.xml    inoremap <expr> <c-down> ant-complete#nextRef()
    au BufNewFile,BufRead build.xml    inoremap <expr> <c-up>   ant-complete#prevRef()

ScreenShots
----------
