# Language helpers for PDF / book exports (plots + bilingual labels).

abidjan_lang <- function() {
  lang <- tolower(trimws(Sys.getenv("ABIDJAN_LANG", "both")))
  if (lang %in% c("en", "fr")) {
    return(lang)
  }
  "both"
}

deck_lang <- function() {
  abidjan_lang()
}

pick_lang <- function(en, fr) {
  lang <- abidjan_lang()
  if (lang == "fr") {
    return(fr)
  }
  en
}

pick_lang_pair <- function(en, fr) {
  lang <- abidjan_lang()
  if (lang == "en") {
    return(list(en = en, fr = NULL))
  }
  if (lang == "fr") {
    return(list(en = NULL, fr = fr))
  }
  list(en = en, fr = fr)
}
