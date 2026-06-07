"""Strip HTML comments and apply minimal fixes to an Abidjan qmd."""
import re
import sys
from pathlib import Path

def main():
    path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).parents[1] / "1_causalinference-slides-en-fr.qmd"
    text = path.read_text(encoding="utf-8")
    text = re.sub(r"<!--.*?-->\s*", "", text, flags=re.DOTALL)
    text = re.sub(r"^  ```\s*$", "```", text, flags=re.MULTILINE)
    old = "Average treatment effect / l'effet moyen du traitement (ATE):"
    new = """::: {.columns}
::: {.column width="49%" .lang-en}

Average treatment effect (ATE):

:::
::: {.column width="49%" .lang-fr}

L'effet moyen du traitement (ATE) :

:::
:::

"""
    text = text.replace(old, new)
    path.write_text(text, encoding="utf-8")
    print(f"Cleaned {path}")

if __name__ == "__main__":
    main()
