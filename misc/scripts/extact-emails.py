import os
import re
import sys
from email import policy
from email.parser import BytesParser


# Fonction pour extraire les adresses e-mail à partir d'un fichier .eml
def extract_emails_from_eml(file_path):
    with open(file_path, "rb") as file:
        msg = BytesParser(policy=policy.default).parse(file)
        # Initialise un ensemble pour stocker les adresses e-mail uniques
        emails = set()

        # Parcourt les en-têtes pertinents pour trouver les adresses e-mail
        for header in ["From", "To", "Cc", "Bcc"]:
            header_content = msg.get(header)
            if header_content:
                # Utilise une regex pour extraire les adresses e-mail
                emails.update(
                    re.findall(
                        r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b",
                        header_content,
                    )
                )

        # Analyse le contenu du corps de l'e-mail pour les adresses
        if msg.is_multipart():
            for part in msg.walk():
                if part.get_content_type() == "text/plain":
                    part_content = part.get_payload(decode=True).decode(errors="ignore")
                    emails.update(
                        re.findall(
                            r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b",
                            part_content,
                        )
                    )
        else:
            content = msg.get_payload(decode=True).decode(errors="ignore")
            emails.update(
                re.findall(
                    r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b", content
                )
            )

    # Retourne les e-mails en minuscules pour éviter les doublons insensibles à la casse
    return {email.lower() for email in emails}


# Fonction principale pour parcourir le répertoire et extraire les adresses e-mail
def extract_emails_from_directory(directory_path, output_file="mail.txt"):
    all_emails = set()
    # Définit la regex pour correspondre aux UUID
    uuid_regex = re.compile(
        r"\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b"
    )

    # Parcourt tous les fichiers .eml du répertoire
    for filename in os.listdir(directory_path):
        if filename.endswith(".eml"):
            file_path = os.path.join(directory_path, filename)
            extracted_emails = extract_emails_from_eml(file_path)
            # Filtre les e-mails qui ne contiennent pas d'UUID et les ajoute à l'ensemble
            for email in extracted_emails:
                if not uuid_regex.search(email):
                    all_emails.add(email)

    # Écrit les adresses e-mail filtrées dans le fichier de sortie
    with open(output_file, "w") as f:
        for email in sorted(all_emails):
            f.write(email + "\n")


# Vérifie si les chemins du dossier et du fichier de sortie sont passés en argument
if len(sys.argv) == 3:
    directory_path = sys.argv[1]
    output_file = sys.argv[2]
    extract_emails_from_directory(directory_path, output_file)
    print(
        f"Extraction terminée. Les adresses e-mail sans UUID sont stockées dans '{output_file}'."
    )
else:
    print(
        "Utilisation : python extract-emails.py <chemin_du_dossier_emails> <chemin_du_fichier_en_sortie>"
    )
