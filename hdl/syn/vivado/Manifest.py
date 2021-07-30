target = "Xilinx"
action = "synthesis"

syn_family = "Zynq Ultrascale"
syn_device = "xczu7eg"
syn_grade = "-1-e"
syn_package = "-ffvf1517"
syn_top = "repinned_top"
syn_project = "demo"
syn_tool = "vivado"

modules = {
  "local" : [ "../../rtl/lib_c" ],
}

