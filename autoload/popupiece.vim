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

let s:save_cpo = &cpo
set cpo&vim

" Public API {{{1
function! popupiece#popup_tag()
  call s:move_and_popup(function('s:tag'), function('s:pop'))
endfunction

function! popupiece#popup_local_declaration()
  call s:move_and_popup(function('s:go_local_decl'), function('s:go_back'))
endfunction

function! popupiece#popup_custom(pre_func, post_func)
  call s:move_and_popup(a:pre_func, a:post_func)
endfunction
"}}}

" Private {{{1
function! s:tag()
  execute "normal! \<C-]>"
endfunction

function! s:pop()
  execute "normal! \<C-t>"
endfunction

function! s:go_local_decl()
  execute "normal! gd"
endfunction

function! s:go_back()
  execute "normal! \<C-o>"
endfunction

function! s:move_and_popup(pre_func, post_func)
  if !exists('*popup_create')
    echohl WarningMsg
    echom printf('[error] popup_create is not supported')
    echohl None
    return
  endif

  let save_view = {}
  let first_pos = 0
  let cur_pos = 0
  let has_jumped = 0
  try
    let first_pos = getcurpos()
    let save_view = winsaveview()
    call function(a:pre_func)()
    let cur_pos = getcurpos()
    if first_pos == cur_pos
      return
    endif
    let has_jumped = 1
    let lines = s:get_around_lines(g:popupiece_before_additional_line, g:popupiece_after_additional_line, g:popupiece_no_blank_line)
    call map(lines, {key, val -> substitute(val, "\t", repeat(' ', &tabstop), 'g')})
  finally
    if has_jumped == 1
      call function(a:post_func)()
      call winrestview(save_view)
    else
      let cur_pos = getcurpos()
      if first_pos != cur_pos
        call function(a:post_func)()
        call winrestview(save_view)
      endif
    endif
  endtry

  call popup_create(lines, {
    \ 'line': 'cursor',
    \ 'col': 'cursor',
    \ 'pos': 'topleft',
    \ 'wrap': 0,
    \ 'border': [1, 1, 1, 1],
    \ 'moved': 'any',
    \ })
endfunction

function! s:get_around_lines(before_count, after_count, no_blank_line)
  let cur_lnum = line('.')
  let before_lnum = max([1, cur_lnum - a:before_count])
  let after_lnum  = min([line('$'), cur_lnum + a:after_count])

  if a:no_blank_line != 0
    if before_lnum < cur_lnum
      let srch_lnum = search('^\s*$', 'bnW', before_lnum)
      if srch_lnum != 0
        let before_lnum = srch_lnum + 1
      endif
    endif
    if after_lnum < cur_lnum
      let srch_lnum = search('^\s*$', 'nW', after_lnum)
      if srch_lnum != 0
        let after_lnum = srch_lnum - 1
      endif
    endif
  endif

  return getline(before_lnum, after_lnum)
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" __END__ "{{{1
" vim: foldmethod=marker
