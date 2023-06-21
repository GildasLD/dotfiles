import sys
import re
from collections import defaultdict


def parse_prefs_file(filename):
    prefs = defaultdict(list)

    with open(filename, "r") as file:
        for line in file:
            match = re.match(r"user_pref\('(.+?)',(.*)\)", line)
            if match:
                key = match.group(1)
                value = match.group(2)
                prefs[key].append(value)

    return prefs


def find_similar_properties(prefs):
    similar_properties = {}
    for key, values in prefs.items():
        if len(values) > 1:
            similar_properties[key] = values

    return similar_properties


def display_similar_properties(similar_properties):
    if similar_properties:
        print("Propriétés similaires trouvées :")
        for key, values in similar_properties.items():
            print(f"{key}: {values}")
    else:
        print("Aucune propriété similaire trouvée.")


def main(filename):
    prefs = parse_prefs_file(filename)
    similar_properties = find_similar_properties(prefs)
    display_similar_properties(similar_properties)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <filename>")
    else:
        main(sys.argv[1])
