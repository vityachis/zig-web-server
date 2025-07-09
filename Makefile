_:
	@printf "Nothing!\n"

run:
	docker run --rm -p 8080:8080 -v ./:/app -w /app alpine:3 sh -c "apk add --no-cache zig && zig build && ./zig-out/bin/zig_server"