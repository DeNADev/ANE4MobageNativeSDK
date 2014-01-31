# Common variables for making ANE For Mobage SDK

include common.mk

# DEBUG
# debug or release
# 1 : Debug build
# 0 : Release build
DEBUG?=0

toggle-jp:
	cd as; make DEBUG=$(DEBUG) REGION=jp

toggle-kr:
	cd as; make DEBUG=$(DEBUG) REGION=kr

all:
	make toggle-jp

clean:
	cd as; make clean