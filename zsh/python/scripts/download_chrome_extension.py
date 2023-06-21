import argparse
import os
import sys
import zipfile

try:
    from urllib.parse import urlparse, urlencode
    from urllib.request import urlopen
except ModuleNotFoundError:
    from urlparse import urlparse
    from urllib import urlencode
    from urllib2 import urlopen

# Définit un répertoire par défaut pour l'extraction
DEFAULT_EXTRACT_DIR = './extracted_extensions'

arg_parser = argparse.ArgumentParser(description='Téléchargeur et extracteur d\'extensions Chrome')
arg_parser.add_argument('id_or_url',
    help='ID ou URL complète de l\'extension dans le Chrome Web Store')
arg_parser.add_argument('-q', '--quiet',
    action='store_true',
    help='supprime tous les messages')
arg_parser.add_argument('-o', '--output-file',
    required=False,
    help='emplacement pour enregistrer le fichier .CRX')
arg_parser.add_argument('-e', '--extract-dir',
    required=False,
    help='répertoire où extraire les fichiers ZIP (par défaut : ./extracted_extensions)')
args = arg_parser.parse_args(sys.argv[1:])

try:
    ext_url = urlparse(args.id_or_url)
    ext_id = os.path.basename(ext_url.path)
except Exception as e:
    ext_id = args.id_or_url

crx_base_url = 'https://clients2.google.com/service/update2/crx'
crx_params = urlencode({
    'response': 'redirect',
    'prodversion': '91.0',
    'acceptformat': 'crx2,crx3',
    'x': 'id=' + ext_id + '&uc'
})
crx_url = crx_base_url + '?' + crx_params
crx_path = args.output_file if args.output_file else ext_id + '.crx'

# Télécharge le fichier CRX
if not args.quiet:
    print(f'Téléchargement de {crx_url} vers {crx_path} ...')

with open(crx_path, 'wb') as file:
    file.write(urlopen(crx_url).read())

if not args.quiet:
    print('Téléchargement réussi !')

# Convertit CRX en ZIP en changeant simplement l'extension
zip_path = crx_path.replace('.crx', '.zip')
os.rename(crx_path, zip_path)

if not args.quiet:
    print(f'Conversion du fichier {crx_path} en {zip_path}.')

# Détermine le répertoire d'extraction
extract_dir = args.extract_dir if args.extract_dir else DEFAULT_EXTRACT_DIR

# Extrait le fichier ZIP
if not os.path.exists(extract_dir):
    os.makedirs(extract_dir)

try:
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extract_dir)
    if not args.quiet:
        print(f'Extraction réussie dans le répertoire {extract_dir}.')
except zipfile.BadZipFile:
    print('Erreur : Le fichier converti n\'est pas un ZIP valide.', file=sys.stderr)
