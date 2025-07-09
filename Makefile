_:
	@printf "_\n"

run:
	docker run --rm -p 8080:8080 -v ./:/app -w /app alpine:3 sh -c "./run.sh"