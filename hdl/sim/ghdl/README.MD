Summary:
   1/ inherent assumption about the library that the top level of the testbench lives in
         --- can I fix this in HDLMAKE Manifest.py?
   2/ HDLMAKE makefile has an oddity to do with "make clean" leaving folders behind that stop subsequent "make" calls 
         



Currently it looks like there is an implicit assumption that the top level entity of the simulation to elaborate is in "work" 
  I had put it into a library "tb" and without changing this have an issue as ghdl -e fails
  
there is an oddity in the created makefile:
   (TO test: make sure the ghdl -e command has a --work=tb entry)
   execure "make", confirm, the simulation "finishes" 
   execute make clean
   NOTE that some directories still exist
   execute make and note it fails.