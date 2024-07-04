-- 一小段 Vimscript 添加用于复制当前文件的相对路径、绝对路径、名称和目录的命令。

return {
  "AdamWhittingham/vim-copy-filename",
  cmd = {
    "CopyRelativePath",
    "CopyRelativePathAndLine",
    "CopyAbsolutePath",
    "CopyAbsolutePathAndLine",
    "CopyFileName",
    "CopyDirectoryPath",
  },
}
