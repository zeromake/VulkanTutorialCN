dist: md
	rm -rf dist
	cp -r img src/
	mdbook build
	mv dist/epub/*.epub dist/
	mv dist/html/* dist
	rm -rf dist/epub dist/html
pdf: md
	cp -r img build/
	pandoc -s build/Vulkan���ָ��.md -o dist/Vulkan���ָ��.pdf --pdf-engine=xelatex -V CJKmainfont=KaiTi
md:
	mkdir -p build
	mkdir -p src
	pandoc -s Vulkan���ָ��.tex -o build/Vulkan���ָ��.md
	xmake lua scripts/md-clear.lua build/Vulkan���ָ��.md
	xmake lua scripts/md-split.lua -o src build/Vulkan���ָ��.md
