# 
# Comando que convierte un fichero Markdown en HTML
# incluyendo un fichero CSS
#
# Ejemplo de llamada:
#
# cd semana01
# python3 ../generator.py semana01.md ../lpp.css semana01.html
#
# Necesario: Python3 y Python-Markdown
#
# brew install python
# pip3 install markdown
#


import markdown, codecs, sys

output = """<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
"""

cssin = codecs.open(sys.argv[2], mode="r", encoding="utf-8")

output += cssin.read()

output += """
</head>

<body>
"""
mkin = open(sys.argv[1])
output += markdown.markdown(mkin.read(), extensions = ['admonition', 'extra', 'sane_lists', 'codehilite', 'pymdownx.superfences'])

output += """</body>

</html>
"""

outfile = codecs.open(sys.argv[3], "w",
                      encoding="utf-8",
                      errors="xmlcharrefreplace"
)
outfile.write(output)
outfile.close()
