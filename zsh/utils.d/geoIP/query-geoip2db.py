import sys
import geoip2.database
from icecream import ic

ic.configureOutput(includeContext=True)


def query_ip(db_path, ip_address):
    try:
        # Charge la base de données
        reader = geoip2.database.Reader(db_path)

        # Interroge la base de données pour l'adresse IP
        response = reader.city(ip_address)
        ic(response)

    except Exception as e:
        print(
            f"Erreur lors de la lecture de la base de données ou de l'interrogation : {e}"
        )
    finally:

        reader.close()


if __name__ == "__main__":

    if len(sys.argv) != 3:
        print(
            "Utilisation : python script.py <chemin_vers_DBIP-City.mmdb> <adresse_IP>"
        )
        sys.exit(1)

    db_path = sys.argv[1]
    ip_address = sys.argv[2]

    query_ip(db_path, ip_address)
