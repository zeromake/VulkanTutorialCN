dist: md
	rm -rf dist docs
	cp -r img src/
	mkdir -p docs
	mdbook build
	mv dist/epub/*.epub docs/
	mv dist/html/* docs
pdf: md
	cp -r img build/
	pandoc -s build/Vulkan���ָ��.md -o docs/Vulkan���ָ��.pdf --pdf-engine=xelatex -V CJKmainfont=KaiTi
md:
	mkdir -p build
	mkdir -p src
	pandoc -s Vulkan���ָ��.tex -o build/Vulkan���ָ��.md
	xmake lua scripts/md-clear.lua build/Vulkan���ָ��.md
	xmake lua scripts/md-split.lua -o src build/Vulkan���ָ��.md
