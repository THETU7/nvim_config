local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")

local function lines(args, snip, old_state, initial_text)
  local nodes = {}
  if not old_state then
    old_state = {}
  end

  -- count is nil for invalid input.
  local count = tonumber(args[1][1])
  -- Make sure there's a number in args[1].
  if count then
    for j = 1, count do
      local iNode
      if old_state and old_state[j] then
        -- old_text is used internally to determine whether
        -- dependents should be updated. It is updated whenever the
        -- node is left, but remains valid when the node is no
        -- longer 'rendered', whereas node:get_text() grabs the text
        -- directly from the node.
        iNode = i(j, old_state[j].old_text)
      else
        iNode = i(j, initial_text)
      end
      nodes[2 * j - 1] = iNode

      -- linebreak
      nodes[2 * j] = t({"", ""})
      -- Store insertNode in old_state, potentially overwriting older
      -- nodes.
      old_state[j] = iNode
    end
  else
    nodes[1] = t("Enter a number!")
  end

  local snip = sn(nil, nodes)
  snip.old_state = old_state
  return snip
end

local function head_des(str)
  local count = 18
  local limit = 70
  local len = string.len(str)
  local r = ""
  for j = 1, limit - count - len do
    r = r .. " "
  end
  r = r .. "*"
  return r
end

local function head_line(str, pre, old_pre)
  local limits = 70
  local iNode = ""
  if pre then
    iNode = " " .. pre .. " " .. str
  else
    iNode = " " .. old_pre .. " " .. str
  end

  local left_limit = limits - 5
  if string.len(iNode) > left_limit then
    local tem = string.sub(iNode, left_limit, -1)
    head_line(tem, nil, pre)
    iNode = string.sub(iNode, 0, left_limit)
  end
  for j = string.len(iNode), (limits - 1) do
    iNode = iNode .. " "
  end
  if pre then
    iNode = iNode .. pre
  else
    iNode = iNode .. old_pre
  end
  return iNode
end

local function head(args, snip, old_state, initial_text)
  if not old_state then
    local old_state = {}
  end
  local limit = 70
  -- initial_text 用空格分开以获取开始和结尾字符
  local start = string.match(initial_text, ".* ")
  local end_str = string.gsub((string.match(initial_text, " .*")), " ", "")
  local nodes = {}
  nodes[1] = string.gsub(start, " ", "")
  for j = string.len(nodes[1]), limit do
    nodes[1] = nodes[1] .. "*"
  end
  local file = snip.env.TM_FILENAME
  nodes[1] = nodes[1]
  nodes[2] = t({"", ""})
  nodes[3] = "@ Copyright (C) " .. os.date("%Y", os.time()) .. " Zongyang All rights reserved."
  nodes[5] = " "
  nodes[7] = "@ Author: Zongyang"
  nodes[9] = "@ Date: " .. os.date("%Y-%m-%d %H:%M", os.time())
  nodes[11] = "@ File: " .. file
  nodes[13] = " "
  nodes[1] = t(nodes[1])

  local nums = 7
  for j = 2, nums do
    nodes[2 * j - 1] = t(head_line(nodes[2 * j - 1], "*", nil))
    nodes[2 * j] = t({"", ""})
  end
  local endline = #nodes
  endline = endline + 1
  --[[  nodes[endline] = " "]]
  --[[for j = 1, limit - 1 do]]
  --[[nodes[endline] = nodes[endline] .. "*"]]
  --[[end]]
  --[[nodes[endline] = t(nodes[endline] .. end_str)]]
  --[[nodes[endline + 1] = t({"", ""})]]
  --[[  if string.match(file, ".h") then]]
  --[[local tem = string.upper(string.gsub(file, "%.", "_"))]]
  --[[nodes[endline + 2] = t({"#ifndef " .. tem, "#define " .. tem, ""})]]
  --[[  -<]-[[nodes[endline + 3] = i(1)]]
  --[[nodes[endline + 4] = t({"", "#endif"})]]
  --end
  local snip = sn(nil, nodes)
  return snip
end

local function head_end(args, _, old_state)
  local limit = 70
  local nodes = " "
  for j = 1, limit - 1 do
    nodes = nodes .. "*"
  end
  return nodes .. "*/"
end

local function test(args, _, old_state, initial)
  local str = args[1][1]
  local h = i(1, head_des(str))
  return sn(nil, h)
end

ls.snippets = {
  c = {
    s(
      "head",
      {
        d(3, head, {}, "/* */"),
        t(" * @ Description: "),
        i(1),
        d(nil, test, {1}, "test"),
        t {"", ""},
        f(
          function(args, snip)
            local limit = 70
            local r = " "
            for j = 1, limit - 1 do
              r = r .. "*"
            end
            r = r .. "*/"
            return r
          end,
          {}
        ),
        t({"", ""}),
        d(
          nil,
          function(args, snip)
            local file = snip.env.TM_FILENAME
            local nodes = ""
            if string.match(file, ".h") then
              local tem = string.upper(string.gsub(file, "%.", "_"))
              nodes = t({"#ifndef " .. tem, "#define " .. tem, ""})
            else
              nodes = t(" ")
            end
            return sn(nil, nodes)
          end,
          {}
        ),
        i(0),
        t({"", ""}),
        f(
          function(args, snip)
            if string.match(snip.env.TM_FILENAME, ".h") then
              return "#endif"
            else
              return " "
            end
          end,
          {}
        )
      }
    )
  }
}
