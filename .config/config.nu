alias se = sudoedit
alias rnix = sudo nixos-rebuild switch

let carapace_completer = {|spans|
  carapace $spans.0 nushell ...$spans | from json }
$env.config = {
  show_banner: false,
  completions: {
    case_sensitive: false
    quick: false
    partial: true
    algorithm: "fuzzy"
    external: {
      enable: true
      max_results: 128
      completer: $carapace_completer } } }
