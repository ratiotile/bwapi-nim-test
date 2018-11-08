import os, re, strutils

const bwapi_dir = "bwapi\\include"

proc ensureDir(path:string)=
  let tok = split(path, "\\")
  let dest_dir = tok[0..^2].join(r"\")
  if not existsOrCreateDir(dest_dir):
    echo "created " & dest_dir

for file in walkDirRec(bwapi_dir):
  if file.match re".*\.h":
    let dest = file
      .replace(re"(bwapi\\include)", "bindings")
      .replace(re"(\.h)", ".nim")
    ensureDir(dest)
    let cmd = "..\\c2nim\\c2nim.exe --cpp --header --debug "&file&" -o:"&dest
    echo cmd
    discard execShellCmd(cmd)
