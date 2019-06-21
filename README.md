popupiece
===

This is Vim plugin for popup text around tag, local declaration, etc.

***This plugin is experimental***


Require
---

Vim 8.1.1407 or later is required(popup feature is required)


Screenshot
---

![screenshot](https://raw.githubusercontent.com/deris/s/master/vim-popupiece/vim-popupiece_01_popup.gif)

Usage
---

No default key mapping.

You can map key like following.

```vim
nmap <C-k>  <Plug>(popupiece-tag)
nmap <C-l>  <Plug>(popupiece-local-decl)
```

If you want to spread popup area, you can set global settings.

```vim
" If you spread area before target line, you can set additional line before.
let g:popupiece_before_additional_line = 0

" If you spread area after target line, you can set additional line after.
let g:popupiece_after_additional_line  = 4

" no blank line include if set 1.
let g:popupiece_no_blank_line          = 1
```

You can define custom popup like following

```vim
" example: write your .vimrc and define command for popup header of file
command! -nargs=0 MyPopupiece  call popupiece#popup_custom(function('s:mypopup_pre_hof'), function('s:mypopup_post_hof'))

function! s:mypopup_pre_hof()
  execute "normal! gg"
endfunction

function! s:mypopup_post_hof()
  execute "normal! \<C-o>"
endfunction
```

License
---

MIT License

