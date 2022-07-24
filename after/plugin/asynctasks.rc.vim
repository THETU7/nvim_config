let g:asynctasks_term_pos = 'bottom'

noremap <silent><f6> :AsyncTask bazel-run<cr>
noremap <silent><f7> :AsyncTask bazel-build<cr>
noremap <silent><leader>cb :AsyncTask cmake-build<cr>
noremap <silent><leader>cg :AsyncTask cmake-generate<cr>
