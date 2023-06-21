" The "Vim shfmt" plugin runs shfmt and displays the results in Vim.
"
" Author:    David Wooldridge
" URL:       https://github.com/z0mbix/vim-shfmt
" Version:   0.2
" Copyright: Copyright (c) 2017 David Wooldridge
" License:   MIT
" ----------------------------------------------------------------------------

function! shfmt#shfmt(current_args, line1, line2) abort
	let l:extra_args = g:shfmt_extra_args
	let l:filename = @%
	let l:shfmt_cmd = g:shfmt_cmd
	let l:shfmt_opts = ' ' . a:current_args . ' ' . l:extra_args
	if !empty(a:current_args)
		let l:shfmt_opts = a:current_args
	endif
	let l:cursor_position = getcurpos()
	silent execute  a:line1 . ',' . a:line2 . '!' . l:shfmt_cmd . ' ' . l:shfmt_opts
""""""""""""""""""""""""
	if v:shell_error
		echoerr 'Shfmt returned an error (often due to wrong syntax). Undoing changes.'
		" undo the buffer overwrite because shfmt returns no data on error, so
		" we've erased the user's work!
		undo
	endif
""""""""""""""""""""""""
	" Reset the cursor position if we moved
	if l:cursor_position != getcurpos()
		call setpos('.', l:cursor_position)
	endif
endfunction

if exists('g:loaded_vimshfmt') || &cp || !executable('shfmt')
    finish
endif
let g:loaded_vimshfmt = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:shfmt_fmt_on_save')
    let g:shfmt_fmt_on_save = 1
endif

if !exists('g:shfmt_cmd')
    let g:shfmt_cmd = 'shfmt'
endif

" Options
if !exists('g:shfmt_extra_args')
    let g:shfmt_extra_args = ''
endif

let s:shfmt_switches = ['-p', '-i', '-bn', '-ci', '-ln', '-s']

function! s:ShfmtSwitches(...)
    return join(s:shfmt_switches, "\n")
endfunction

command! -range=% -complete=custom,s:ShfmtSwitches -nargs=? Shfmt :call shfmt#shfmt(<q-args>, <line1>, <line2>)

augroup shfmt
    autocmd!
    if get(g:, 'shfmt_fmt_on_save', 1)
        " Use BufWritePre to filter the file before it's written since we're
        " processing current buffer instead of the saved file.
        autocmd BufWritePre *.sh Shfmt
        autocmd FileType sh autocmd BufWritePre <buffer> Shfmt
    endif
augroup END

let &cpo = s:save_cpo
