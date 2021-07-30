Purpose of this project:  
  Test (and develop) the capabilites of HDLMAKE. 
  Initially this has been used to prototpye support for VHDL libraries. However the code also requires 
  
  This is based on using the current latest version of HDLMAKE from OHWR (branch develop) to work with multiple libraries, and re-use a single source (.vhd) file in multiple libraries, This does demonstrate an alternative way of building a CSR to Cheby...  

there are 2 libraries hdl/rtl/lib_a and hdl/rtl/lib_b; Both of these libraries contain:
 - "register_types_pkg.vhd"      : records for the local IO of a register block (rather than the bus interface) specific to the library
 - "register_access_fns_pkg.vhd" : A package that converts handles byte mapping the feilds from the records (register_types_pkg.vhd) to the bus. 

 
hdl/rtl/common/axi_regs.vhd  is compiled into both lib_a and lib_b libraries,  so we get code-reuse of this module.

Benefits:
 - pre verified module that can just use a package to re-map register feilds. 
 - Bus width change is a generic that can be passed down and into the module.
 - generics can control pipelineing etc within a module. Potentially on a per instance basis if the library component is reused. 
 - writing a replacement for axi_regs would allows the same register mapping package to support a different bus protocol e.g. WB or avalon.......
 - This could be considered as an extension for CHEBY, but here is is mostly because it was highly re-useable component..
 - Halfway house to using VHDL2008
 - the code for the register block is simpler to edit and the packages are Very human readable!
 
disadvantages: 
 - Bugfixes in HDLMAKE for library support. 
 - Vendor tool bugs (Libero)
 - If registers were to be implemented this way then it needs a code-gen adding in CHEBY.
 - feature support and growth, is potentially a little more involved 



Status (checked 30 Jul 2021), against hdlmake develop branch with commit bcc5eff6:

Simulation Tools
- Questasim (windows, 2019.1) works

- GHDL simulation (0.37 ubuntu): works  
  - assumes top level of the testbench is in the work library (for the elab call)
  - make clean leaves some folders behind causing make to no longer work

  
Synthesis / FPGA toolflows
  
- ISE (Linux, 14.7): working 
  - ISE does not allow the use of a single "physical .vhd file in multiple libraries
    - workarround: symlink the files into a fiolder for each library, this does require some windows permission fiddling!
    - the way it has been implemented needs python3; I am sure a proper Python/SW developer has a better approach!
    - A demo for this is now integrated into hdlmake   e.g. testsuite/113_ise_libraries 
 
- Vivado: (windows) Works

- Quartus_pro (windows): Works

- liberioSOC (windows): fails
  - hdlmake output needs support for VHDL libraries, example of what I would expect to be generated (files.tcl and project.tcl) is commited	
  - Liberio has 2 bugs
    - UI does not display both "regs" instances. only one is shown.
    - When Libero writes out as a script for synplify_pro to synthesise, some files are missing. (matching UI behav above)
      - An example project has been added to show synplify works correctly, (hdl/syn/synplify_libero). The outpus form synplify is corectly handeled by libero.     
     
- liberosoc_synplify (windows) : pass
  - this does not test HDLMAKE but contains a project file to demonstrate that the code can be processed by the synthesis tool used in LiberoSOC as described above 
      
- GHDL Synthesis (Linux xxxx): fails
  - hdlmake produces a correct Makefile, but the HDL pushes GHDL a little too far, fixes in progress...
    - extraneous use of Library
    - multiple components in output .vhd with the same name (i.e. not having a unique name including library)
  - Manifest.py should allow for setting the output filename.
 
- Synplify_pro (windows): pass
  - Currently WORK in progresss.  the Author is experimenting with Supporting SynplifyPro as a standalone tool in HDLMAKE.
  - This is allow direct control of syntheis to work arround the Libero UI bug above.
  - The HDLMAKE code for this is not yet public...
  