#!/bin/bash

set -e

EXERCISES_DIR=exercises
DEMOS_DIR=demos
CGAL_DIR=CGAL-3.8

function build {
	for proj in `ls $1`; do
		pushd $1/$proj
		qmake >/dev/null || continue
		make
		popd
	done
}

echo "Setting up geoc viewer installation"

echo "Compiling CGAL"
pushd $CGAL_DIR
cmake .
make
popd

echo "Making initial library build (release mode)"
make

echo "Compiling exercises"
build $EXERCISES_DIR

echo "Compiling demos"
build $DEMOS_DIR

echo "Compiling additional demos"
build $DEMOS_DIR/make_grid
