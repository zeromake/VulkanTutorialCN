import("core.base.option")

local options = {
    {nil, "inputs",  "vs", nil, "输入 md 支持多个文件"},
    {"o", "output",  "kv",  "dist", "输出目录"}
}


function main(...)
	local argv = option.parse({...}, options, "清理 pandoc 的 md 文件的代码 lang")
	local out = nil
	for _, input in ipairs(argv.inputs) do
		local output = path.join(argv.output, path.filename(input))
		out = io.open(output, "w")
		for line in io.lines(input) do
			if line:startswith('```') then
				line = line:gsub('``` %{%.numberLines %.(.*) language.*', "``` %1"):gsub('%[ANSI%]C', "cpp")
			end
			out:write(line)
			out:write("\n")
		end
		out:close()
		local sw = io.readfile(output):gsub('(%w+)\n=\n(%w+)', "%1=%2")
		io.writefile(input, sw)
	end
end
