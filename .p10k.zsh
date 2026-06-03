'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

(() {
  emulate -L zsh -o extended_glob

  # Unset all configuration options.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)'

  
  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_ICON_PADDING=moderate


  typeset -g POWERLEVEL9K_BACKGROUND=234
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX=


  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon                 # OS logo (Ubuntu)
    context                 # lietotājs@konteiners
    dir                     # Pašreizējā mape
    vcs                     # Git statuss (ja atrodies git mapē)
    command_execution_time  # Cik ilgi izpildījās pēdējā komanda
    newline                 # Pārejam jaunā rindā, lai paliek vieta komandai
    prompt_char             # Ievades simbols (> vai #)
  )


  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # Rāda sarkanu, ja iepriekšējā komanda izmeta kļūdu
    background_jobs         # Fona procesi
    time                    # Pašreizējais laiks
  )

  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=232
  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=208 # Ubuntu oranžs

  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=1
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=0
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=250
  typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=238


  typeset -g POWERLEVEL9K_DIR_BACKGROUND=31 # Zils fons
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=254
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=0
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=3
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=0
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=2
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=0

  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=240
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=142

  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=1
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=255

  typeset -g POWERLEVEL9K_TIME_BACKGROUND=240
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=254
  typeset -g POWERLEVEL9K_TIME_FORMAT='%H:%M:%S'

  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_CONTENT_EXPANSION='❯'


  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B1'
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\uE0B3'
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B0'
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B2'

})

unset p10k_config_opts
