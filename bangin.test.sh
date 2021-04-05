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

testUrlEncodes() {
  echo "!x pre{{{s}}}post" > "$cfg_file"
  assertEquals "pre%5epost" "$(./bangin.sh ^!x)"
}

testTakesLastBang() {
  echo "!x a{{{s}}}" >> "$cfg_file"
  echo "!y b{{{s}}}" >> "$cfg_file"
  assertEquals "bz%21x" "$(./bangin.sh z!x!y)"
}

testReadsCfgBangs() {
  echo "!x pre{{{s}}}post" > "$cfg_file"
  assertEquals "preypost" "$(./bangin.sh y!x)"
}

testReadsDataBangs() {
  echo "!x pre{{{s}}}post" > "$data_dir/anything.bangs"
  assertEquals "preypost" "$(./bangin.sh y!x)"
}

testCfgOverDataBangsPrecedence() {
  echo "!x pre{{{s}}}post1" > "$cfg_file"
  echo "!x pre{{{s}}}post2" > "$data_dir/anything.bangs"
  assertEquals "preypost1" "$(./bangin.sh y!x)"
}

testDataBangsPrecedence() {
  echo "!x pre{{{s}}}post1" > "$data_dir/a.bangs"
  echo "!x pre{{{s}}}post2" > "$data_dir/b.bangs"
  assertEquals "preypost2" "$(./bangin.sh y!x)"
}

testReadsAliases() {
  echo "!a,!aa a{{{s}}}" >> "$cfg_file"
  echo "!bb,!b b{{{s}}}" >> "$cfg_file"
  echo "!badbang !c{{{s}}}" >> "$cfg_file"
  echo "!badbang {{{s}}}!d" >> "$cfg_file"
  assertEquals "ax" "$(./bangin.sh x!a)"
  assertEquals "ax" "$(./bangin.sh x!aa)"
  assertEquals "bx" "$(./bangin.sh x!b)"
  assertEquals "bx" "$(./bangin.sh x!bb)"
  assertNull "$(./bangin.sh x!c)"
  assertNull "$(./bangin.sh x!d)"
}

. shunit2

