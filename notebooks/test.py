from os.path import splitext
from os import walk
import shutil

pathmd = "chapitres/"
_, _, dir1 = next(walk(pathmd), (None, None, []))

for file in dir1:
    if "Chapitre" in file:
        shutil.move("chapitres/"+file,"../_correctionsfr")
    elif "Chapiter" in file:
        shutil.move("chapitres/"+file,"../_correctionsen")

