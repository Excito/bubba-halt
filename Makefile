CFLAGS_EXTRA=\
			 -O3 \
			 -g \
			 -Wall \
			 -Wextra \
			 -Wno-unused-result \
			 -std=gnu99 \
			 -DMTD_PART="\"/dev/mtd2\""
LDFLAGS_EXTRA=

APP=write-magic
APP_SRC=write-magic.c
OBJ=$(APP_SRC:%.c=%.o)

SOURCES=$(APP_SRC)
APPS=$(APP)
OBJS=$(OBJ)
DEPDIR = .deps

all: pre $(APPS)

%.o : %.c
	$(COMPILE.c) $(CFLAGS_EXTRA) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -o $@ $<
	mv -f $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Po

-include $(SOURCES:%.c=.deps/%.Po)

pre:
	@@if [ ! -d .deps ]; then mkdir .deps; fi

$(APP): $(OBJ)
	$(CC) $(LDFLAGS) $(LDFLAGS_EXTRA) $^ -o $@

clean:                                                                          
	rm -f *~ $(APPS) $(OBJS)
	rm -rf .deps

.PHONY: clean all pre
