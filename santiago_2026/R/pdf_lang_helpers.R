# Language helpers for PDF / single-language exports (plots + bilingual labels).
# Spanish is the primary language for Santiago 2026.

santiago_lang <- function() {
  lang <- tolower(trimws(Sys.getenv("SANTIAGO_LANG", "both")))
  if (lang %in% c("es", "en")) {
    return(lang)
  }
  "both"
}

deck_lang <- function() {
  santiago_lang()
}

pick_lang <- function(es, en) {
  lang <- santiago_lang()
  if (lang == "en") {
    return(en)
  }
  es
}

pick_lang_pair <- function(es, en) {
  lang <- santiago_lang()
  if (lang == "es") {
    return(list(es = es, en = NULL))
  }
  if (lang == "en") {
    return(list(es = NULL, en = en))
  }
  list(es = es, en = en)
}
