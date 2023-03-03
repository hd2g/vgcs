OUT_DIR := ./dist
OUT_BIN := vgcs
OUT := $(OUT_DIR)/$(OUT_BIN)

SRC := google_custom_search

VC := v

.PHONY:  all clean test build
.SILENT: all clean test build

all: clean test build

clean:
	[ -d $(OUT_DIR) ] && rm -r $(OUT_DIR)

test:
	$(VC) test $(SRC)

build:
	mkdir -p $(OUT_DIR) && \
	$(VC) $(OUT_BIN).v -W -o $(OUT)
