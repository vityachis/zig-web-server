_:
	@printf "_\n"

build:
	@docker run --rm -v ./:/app -w /app alpine:3 sh -c "apk add --no-cache zig && zig build -Doptimize=ReleaseSafe"

run: build
	@exec docker run --rm --init -p 8080:8080 -v ./:/app -w /app alpine:3 ./zig-out/bin/zig_server
