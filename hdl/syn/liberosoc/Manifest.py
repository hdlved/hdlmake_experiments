target = "microsemi"
action = "synthesis"

syn_family = "PolarFireSoC"
syn_device = "MPFS250T"
syn_grade = "-1"
syn_package = "FCVG484"
syn_top = "repinned_top"
syn_project = "demo"
syn_tool = "liberosoc"

modules = {
  "local" : [ "../../rtl/lib_c" ],
}

