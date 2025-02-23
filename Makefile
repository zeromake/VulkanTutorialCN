dist: md
	rm -rf dist docs
	cp -r img src/
	mkdir -p docs
	mdbook build
	mv dist/epub/*.epub docs/
	mv dist/html/* docs
pdf: md
	cp -r img build/
	pandoc -s build/Vulkan编程指南.md -o docs/Vulkan编程指南.pdf --pdf-engine=xelatex -V CJKmainfont=KaiTi -V geometry:"top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm"
md:
	mkdir -p build
	mkdir -p src
	pandoc -s Vulkan编程指南.tex -o build/Vulkan编程指南.md
	xmake lua scripts/md-clear.lua build/Vulkan编程指南.md
	xmake lua scripts/md-split.lua -o src build/Vulkan编程指南.md
