dist: md
	rm -rf dist
	cp -r img src/
	mdbook build
	mv dist/epub/*.epub dist/
	mv dist/html/* dist
	rm -rf dist/epub dist/html
pdf: md
	cp -r img build/
	pandoc -s build/Vulkan编程指南.md -o dist/Vulkan编程指南.pdf --pdf-engine=xelatex -V CJKmainfont=KaiTi
md:
	mkdir -p build
	mkdir -p src
	pandoc -s Vulkan编程指南.tex -o build/Vulkan编程指南.md
	xmake lua scripts/md-clear.lua build/Vulkan编程指南.md
	xmake lua scripts/md-split.lua -o src build/Vulkan编程指南.md
