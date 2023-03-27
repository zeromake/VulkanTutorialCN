import("core.base.option")

local options = {
    {nil, "inputs",  "vs", nil, "输入 md 支持多个文件按顺序当作单文件处理"},
    {"o", "output",  "kv",  "src", "输出目录(src)"}
}

function main(...)
	local argv = option.parse({...}, options, "分割 md 文件，给 mdbook 使用")
	local out = nil
	local toc = io.open(path.join(argv.output, "SUMMARY.md"), "w")
	local n = 0
	for _, input in ipairs(argv.inputs) do
		for line in io.lines(input) do
			if line:startswith("# ") or line:startswith("## ") then
				local is_top = line:startswith("# ")
				if out ~= nil then
					out:close()
					out = nil
				end
				local title = string.sub(line, 3):trim()
				local ch = n.."-"..title..".md"
				n = n + 1
				if is_top then
					toc:write(string.format("- [%s](%s)\n", title, ch))
				else
					toc:write(string.format("    - [%s](%s)\n", title, ch))
				end
				out = io.open(path.join(argv.output, ch), "w")
			end
			if line:startswith('-   EPUB') then
				line = '- [EPUB](Vulkan编程指南.epub)'
			end
			if line:startswith('-   PDF') then
				line = '- [PDF](Vulkan编程指南.pdf)'
			end
			if out ~= nil then
				out:write(line)
				out:write("\n")
			end
		end
	end
	if out ~= nil then
		out:close()
		out = nil
	end
	toc:close()
end
