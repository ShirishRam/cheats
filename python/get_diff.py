# @author Shirish Ramchandran
# @github shirish.ram
# This program returns the code diff between all files in 2 repositories or 2 branches in the same repository.
# The program runs for most of the file types like .py, .java, .php, .html, .js, .json, etc. files.
# usage: python get_diff.py <firstFolder> <secondFolder>

import os
import sys
import difflib

if len(sys.argv) < 3:
    print '[ERR]: Not enough arguments passed. Usage: get_diff.py <firstFolder> <secondFolder>'
    sys.exit()

# Accept root folders arguments
firstFolderRoot = sys.argv[1]
secondFolderRoot = sys.argv[2]
acceptedFileTypes = (".py", ".java", ".php", ".js", ".html", ".phtml", ".css", ".xml", ".json", ".yml", ".c", ".cpp")

# All dirs in first folder
firstFolderDirs = [x[0] for x in os.walk(firstFolderRoot)]

# Loop through each directory in first folder
for firstFolderDir in firstFolderDirs:

    # Loop through all files in the directory
    for filename in os.listdir(firstFolderDir):
        if filename.endswith(acceptedFileTypes):
             firstFolderFilePath = os.path.join(firstFolderDir, filename)
             secondFolderFilePath = os.path.join(firstFolderDir.replace(firstFolderRoot, secondFolderRoot), filename)

             # Check if file exists in secondFolderRoot
             if(not os.path.isfile(secondFolderFilePath)):
                print "[INFO]: Could not find matching file in secondFolderRoot for "+firstFolderFilePath
                continue
             else:
                firstFolderFile = open(firstFolderFilePath)
                secondFolderFile = open(secondFolderFilePath)
                print "Diff between "+firstFolderFile.name+" and "+secondFolderFile.name+":"
                # Find diff
                for line in difflib.unified_diff(firstFolderFile.readlines(), secondFolderFile.readlines()):
                    print line,
             continue
        else:
             continue
