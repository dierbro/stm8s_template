PROJ_NAME=stm8s_template
SRCS = main.c
DEPS_SRCS = #stm8s_gpio.c stm8s_tim2.c

SDCC_PATH=../../sdcc-3.4.0/bin
STM8S_LIBS_PATH=../stm8s_libs
SDCC=$(SDCC_PATH)/sdcc
SDLD=$(SDCC_PATH)/sdld
DEPS_OBJ = $(DEPS_SRCS:.c=.rel)

CFLAGS=-I. -I$(STM8S_LIBS_PATH)/inc -D__SDCC_STM8S__ -DSTM8S003 --opt-code-speed

.PHONY: all clean flash

all: build


build: $(DEPS_OBJ) 
	$(SDCC) -lstm8 -mstm8 --out-fmt-ihx $(CFLAGS) $(LDFLAGS) $(SRCS) $(DEPS_OBJ) -o $(PROJ_NAME).ihx

clean:
	rm -f $(PROJ_NAME).ihx *.lk  *.lst  *.map  *.rel  *.rst  *.sym *.asm

flash: $(OBJECT).ihx
	stm8flash -cstlink -pstm8l150 -w $(OBJECT).ihx


%.rel: $(STM8S_LIBS_PATH)/src/%.c 
	$(SDCC) -lstm8 -mstm8 $(CFLAGS) $(LDFLAGS) -c $<
