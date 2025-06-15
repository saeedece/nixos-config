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
  binary: '#a36ac7'
  block: '#3971ed'
  cell-path: '#373b41'
  closure: '#3971ed'
  custom: '#1d1f21'
  duration: '#fba922'
  float: '#cc342b'
  glob: '#1d1f21'
  int: '#a36ac7'
  list: '#3971ed'
  nothing: '#cc342b'
  range: '#fba922'
  record: '#3971ed'
  string: '#198844'

  bool: {|| if $in { '#3971ed' } else { '#fba922' } }

  datetime: {|| (date now) - $in |
      if $in < 1hr {
          { fg: '#cc342b' attr: 'b' }
      } else if $in < 6hr {
          '#cc342b'
      } else if $in < 1day {
          '#fba922'
      } else if $in < 3day {
          '#198844'
      } else if $in < 1wk {
          { fg: '#198844' attr: 'b' }
      } else if $in < 6wk {
          '#3971ed'
      } else if $in < 52wk {
          '#3971ed'
      } else { 'dark_gray' }
  }

  filesize: {|e|
      if $e == 0b {
          '#373b41'
      } else if $e < 1mb {
          '#3971ed'
      } else {{ fg: '#3971ed' }}
  }

  shape_and: { fg: '#a36ac7' attr: 'b' }
  shape_binary: { fg: '#a36ac7' attr: 'b' }
  shape_block: { fg: '#3971ed' attr: 'b' }
  shape_bool: '#3971ed'
  shape_closure: { fg: '#3971ed' attr: 'b' }
  shape_custom: '#198844'
  shape_datetime: { fg: '#3971ed' attr: 'b' }
  shape_directory: '#3971ed'
  shape_external: '#3971ed'
  shape_external_resolved: '#3971ed'
  shape_externalarg: { fg: '#198844' attr: 'b' }
  shape_filepath: '#3971ed'
  shape_flag: { fg: '#3971ed' attr: 'b' }
  shape_float: { fg: '#cc342b' attr: 'b' }
  shape_garbage: { fg: '#FFFFFF' bg: '#FF0000' attr: 'b' }
  shape_glob_interpolation: { fg: '#3971ed' attr: 'b' }
  shape_globpattern: { fg: '#3971ed' attr: 'b' }
  shape_int: { fg: '#a36ac7' attr: 'b' }
  shape_internalcall: { fg: '#3971ed' attr: 'b' }
  shape_keyword: { fg: '#a36ac7' attr: 'b' }
  shape_list: { fg: '#3971ed' attr: 'b' }
  shape_literal: '#3971ed'
  shape_match_pattern: '#198844'
  shape_matching_brackets: { attr: 'u' }
  shape_nothing: '#cc342b'
  shape_operator: '#fba922'
  shape_or: { fg: '#a36ac7' attr: 'b' }
  shape_pipe: { fg: '#a36ac7' attr: 'b' }
  shape_range: { fg: '#fba922' attr: 'b' }
  shape_raw_string: { fg: '#1d1f21' attr: 'b' }
  shape_record: { fg: '#3971ed' attr: 'b' }
  shape_redirection: { fg: '#a36ac7' attr: 'b' }
  shape_signature: { fg: '#198844' attr: 'b' }
  shape_string: '#198844'
  shape_string_interpolation: { fg: '#3971ed' attr: 'b' }
  shape_table: { fg: '#3971ed' attr: 'b' }
  shape_vardecl: { fg: '#3971ed' attr: 'u' }
  shape_variable: '#a36ac7'

  foreground: '#373b41'
  background: '#ffffff'
  cursor: '#373b41'

  empty: '#3971ed'
  header: { fg: '#198844' attr: 'b' }
  hints: '#b4b7b4'
  leading_trailing_space_bg: { attr: 'n' }
  row_index: { fg: '#198844' attr: 'b' }
  search_result: { fg: '#cc342b' bg: '#373b41' }
  separator: '#373b41'
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

def opam_env_nu [] {
  opam env
  | str trim
  | split row -r "[;\n]+"
  | drop 1
  | every 2
  | each {|s| parse --regex "^(?P<VARIABLE>[^=]+)='(?P<VALUE>[^']*)'$"}
  | each {|s| {$s.VARIABLE.0: ($s.VALUE.0 | split row ":")}}
  | reduce {|it| merge $it}
}

