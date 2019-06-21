" popupiece - popup text around tag, local decraration, etc
" Version: 0.0.1
" Copyright (C) 2019 deris0126
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists('g:loaded_popupiece')
  finish
endif
let g:loaded_popupiece = 1

let g:popupiece_before_additional_line = get(g:, 'popupiece_before_additional_line', 0)
let g:popupiece_after_additional_line  = get(g:, 'popupiece_after_additional_line', 4)
let g:popupiece_no_blank_line          = get(g:, 'popupiece_no_blank_line', 1)

nnoremap <silent> <Plug>(popupiece-tag)         :<C-u>call popupiece#popup_tag()<CR>
nnoremap <silent> <Plug>(popupiece-local-decl)  :<C-u>call popupiece#popup_local_declaration()<CR>

command! -nargs=0 PopupieceTag               call popupiece#popup_tag()
command! -nargs=0 PopupieceLocalDeclaration  call popupiece#popup_local_declaration()

" __END__
" vim: foldmethod=marker
