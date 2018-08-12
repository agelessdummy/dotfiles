" vim-pomodoro
" Duration of a pomodoro in minutes (default: 25)
let g:pomodoro_time_work = 40

" Duration of a break in minutes (default: 5)
let g:pomodoro_time_slack = 10 

" Log completed pomodoros, 0 = False, 1 = True (default: 0)
let g:pomodoro_do_log = 1

" Path to the pomodoro log file (default: /tmp/pomodoro.log)
let g:pomodoro_log_file = "/tmp/pomodoro.log" 
"---
" skuld
" Pomodoro completion symbol
let g:skuld_progress_symbol = '*'

" Pomodoro squashed symbol
let g:skuld_squash_symbol = 'x'

" Pomodoro working period (in minutes)
let g:skuld_work_period = 25

" Pomodoro resting period (in minutes)
let g:skuld_rest_period = 5

" Pomodoro long resting period (in minutes)
let g:skuld_long_rest_period = 15

" Max working streak before long resting
let g:skuld_max_work_streak = 4

" Notification command
let g:skuld_notify_cmd = 'notify-send'

" Default line width for the task buffer
let g:skuld_line_width = 29
