target = "altera"
action = "synthesis"

syn_family = "Cyclone 10 GX"
syn_device = "10CX150"
syn_grade = "I5G"
syn_package = "YF672"
syn_top = "repinned_top"
syn_project = "demo"
syn_tool = "quartus"

modules = {
  "local" : [ "../../rtl/lib_c" ],
}

