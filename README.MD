# Purpose of this project:  
 - Test (and develop) the capabilites of HDLMAKE. 
 - Initially this has been used to prototpye support for VHDL libraries. But is is continuing to be developed (slowly).
 - Experimentation is based on using the current latest version of HDLMAKE from OHWR (branch develop) (https://ohwr.org/project/hdl-make/tree/develop).
if doing any development the Autor strongly suggests you configure hdlmake to run using the source rather than installing it (e.g. https://hdlmake.readthedocs.io/en/master/#installing-hdlmake)
 - Most of the results of this work have already been merged back into HDLMAKE. (21 Jul 2021)


# Status (checked 30 Jul 2021), against hdlmake develop branch with commit bcc5eff6:

## Simulation Tools
- Questasim (windows, 2019.1): Working

- GHDL simulation (0.37 ubuntu): Working  
  - assumes top level of the testbench is in the work library (for the elab call)
  - make clean leaves some folders behind causing make to no longer work

  
## Synthesis / FPGA toolflows
  
- ISE (Linux, 14.7): working 
  - ISE does not allow the use of a single "physical .vhd file in multiple libraries
    - workarround: symlink the files into a fiolder for each library, this does require some windows permission fiddling!
    - the way it has been implemented needs python3; I am sure a proper Python/SW developer has a better approach!
    - A demo for this is now integrated into hdlmake   e.g. testsuite/113_ise_libraries 
 
- Vivado: (windows) Working

- Quartus_pro (windows): Working

- liberioSOC (windows): fails
  - hdlmake output is good
  - Liberio has 2 bugs
    - UI does not display both "regs" instances. only one is shown.
    - When Libero writes out as a script for synplify_pro to synthesise, some files are missing. (matching UI behav above)
      - An example project has been added to show synplify works correctly, (hdl/syn/synplify_libero). The outpus form synplify is corectly handeled by libero.     
     
- liberosoc_synplify (windows) : Working
  - this does not test HDLMAKE but contains a project file to demonstrate that the code can be processed by the synthesis tool used in LiberoSOC as described above 
      
- GHDL Synthesis (Linux xxxx): fails
  - hdlmake produces a correct Makefile, but the HDL pushes GHDL a little too far, fixes in progress...
    - extraneous use of Library
    - multiple components in output .vhd with the same name (i.e. not having a unique name including library)
  - Manifest.py should allow for setting the output filename.
 
- Synplify_pro (windows): Working
  - Currently WORK in progresss.  the Author is experimenting with Supporting SynplifyPro as a standalone tool in HDLMAKE.
  - This is allow direct control of syntheis to work arround the Libero UI bug above.
  - The HDLMAKE code for this is not yet public...




# Description of the RTL
  
Notionally I wanted to demonstrate the use of Libraries as an Alternative to some fo the features of VHDL'08 (e.g. generic types and functions), and a register set is an ideal example component for this.
Additionally when wanting to use another OHWR (CERN) project CHEBY to produce a register set, I had to copy ane edit the file to produce different bus protocols. 
Seperating the functionality of the module and it's 'user' IO from the bus-specific implementation increases re-use. To the autors mind, as an approach, it also increases the readability to a human: 
  e.g. the register_address -> feild within the user_io record is more debuggable to a human.
Although not the main purpose of this repository it highlights a possilbe extension to tools such as Cheby.

NOTE: although notionally a AXI4_Lite register set this is NOT compliant!!!

There are 2 libraries hdl/rtl/lib_a and hdl/rtl/lib_b; Both of these libraries contain:
 - "register_types_pkg.vhd"      : records for the local IO of a register block (rather than the bus interface) specific to the library
 - "register_access_fns_pkg.vhd" : A package that converts handles byte mapping the feilds from the records (register_types_pkg.vhd) to the bus. 
 
hdl/rtl/common_across_libs/axi_regs.vhd  
 - is compiled into both lib_a and lib_b libraries,  so we get code-reuse of this module.
 - HOWEVER because of an ISE bug symlinking us used instead oif just directly referencing the file... 
     
hdl/rtl.lib_c 
 - contains some example code to use axi_regs from both lib_a and lib_b into the same entity, and wire them together.

      
#### Benefits vs Cheby:
 - pre verified module (axi_regs) that can just use a package to re-map register feilds.
 - Bus width change is a generic that can be passed down and into the module.
 - generics can control pipelineing etc within a module. Potentially on a per instance basis if the library component is reused. 
 - writing a replacement for axi_regs would allows the same register mapping package to support a different bus protocol e.g. WB or avalon.......
 - This could be considered as an extension for CHEBY, but here is is mostly because it was highly re-useable component..
 - Halfway house to using VHDL2008
 - the code for the register block is simpler to edit and the packages are Very human readable!
 
#### disadvantages: 
 - Bugfixes were required for HDLMAKE library support. 
 - Vendor tool bugs (Libero)
 - If registers were to be implemented this way then it needs a code-gen adding in CHEBY.
 - feature support and growth, is potentially a little more involved 




  
  
  
  
  
