function! denops#debug(...) abort
  if g:denops#loglevel >= 1
    let msg = join(a:000)
    echohl Comment
    for line in split(msg, '\n')
      echomsg printf('[denops] %s', line)
    endfor
    echohl None
  endif
endfunction

function! denops#info(...) abort
  let msg = join(a:000)
  for line in split(msg, '\n')
    echomsg printf('[denops] %s', line)
  endfor
endfunction

function! denops#error(...) abort
  let msg = join(a:000)
  echohl ErrorMsg
  for line in split(msg, '\n')
    echomsg printf('[denops] %s', line)
  endfor
  echohl None
endfunction

function! denops#notify(plugin, method, params) abort
  return denops#server#channel#notify('invoke', ['dispatch', [a:plugin, a:method, a:params]])
endfunction

function! denops#request(plugin, method, params) abort
  return denops#server#channel#request('invoke', ['dispatch', [a:plugin, a:method, a:params]])
endfunction

function! denops#request_async(plugin, method, params, success, failure) abort
  let success = denops#callback#add(a:success)
  let failure = denops#callback#add(a:failure)
  return denops#server#channel#request('invoke', ['dispatchAsync', [a:plugin, a:method, a:params, success, failure]])
endfunction

" Configuration
let g:denops#deno = get(g:, 'denops#deno', exepath('deno'))
let g:denops#loglevel = exists("g:denops#loglevel") ? g:denops#loglevel : 0


" OBSOLETED
function! denops#promise(plugin, method, params) abort
  call denops#error('denops#promise() is obsoleted. Use denops#request_async() with Async.Promise of vital.vim instead.')
endfunction
