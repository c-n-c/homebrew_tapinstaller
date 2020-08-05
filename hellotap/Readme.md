#### Demo installer for the brew component

- install.sh - shell script that is called by brew formula, can be replaced by a go script as well.
- makefile.sh - zip the content of this directory excluding makefile and formula template.
- formula.rb - ruby formula template which will be parsed with make for creating a tap formula.
- 
