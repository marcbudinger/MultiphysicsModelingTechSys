try:
    from urllib.parse import quote  # Py 3
except ImportError:
    from urllib2 import quote  # Py 2
	
from os.path import splitext
from os import walk
import os
import sys


def path2url(path):
    return '{{ site.baseurl }}/img/' + os.path.basename(path)
	

pathmd = "../correctionsfr/"


#Liste des notebooks sauf index.ipynb
nbtoconvert = []
for root, dirs, files in os.walk('.'):
    for file in files:
        if file.endswith('.ipynb'):
             nbtoconvert.append(file)


#Configuration de nbconvert
c = get_config()
c.NbConvertApp.export_format = 'markdown'
c.MarkdownExporter.template_file = 'jekyll'
c.Exporter.file_extension = '.md'
c.NbConvertApp.output_files_dir = '../img'
c.MarkdownExporter.filters = {'path2url': path2url}
c.FilesWriter.build_directory = pathmd
c.NbConvertApp.notebooks = nbtoconvert


#Supression des .md sans notebooks			 
_, _, dir1 = next(walk(pathmd), (None, None, []))
_, _, dir2 = next(walk('.'), (None, None, []))
documents = set([splitext(filename)[0] for filename in dir2])
diff = [filename for filename in set(dir1) if splitext(filename)[0] not in documents]

for file in diff:  
	try:
		os.remove(pathmd + file)
		print ("Supression du fichier : "+file)
	except OSError as e: 
		print ("Erreur: %s - %s." % (e.filename, e.strerror))
		
