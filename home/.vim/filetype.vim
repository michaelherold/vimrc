augroup filetypedetect
    au BufNewFile,BufRead *.html.erb set filetype=html.ruby
    au BufNewFile,BufRead *.js.erb set filetype=javascript.ruby
    au BufNewFile,BufRead *.yaml,*.yml set filetype=yaml
augroup end
