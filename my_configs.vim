
set nu rnu nowrap nowrapscan noshowmode cc=81

colorscheme nord
let g:lightline.colorscheme = 'nord'
let g:lightline.active.left = [
    \ [ 'mode', 'paste' ],
    \ [ 'fugitive', 'readonly', 'relativepath', 'modified' ] ]
let g:lightline.active.right = [
    \ [ 'lineinfo' ],
    \ [ 'percent' ],
    \ [ 'fileformat', 'fileencoding', 'filetype' ] ]
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.component.lineinfo = '%3l,%-2c'
let g:lightline.component.percent = '%3p%%/%L'

" let g:ctrlp_map = '<C-p>'
try
    unmap <leader>f
catch
endtry

imap jj <Esc>

nmap <silent> <leader>tt :TagbarToggle<CR>
let g:tagbar_position = 'left'

" replace <tab> witch <c-n> to avoid conflict with 'ultisnips'
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => leaderf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "", 'right': "" }
let g:Lf_ShowDevIcons = 1
let g:Lf_PopupShowStatusline = 0
let g:Lf_ShowHidden = 1
let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.hg'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
    \}
let g:Lf_ExternalCommand = 'ag -g "%s" -i -a --hidden'
let g:Lf_PopupColorscheme = 'onedark'
let g:Lf_StlColorscheme = 'onedark'

let g:Lf_ShortcutF = '<leader>ff'
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s --bottom --cword --regexMode", "")<CR><CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fg :<C-U><C-R>=printf("Leaderf! gtags -g %s", expand("<cword>"))<CR><CR>
noremap <leader>fG :<C-U><C-R>=printf("Leaderf gtags %s", "")<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Codeium
" let g:codeium_disable_bindings = 1

" quickly paste from system clipboard
nnoremap <silent> <leader>P :%!xclip -o -selection clipboard<CR>
vnoremap <silent> <leader>Y :w !xclip -selection clipboard<CR><CR>
