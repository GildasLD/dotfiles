import csv
import os


# Fonction pour diviser le fichier CSV
def split_csv(input_file, max_lines=800):
    # Nom du dossier de sortie où les fichiers divisés seront stockés
    output_dir = "output_parts"
    os.makedirs(output_dir, exist_ok=True)

    # Ouvrir le fichier d'entrée
    with open(input_file, "r", encoding="utf-8") as infile:
        reader = csv.reader(infile)

        # En-tête du fichier CSV
        headers = next(reader)

        part_num = 1
        part_lines = []

        for i, row in enumerate(reader):
            part_lines.append(row)
            if len(part_lines) >= max_lines:
                # Créer un nouveau fichier CSV pour chaque partie
                output_file = os.path.join(output_dir, f"part_{part_num}.csv")
                with open(output_file, "w", encoding="utf-8", newline="") as outfile:
                    writer = csv.writer(outfile)
                    # Écrire l'en-tête
                    writer.writerow(headers)
                    # Écrire les lignes
                    writer.writerows(part_lines)
                print(f"Partie {part_num} enregistrée dans : {output_file}")
                part_num += 1
                # Réinitialiser les lignes pour la prochaine partie
                part_lines = []

        # Si des lignes restantes existent, les sauvegarder dans un dernier fichier
        if part_lines:
            output_file = os.path.join(output_dir, f"part_{part_num}.csv")
            with open(output_file, "w", encoding="utf-8", newline="") as outfile:
                writer = csv.writer(outfile)
                writer.writerow(headers)
                writer.writerows(part_lines)
            print(f"Partie {part_num} enregistrée dans : {output_file}")


input_file = "motsdepasse.csv"

split_csv(input_file, max_lines=800)
