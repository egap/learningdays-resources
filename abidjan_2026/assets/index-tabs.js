/**
 * Index page: language toggle (top-left) + bookmarkable section tabs.
 *
 * Hash paths: index.html#en/slides , index.html#fr/programme/mercredi
 */
(function () {
  "use strict";

  var LANG_PANELS = {
    en: "index-lang-en",
    fr: "index-lang-fr",
  };

  var SECTION_MAP = {
    en: {
      slides: "slides",
      quiz: "quiz",
      resources: "resources",
      schedule: "schedule",
      instructors: "instructors",
    },
    fr: {
      slides: "diapos",
      quiz: "quiz",
      resources: "ressources",
      schedule: "programme",
      instructors: "instructeurs",
    },
  };

  var DAY_MAP = {
    en: ["monday", "tuesday", "wednesday", "thursday", "friday"],
    fr: ["lundi", "mardi", "mercredi", "jeudi", "vendredi"],
  };

  function slugify(text) {
    return text
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-+|-+$/g, "");
  }

  function tabLinkLabel(link) {
    var clone = link.cloneNode(true);
    clone.querySelectorAll("img").forEach(function (img) {
      img.remove();
    });
    return clone.textContent.replace(/\s+/g, " ").trim();
  }

  function panelTabsetInPane(pane) {
    if (!pane) {
      return null;
    }
    return pane.querySelector(".panel-tabset");
  }

  function setLanguage(lang, options) {
    options = options || {};
    var panelId = LANG_PANELS[lang];
    if (!panelId) {
      return;
    }

    document.querySelectorAll(".index-lang-panel").forEach(function (panel) {
      panel.classList.toggle("is-active", panel.id === panelId);
    });

    document.querySelectorAll(".index-lang-switch .lang-opt").forEach(function (btn) {
      var active = btn.dataset.lang === lang;
      btn.classList.toggle("is-active", active);
      btn.setAttribute("aria-pressed", active ? "true" : "false");
    });

    if (!options.skipHash && options.tabPath) {
      var target = "#" + options.tabPath;
      if (window.location.hash !== target) {
        history.replaceState(null, "", target);
      }
    }
  }

  function translatePath(path, fromLang, toLang) {
    if (!path) {
      return toLang + "/" + SECTION_MAP[toLang].slides;
    }

    var parts = path.split("/").filter(Boolean);
    if (!parts.length) {
      return toLang + "/" + SECTION_MAP[toLang].slides;
    }

    if (parts[0] === fromLang) {
      parts.shift();
    }

    var sectionKey = null;
    var enSections = SECTION_MAP.en;
    var frSections = SECTION_MAP.fr;
    var i;
    for (i = 0; i < parts.length; i++) {
      var slug = parts[i];
      Object.keys(enSections).forEach(function (key) {
        if (enSections[key] === slug || frSections[key] === slug) {
          sectionKey = key;
        }
      });
      if (sectionKey) {
        break;
      }
    }

    var dayIndex = -1;
    if (sectionKey === "schedule" && parts.length > i + 1) {
      dayIndex = DAY_MAP[fromLang].indexOf(parts[i + 1]);
      if (dayIndex < 0) {
        dayIndex = DAY_MAP[toLang].indexOf(parts[i + 1]);
      }
    }

    var out = [toLang];
    if (sectionKey) {
      out.push(SECTION_MAP[toLang][sectionKey]);
      if (dayIndex >= 0) {
        out.push(DAY_MAP[toLang][dayIndex]);
      }
    } else if (parts.length) {
      out = out.concat(parts);
    } else {
      out.push(SECTION_MAP[toLang].slides);
    }

    return out.join("/");
  }

  function initLangSwitch() {
    document.querySelectorAll(".index-lang-switch .lang-opt").forEach(function (btn) {
      btn.addEventListener("click", function () {
        var lang = btn.dataset.lang;
        var currentPath = window.location.hash.replace(/^#/, "");
        var currentLang = currentPath.split("/")[0] || "en";
        var newPath = translatePath(currentPath, currentLang, lang);
        setLanguage(lang, { tabPath: newPath, skipHash: true });
        activateTabPath(newPath);
        history.replaceState(null, "", "#" + newPath);
      });
    });
  }

  function initTabset(tabset, parentPath) {
    var links = tabset.querySelectorAll(":scope > .nav-tabs > .nav-item > .nav-link");
    links.forEach(function (link) {
      var slug = slugify(tabLinkLabel(link));
      var path = parentPath + "/" + slug;

      link.dataset.tabSlug = slug;
      link.dataset.tabPath = path;
      link.setAttribute("href", "#" + path);

      link.addEventListener("shown.bs.tab", function () {
        var lang = parentPath.split("/")[0];
        setLanguage(lang, { tabPath: path, skipHash: true });
        if (window.location.hash !== "#" + path) {
          history.replaceState(null, "", "#" + path);
        }
      });

      var pane = document.querySelector(link.getAttribute("data-bs-target"));
      var childTabset = panelTabsetInPane(pane);
      if (childTabset) {
        initTabset(childTabset, path);
      }
    });
  }

  function initLanguagePanels() {
    Object.keys(LANG_PANELS).forEach(function (lang) {
      var panel = document.getElementById(LANG_PANELS[lang]);
      if (!panel) {
        return;
      }
      var mainTabs = panel.querySelector(".index-main-tabs");
      if (mainTabs) {
        initTabset(mainTabs, lang);
      }
    });
  }

  function activateTabPath(path) {
    if (!path || !window.bootstrap) {
      return;
    }

    var parts = path.split("/").filter(Boolean);
    if (!parts.length) {
      return;
    }

    var lang = parts[0];
    setLanguage(lang, { skipHash: true });

    var panel = document.getElementById(LANG_PANELS[lang]);
    if (!panel) {
      return;
    }

    var tabset = panel.querySelector(".index-main-tabs");
    if (!tabset) {
      return;
    }

    for (var i = 1; i < parts.length; i++) {
      var slug = parts[i];
      var link = tabset.querySelector(
        ':scope > .nav-tabs > .nav-item > .nav-link[data-tab-slug="' + slug + '"]'
      );
      if (!link) {
        break;
      }
      window.bootstrap.Tab.getOrCreateInstance(link).show();
      var pane = document.querySelector(link.getAttribute("data-bs-target"));
      tabset = panelTabsetInPane(pane);
      if (!tabset) {
        break;
      }
    }
  }

  function applyHashFromUrl() {
    var path = decodeURIComponent(window.location.hash.replace(/^#/, ""));
    if (path) {
      activateTabPath(path);
    } else {
      setLanguage("en", { tabPath: "en/slides", skipHash: true });
    }
  }

  function init() {
    document.body.classList.add("index-page");
    initLangSwitch();
    initLanguagePanels();
    applyHashFromUrl();
    window.addEventListener("hashchange", applyHashFromUrl);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
