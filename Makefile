build:
	@echo "Building resume..."
	@mkdir -p ./src/build
	@echo "Compiling resume..."
	@typst compile ./src/main.typ ./src/build/main.pdf
	@echo "Resume built successfully!"

