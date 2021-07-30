files = [
    "tb.vhd",
]

library = "tb"

modules = { "local" : ["../../rtl/lib_c",
                      ]
}

# if we are simulating this will be handy... 
vcom_opt = "-93 -mixedsvh"