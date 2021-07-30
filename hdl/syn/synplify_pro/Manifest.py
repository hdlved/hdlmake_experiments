#target = "altera"
action = "synthesis"


syn_top = "repinned_top"
syn_project = "demo"
syn_tool = "synplify"

files = ["constraints.fdc"]

modules = {
  "local" : [ "../../rtl/lib_c" ],
}

