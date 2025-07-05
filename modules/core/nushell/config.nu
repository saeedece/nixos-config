$env.config = {
  bracketed_paste:                  true
  buffer_editor:                    ""
  datetime_format:                  {}
  edit_mode:                        emacs
  error_style:                      fancy
  float_precision:                  2
  footer_mode:                      25
  render_right_prompt_on_last_line: false
  show_banner:                      false
  use_ansi_coloring:                true
  use_kitty_protocol:               true

  shell_integration: {
    osc2:                   false
    osc7:                   true
    osc8:                   true
    osc9_9:                 false
    osc133:                 true
    osc633:                 true
    reset_application_mode: true
  }
}

$env.config.color_config = {
  binary: '#bc8cff'
  block: '#58a6ff'
  cell-path: '#b1bac4'
  closure: '#39c5cf'
  custom: '#f0f6fc'
  duration: '#d29922'
  float: '#ffa198'
  glob: '#f0f6fc'
  int: '#bc8cff'
  list: '#39c5cf'
  nothing: '#ff7b72'
  range: '#d29922'
  record: '#39c5cf'
  string: '#3fb950'

  bool: {|| if $in { '#56d4dd' } else { '#d29922' } }

  datetime: {|| (date now) - $in |
      if $in < 1hr {
          { fg: '#ff7b72' attr: 'b' }
      } else if $in < 6hr {
          '#ff7b72'
      } else if $in < 1day {
          '#d29922'
      } else if $in < 3day {
          '#3fb950'
      } else if $in < 1wk {
          { fg: '#3fb950' attr: 'b' }
      } else if $in < 6wk {
          '#39c5cf'
      } else if $in < 52wk {
          '#58a6ff'
      } else { 'dark_gray' }
  }

  filesize: {|e|
      if $e == 0b {
          '#b1bac4'
      } else if $e < 1mb {
          '#39c5cf'
      } else {{ fg: '#58a6ff' }}
  }

  shape_and: { fg: '#bc8cff' attr: 'b' }
  shape_binary: { fg: '#bc8cff' attr: 'b' }
  shape_block: { fg: '#58a6ff' attr: 'b' }
  shape_bool: '#56d4dd'
  shape_closure: { fg: '#39c5cf' attr: 'b' }
  shape_custom: '#3fb950'
  shape_datetime: { fg: '#39c5cf' attr: 'b' }
  shape_directory: '#39c5cf'
  shape_external: '#39c5cf'
  shape_external_resolved: '#56d4dd'
  shape_externalarg: { fg: '#3fb950' attr: 'b' }
  shape_filepath: '#39c5cf'
  shape_flag: { fg: '#58a6ff' attr: 'b' }
  shape_float: { fg: '#ffa198' attr: 'b' }
  shape_garbage: { fg: '#FFFFFF' bg: '#FF0000' attr: 'b' }
  shape_glob_interpolation: { fg: '#39c5cf' attr: 'b' }
  shape_globpattern: { fg: '#39c5cf' attr: 'b' }
  shape_int: { fg: '#bc8cff' attr: 'b' }
  shape_internalcall: { fg: '#39c5cf' attr: 'b' }
  shape_keyword: { fg: '#bc8cff' attr: 'b' }
  shape_list: { fg: '#39c5cf' attr: 'b' }
  shape_literal: '#58a6ff'
  shape_match_pattern: '#3fb950'
  shape_matching_brackets: { attr: 'u' }
  shape_nothing: '#ff7b72'
  shape_operator: '#d29922'
  shape_or: { fg: '#bc8cff' attr: 'b' }
  shape_pipe: { fg: '#bc8cff' attr: 'b' }
  shape_range: { fg: '#d29922' attr: 'b' }
  shape_raw_string: { fg: '#f0f6fc' attr: 'b' }
  shape_record: { fg: '#39c5cf' attr: 'b' }
  shape_redirection: { fg: '#bc8cff' attr: 'b' }
  shape_signature: { fg: '#3fb950' attr: 'b' }
  shape_string: '#3fb950'
  shape_string_interpolation: { fg: '#39c5cf' attr: 'b' }
  shape_table: { fg: '#58a6ff' attr: 'b' }
  shape_vardecl: { fg: '#58a6ff' attr: 'u' }
  shape_variable: '#bc8cff'

  foreground: '#b3b1ad'
  background: '#0d1117'
  cursor: '#73b7f2'

  empty: '#58a6ff'
  header: { fg: '#3fb950' attr: 'b' }
  hints: '#6e7681'
  leading_trailing_space_bg: { attr: 'n' }
  row_index: { fg: '#3fb950' attr: 'b' }
  search_result: { fg: '#ff7b72' bg: '#b1bac4' }
  separator: '#b1bac4'
}

$env.config.ls = {
  clickable_links: true
  use_ls_colors: true
}

$env.config.rm.always_trash = false

$env.config.table = {
  header_on_separator: false
  index_mode: always
  mode:       rounded
  padding:    { left: 1 right: 1 }
  show_empty: true
  trim: {
    methodology:             wrapping
    wrapping_try_keep_words: true
    truncating_suffix:       "..."
  }
}

$env.config.explore = {
  command_bar_text: { fg: "#C4C9C6" }
  highlight:        { fg: black bg: yellow }
  status: {
    error: { fg: white bg: red }
    warn:  {}
    info:  {}
  }
  status_bar_background: { fg: "#1D1F21" bg: "#C4C9C6" }
  table: {
    split_line:      { fg: "#404040" }
    selected_cell:   { bg: light_blue }
    selected_row:    {}
    selected_column: {}
  }
}

$env.config.history = {
  file_format:   sqlite
  isolation:     false
  max_size:      100_000
  sync_on_enter: true
}

$env.config.completions = {
  algorithm:      prefix
  case_sensitive: false
  partial:        true
  quick:          true
  external: {
    enable:      true
    max_results: 100
    completer:   {|tokens: list<string>|
      let expanded = scope aliases | where name == $tokens.0 | get --ignore-errors expansion.0

      mut expanded_tokens = if $expanded != null and $tokens.0 != "cd" {
        $expanded | split row " " | append ($tokens | skip 1)
      } else {
        $tokens
      }

      $expanded_tokens.0 = ($expanded_tokens.0 | str trim --left --char "^")

      fish --command $"complete '--do-complete=($expanded_tokens | str join ' ')'"
      | $"value(char tab)description(char newline)" + $in
      | from tsv --flexible --no-infer
    }
  }
}

$env.config.hooks = {
  display_output: {
    tee { table --expand | print }
    | $env.last = $in
  }

  env_change: {
    PWD: [
      { ||
        if (which direnv | is-empty) {
          return
        }
        direnv export json | from json | default {} | load-env
        $env.PATH = $env.PATH | split row (char env_sep)
      }
    ]
  }

  pre_execution: [
    {
      let prompt = commandline | str trim

      if ($prompt | is-empty) {
        return
      }

      print $"(ansi title)($prompt) — nu(char bel)"
    }
  ]

  pre_prompt: []
}

