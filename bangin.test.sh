#! /bin/sh

cfg_file="${XDG_CONFIG_HOME:-$HOME/.config}bangin/bangin.bangs"
data_dir="${XDG_DATA_HOME:-$HOME/.local/share}bangin/lists"

oneTimeSetUp() {
  mv "$cfg_file" "$cfg_file.bak" 2>/dev/null || true
  mv "$data_dir" "$data_dir-bak" 2>/dev/null || true
}

oneTimeTearDown() {
  # https://github.com/kward/shunit2/issues/112#issuecomment-478816740
  if [ "${_shunit_name_}" = 'EXIT' ]; then return 0; fi

  mv "$cfg_file.bak" "$cfg_file" 2>/dev/null || touch "$cfg_file"
  mv "$data_dir-bak" "$data_dir" 2>/dev/null || mkdir -p "$data_dir"
}

setUp() {
  mkdir "$data_dir"
}

tearDown() {
  # https://github.com/kward/shunit2/issues/112#issuecomment-478816740
  if [ "${_shunit_name_}" = 'EXIT' ]; then return 0; fi

  rm -f "$cfg_file"
  rm -rf "$data_dir"
}

testCfgBang() {
  echo "!x pre{{{s}}}post" > "$cfg_file"
  assertEquals "$(./bangin.sh y!x)" "preypost"
}

testDataBang() {
  echo "!x pre{{{s}}}post" > "$data_dir/anything.bangs"
  assertEquals "$(./bangin.sh y!x)" "preypost"
}

testCfgOverDataPrecedence() {
  echo "!x pre{{{s}}}post1" > "$cfg_file"
  echo "!x pre{{{s}}}post2" > "$data_dir/anything.bangs"
  assertEquals "$(./bangin.sh y!x)" "preypost1"
}

testDataDirPrecedence() {
  echo "!x pre{{{s}}}post1" > "$data_dir/a.bangs"
  echo "!x pre{{{s}}}post2" > "$data_dir/b.bangs"
  assertEquals "$(./bangin.sh y!x)" "preypost2"
}

. shunit2

