import sys
import time
import subprocess
from datetime import datetime, timezone, timedelta

from zoneinfo import ZoneInfo

# Définit des couleurs pour l'affichage
BLANC = "\033[0;37m"
BLEU = "\033[0;34m"
CYAN = "\033[0;36m"
JAUNE = "\033[0;33m"
MAGENTA = "\033[1;95m"
ROUGE = "\033[0;31m"
VERT = "\033[0;32m"
RESET = "\033[0m"

# Vérifie si au moins une clef a été fournie
if len(sys.argv) < 2:
    print(f"{ROUGE}Usage: {sys.argv[0]} clef1 [clef2 ... clefN]{RESET}")
    sys.exit(1)


# Formate un jeton en groupes de 3 caractères
def format_jeton(jeton):
    return f"{jeton[:3]} {jeton[3:6]}"


for cle_secrete in sys.argv[1:]:
    resultats = []

    resultats.append(f"{BLEU}Clef : {MAGENTA}{cle_secrete}{RESET}")
    resultats.append(f"{JAUNE}Date       | Jeton{RESET}")
    resultats.append(f"{CYAN}--------------------------------{RESET}")

    temps_unix = int(time.time())
    date_immediate = datetime.fromtimestamp(temps_unix, tz=timezone.utc).strftime(
        "%Y-%m-%d %H:%M:%S UTC"
    )

    heure_paris = datetime.fromtimestamp(
        temps_unix, tz=ZoneInfo("Europe/Paris")
    ).strftime("%H:%M:%S")

    try:
        jeton = subprocess.check_output(
            ["oathtool", "--totp", "-b", "--now", date_immediate, cle_secrete],
            text=True,
        ).strip()
    except subprocess.CalledProcessError:
        print(
            f"{ROUGE}Erreur : Impossible de générer le jeton pour la clef {cle_secrete}{RESET}"
        )
        continue

    jeton_format = format_jeton(jeton)

    resultats.append(
        f"{BLANC}{heure_paris}{RESET} {ROUGE}*{RESET} | {VERT}{jeton_format}{RESET} | {VERT}{jeton}{RESET} {ROUGE}*{RESET}"
    )

    # Génère 5 jetons
    for i in range(1, 5):
        heure_paris_arrondie = temps_unix // 30 * 30 + i * 30
        date_courante = datetime.fromtimestamp(
            heure_paris_arrondie, tz=timezone.utc
        ).strftime("%Y-%m-%d %H:%M:%S UTC")

        heure_paris = datetime.fromtimestamp(
            heure_paris_arrondie, tz=ZoneInfo("Europe/Paris")
        ).strftime("%H:%M:%S")

        try:
            jeton = subprocess.check_output(
                ["oathtool", "--totp", "-b", "--now", date_courante, cle_secrete],
                text=True,
            ).strip()
        except subprocess.CalledProcessError:
            print(
                f"{ROUGE}Erreur : Impossible de générer le jeton pour la clef {cle_secrete}{RESET}"
            )
            break

        jeton_format = format_jeton(jeton)

        resultats.append(
            f"{BLANC}{heure_paris}{RESET}   | {VERT}{jeton_format}{RESET} | {VERT}{jeton}{RESET}"
        )

    # Affiche les résultats
    for ligne in resultats:
        print(ligne)

    # Sépare les résultats pour chaque clef
    print(f"{CYAN}--------------------------------{RESET}")
