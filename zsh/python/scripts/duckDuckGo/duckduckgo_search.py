#!/usr/bin/env python3

import argparse
import asyncio
from duckduckgo_search import AsyncDDGS
from icecream import ic
from colorama import init, Fore, Style

# colorama pour gérer les couleurs sur tous les OS
init(autoreset=True)

ic.configureOutput(includeContext=False, contextAbsPath=False)

async def recherche_duckduckgo(terme_recherche, nombre_resultats):
    async with AsyncDDGS(proxy=None) as ddgs:
        resultats = await ddgs.atext(
            terme_recherche,
            max_results=nombre_resultats,
            safesearch="off",
            region="fr-fr",
        )

    # Résultats trouvés
    if resultats:
        for i, resultat in enumerate(list(reversed(resultats)), start=1):
            # print(Fore.CYAN + f"Résultat {i} :")
            print(Fore.CYAN + f"Résultat {len(resultats) - i + 1} :")
            print(Fore.GREEN + f"Titre : {resultat['title']}")
            print(Fore.YELLOW + f"Description : {resultat['body']}")
            print(Fore.MAGENTA + f"Lien : {resultat['href']}\n")
    else:
        print("Aucun résultat trouvé.")


async def chat_ai_duckduckgo(
    keywords: str, model: str = "gpt-4o-mini", timeout: int = 30
):
    print(f"{Fore.BLUE}Chat mode activé avec le modèle : {model}")
    print(f"{Fore.BLUE}Mots-clés reçus : {keywords}")
    async with AsyncDDGS(proxy=None) as ddgs:
        resultat = await ddgs.achat(keywords, model, timeout)

    if resultat:
        print(Fore.GREEN + f"Résultat brut :\n")
        print(Style.RESET_ALL + Fore.WHITE + f"{resultat}")
    else:
        print(Style.RESET_ALL + "Aucun résultat trouvé.")


async def main():
    # Crée un analyseur d'arguments pour la CLI
    parser = argparse.ArgumentParser(
        description="Wrapper CLI pour DuckDuckGo"
    )
    parser.add_argument(
        "query", type=str, help="Le terme de recherche ou la question pour le chat AI"
    )
    parser.add_argument(
        "-n",
        "--nombre",
        type=int,
        default=3,
        help="Le nombre de résultats à afficher (par défaut : 3)",
    )
    parser.add_argument(
        "--chat", action="store_true", help="Active le mode chat AI"
    )

    # Analyse les arguments fournis par l'utilisateur
    args = parser.parse_args()

    # Si le mode chat est activé, utilise la fonction de chat
    if args.chat:
        await chat_ai_duckduckgo(args.query)
    else:
        # Sinon, lance la recherche normale
        await recherche_duckduckgo(args.query, args.nombre)


if __name__ == "__main__":
    # Exécute le programme asynchrone
    asyncio.run(main())

