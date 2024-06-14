.PHONY : all clean image

UNAME = $(shell uname)
CMDSTAN_VERSION = 2.34.1
CMDSTAN_HOME ?= ${HOME}/.cmdstan/cmdstan-${CMDSTAN_VERSION}
STAN_FILES = $(wildcard matern*.stan)
OUTPUT_FILES = $(addsuffix -${UNAME}.txt,${STAN_FILES:.stan=})

all : ${OUTPUT_FILES}

${OUTPUT_FILES} : %-${UNAME}.txt : %.stan transformed_data.stan run.py
	python run.py $< $@
	cat $@

image :
	docker build --build-arg CMDSTAN_VERSION=${CMDSTAN_VERSION} -t stan-matern-debug .

clean :
	rm -f matern*.txt *.hpp
