build/build.ninja: CMakeLists.txt
	@mkdir -p build
	cmake  \
		-DCMAKE_INSTALL_PREFIX=/usr/arm-none-eabi \
		-S . -B build \
		-G Ninja

.PHONY: install
install: build/build.ninja
	sudo ninja -C build install

.PHONY: clean
clean:
	rm -rf build