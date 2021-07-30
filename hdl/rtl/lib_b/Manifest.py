import os, errno
from pathlib import Path


source_folder = Path("../common_across_libs/")
src = source_folder / 'axi_regs.vhd'
dst = 'axi_regs.vhd'

# if does not exist then create a new symlink...
if os.path.islink('axi_regs.vhd'):
   print("a symlink to the file exists: yay!")
elif os.path.isfile('axi_regs.vhd'):
	print("a file with the same name exists...   not sure we should ever see this")
else:
	os.symlink(src, dst)


files = [
    "register_types_pkg.vhd",
    "register_access_fns_pkg.vhd",
    "axi_regs.vhd",
]

library = "lib_b"
