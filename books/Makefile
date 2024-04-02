# [Filename]
# books\Makefile
#
# [Function]
# docbook top level makefile
# to batch compile/clean sub docbook books
# such as: clean/clean_all/clean_release/all/release
#
# [Version]
# 2013-10-04
#
# [Author]
# Crifan Li
# 
# [Note]
# 1. this makefile should be located in the parent dir of src Makefile

#LS_OUTPUT=$(shell ls)
SUB_BOOKS=$(shell ls)
#SUB_BOOKS=LS_OUTPUT
#SUB_BOOKS=$(shell for each_ls in $(LS_OUTPUT);do if [ -d $each_ls ]; then $(SUB_BOOKS)+=$each_ls; fi; done) 
#SUB_BOOKS := $(foreach each_ls, $(LS_OUTPUT), $(if test -d $(each_ls), $(each_ls)))

# all:      make_all
# release:  make_release
# clean:            make_clean
# clean_all:        make_clean_all
# clean_release:    make_clean_release

#goto every sub foler(single book)'s src dir to do 'make xxx' action
clean clean_all clean_release all release release_copy pdf_copy:
	@echo "Current path="`pwd`;
	@echo "LS_OUTPUT="$(SUB_BOOKS);
	@for each_item in $(SUB_BOOKS); \
	do \
	    if [ -d $$each_item/src ]; then \
	            cd  $$each_item/src && \
	            echo `pwd` && \
	            if [ -f Makefile ]; then \
	                make $@ || exit "$$?"; \
	            fi; \
	            cd ../..; \
	    fi; \
	done;
