#!/usr/bin/env sh
apk add --no-cache zig && \
  echo '============= RUN =============' && \
  zig build && \
  ./zig-out/bin/zig_server