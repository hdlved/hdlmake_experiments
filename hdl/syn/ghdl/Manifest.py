#target = "altera"
action = "synthesis"


syn_top = "lib_c.repinned_top"
syn_project = "demo"
syn_tool = "ghdl"


modules = {
  "local" : [ "../../rtl/lib_c" ],
}

