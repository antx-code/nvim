-- Neovim 插件，使用 TypeScript 编译器 (tsc) 进行无缝、异步的项目范围 TypeScript 类型检查
-- 这个 Neovim 插件提供了一个异步接口，可以使用 TypeScript 编译器 ( tsc ) 运行项目范围的 TypeScript 类型检查。它在快速修复列表中显示类型检查结果，并提供有关类型检查的进度和完成情况的视觉通知。

return {
  "dmmulroy/tsc.nvim",
  cmd = { "TSC" },
  opts = {},
}
