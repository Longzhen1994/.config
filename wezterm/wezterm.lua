local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 主题配置
config.color_scheme_dirs = {
  "/Users/LongZhen/.config/wezterm/wezterm-modus-themes/colors"
}

-- 根据系统亮/暗模式自动切换主题
function scheme_for_appearance(appearance)
  return appearance:find('Dark') and 'modus-vivendi' or 'modus-operandi'
end

-- 监听系统主题变化并自动更新
wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local scheme = scheme_for_appearance(window:get_appearance())
  
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

-- 窗口设置
config.window_background_opacity = 1.0
config.window_decorations = "TITLE|RESIZE|MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR"
config.window_padding = {
  left = 20,
  right = 20,
  top = 4,
  bottom = 6,
}

-- 字体设置：西文优先使用 Aporetic Sans Mono，中文使用 LXGW WenKai Mono GB
config.font = wezterm.font_with_fallback({
  { family = "JetBrains Mono", weight = "Regular" },
  { family = "LXGW WenKai Mono GB", weight = "Medium" },
})

-- 性能与渲染设置
config.front_end = "WebGpu"  -- 使用 WebGPU 作为渲染后端，提升性能
config.animation_fps = 240   -- 将动画帧率从240降至120，减少资源消耗
config.max_fps = 240         -- 最大帧率也降至120，平衡性能与流畅度

-- 文本与字体显示调整
config.cell_width = 1.01     -- 字符单元格宽度系数
config.font_size = 13.0      -- 字体大小
config.custom_block_glyphs = true  -- 启用自定义块状字符
config.underline_thickness = "1.5pt"  -- 下划线粗细
config.line_height = 1.1     -- 行高倍数

-- 标签栏设置：追求极简风格
config.show_tabs_in_tab_bar = false  -- 不显示标签页
config.show_tab_index_in_tab_bar = false  -- 不显示标签索引
config.hide_tab_bar_if_only_one_tab = true  -- 只有一个标签时隐藏标签栏
config.show_new_tab_button_in_tab_bar = false  -- 隐藏新建标签按钮

-- 禁用终端铃声
config.audible_bell = "Disabled"

-- -- 添加键盘快捷键
-- config.keys = {
--   -- Ctrl+Shift+N 新建窗口
--   {
--     key = "n",
--     mods = "CTRL|SHIFT",
--     action = wezterm.action.SpawnWindow,
--   },
--   -- Alt+左右箭头在单词间移动
--   {
--     key = "LeftArrow",
--     mods = "OPT",
--     action = wezterm.action.SendKey {
--       key = "b",
--       mods = "ALT",
--     },
--   },
--   {
--     key = "RightArrow",
--     mods = "OPT",
--     action = wezterm.action.SendKey {
--       key = "f",
--       mods = "ALT",
--     },
--   },
-- }

-- -- 启用滚动条但设置为自动隐藏
-- config.enable_scroll_bar = true
-- config.scrollbar_behavior = "Auto"

return config
