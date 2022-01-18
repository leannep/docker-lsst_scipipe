# !/usr/bin/env python

import os
import subprocess

def main():
    for var in os.environ:
        if (var.endswith("DIR") and f"SETUP_{var[:-4]}" in os.environ):
            pth = os.environ[var] + "/python/lsst"
            print(pth)
            init_update = subprocess.run(["mkinit", "--recursive", pth, '-w'])
            print("The exit code was: %d" % init_update.returncode)

if __name__ == "__main__":
    main()