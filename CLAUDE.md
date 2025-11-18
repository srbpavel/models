- open scad battery box + spacer for batteries

- tool to use is open_scad so study it's doc
- you have local study in sources/
- you have mcp context7 mcp server
- be sure to follow doc and do not blidly write code as you believe the fn is there

- workdir is rugged_box_for_batteries -> /home/conan/git/models/rugged_box_for_batteries
- there you will find in dir original/ files for 18650_bateries+spacer and rugged_box

- main steps
- study the original code, and do not deviate from core logic and config/setup
- create in /home/conan/git/models/rugged_box_for_batteries we will have:
-- main.scad
-- battery_holder.scad 
-- rugged_box.scad

--- main will call both libs and the place where we config all according rules in libs.
--- choose battery
	choose matrix (battery count)
	choose box part to view
	choose box open lid param
	and all ....
--- so then user can fully define and view
	we will also have a way to define which part to view, to be able to export stl
	just box bottom
	just box lid
	just spacer
	see all
	
	
--- we try to bend openscad call like in rust style enums and etc, just to have minimal space for errors
