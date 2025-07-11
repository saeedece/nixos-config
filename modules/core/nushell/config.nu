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
  binary: '#8250df'
  block: '#0969da'
  cell-path: '#6e7781'
  closure: '#1b7c83'
  custom: '#8c959f'
  duration: '#4d2d00'
  float: '#a40e26'
  glob: '#8c959f'
  int: '#8250df'
  list: '#1b7c83'
  nothing: '#cf222e'
  range: '#4d2d00'
  record: '#1b7c83'
  string: '#116329'

  bool: {|| if $in { '#3192aa' } else { '#4d2d00' } }

  datetime: {|| (date now) - $in |
      if $in < 1hr {
          { fg: '#cf222e' attr: 'b' }
      } else if $in < 6hr {
          '#cf222e'
      } else if $in < 1day {
          '#4d2d00'
      } else if $in < 3day {
          '#116329'
      } else if $in < 1wk {
          { fg: '#116329' attr: 'b' }
      } else if $in < 6wk {
          '#1b7c83'
      } else if $in < 52wk {
          '#0969da'
      } else { 'dark_gray' }
  }

  filesize: {|e|
      if $e == 0b {
          '#6e7781'
      } else if $e < 1mb {
          '#1b7c83'
      } else {{ fg: '#0969da' }}
  }

  shape_and: { fg: '#8250df' attr: 'b' }
  shape_binary: { fg: '#8250df' attr: 'b' }
  shape_block: { fg: '#0969da' attr: 'b' }
  shape_bool: '#3192aa'
  shape_closure: { fg: '#1b7c83' attr: 'b' }
  shape_custom: '#116329'
  shape_datetime: { fg: '#1b7c83' attr: 'b' }
  shape_directory: '#1b7c83'
  shape_external: '#1b7c83'
  shape_external_resolved: '#3192aa'
  shape_externalarg: { fg: '#116329' attr: 'b' }
  shape_filepath: '#1b7c83'
  shape_flag: { fg: '#0969da' attr: 'b' }
  shape_float: { fg: '#a40e26' attr: 'b' }
  shape_garbage: { fg: '#FFFFFF' bg: '#FF0000' attr: 'b' }
  shape_glob_interpolation: { fg: '#1b7c83' attr: 'b' }
  shape_globpattern: { fg: '#1b7c83' attr: 'b' }
  shape_int: { fg: '#8250df' attr: 'b' }
  shape_internalcall: { fg: '#1b7c83' attr: 'b' }
  shape_keyword: { fg: '#8250df' attr: 'b' }
  shape_list: { fg: '#1b7c83' attr: 'b' }
  shape_literal: '#0969da'
  shape_match_pattern: '#116329'
  shape_matching_brackets: { attr: 'u' }
  shape_nothing: '#cf222e'
  shape_operator: '#4d2d00'
  shape_or: { fg: '#8250df' attr: 'b' }
  shape_pipe: { fg: '#8250df' attr: 'b' }
  shape_range: { fg: '#4d2d00' attr: 'b' }
  shape_raw_string: { fg: '#8c959f' attr: 'b' }
  shape_record: { fg: '#1b7c83' attr: 'b' }
  shape_redirection: { fg: '#8250df' attr: 'b' }
  shape_signature: { fg: '#116329' attr: 'b' }
  shape_string: '#116329'
  shape_string_interpolation: { fg: '#1b7c83' attr: 'b' }
  shape_table: { fg: '#0969da' attr: 'b' }
  shape_vardecl: { fg: '#0969da' attr: 'u' }
  shape_variable: '#8250df'

  foreground: '#0E1116'
  background: '#ffffff'
  cursor: '#044289'

  empty: '#0969da'
  header: { fg: '#116329' attr: 'b' }
  hints: '#57606a'
  leading_trailing_space_bg: { attr: 'n' }
  row_index: { fg: '#116329' attr: 'b' }
  search_result: { fg: '#cf222e' bg: '#6e7781' }
  separator: '#6e7781'
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

