/* Language focus toggle for Santiago bilingual slides.
   Keys: Alt+B = both, Alt+S = Spanish only, Alt+E = English only.
   (Alt is required because reveal.js binds bare B to blackout and bare S to
   the speaker-notes window.)
   Title-slide convention: "Titulo en espanol | English title". */

(function () {
  const MODES = ["lang-mode-both", "lang-mode-es", "lang-mode-en"];

  function setMode(mode) {
    document.body.classList.remove(...MODES);
    if (mode === "es") document.body.classList.add("lang-mode-es");
    else if (mode === "en") document.body.classList.add("lang-mode-en");
    else document.body.classList.add("lang-mode-both");

    document.querySelectorAll("#lang-toolbar button").forEach((btn) => {
      btn.classList.toggle("active", btn.dataset.lang === (mode === "both" ? "both" : mode));
    });
  }

  function toolbar() {
    if (document.getElementById("lang-toolbar")) return;
    const bar = document.createElement("div");
    bar.id = "lang-toolbar";
    bar.innerHTML = `
      <button type="button" data-lang="both" title="Ambos (Alt+B)">Ambos</button>
      <button type="button" data-lang="es" title="Solo espa&ntilde;ol (Alt+S)">ES</button>
      <button type="button" data-lang="en" title="English only (Alt+E)">EN</button>
    `;
    bar.querySelectorAll("button").forEach((btn) => {
      btn.addEventListener("click", () => setMode(btn.dataset.lang));
    });
    document.body.appendChild(bar);
  }

  document.addEventListener("keydown", (e) => {
    if (e.target.matches("input, textarea")) return;
    if (!e.altKey || e.ctrlKey || e.metaKey) return;
    const k = e.code;
    if (k === "KeyB") { setMode("both"); e.preventDefault(); }
    if (k === "KeyS") { setMode("es"); e.preventDefault(); }
    if (k === "KeyE") { setMode("en"); e.preventDefault(); }
  });

  function transformTitleSlide() {
    const slide = document.getElementById("title-slide");
    const h1 = slide?.querySelector("h1.title");
    if (!slide || !h1 || slide.dataset.bilingualTitle === "1") return;

    const html = h1.innerHTML;
    const idx = html.indexOf("|");
    if (idx === -1) return;

    const es = html.slice(0, idx).trim();
    const en = html.slice(idx + 1).trim();
    if (!es || !en) return;

    const wrap = document.createElement("div");
    wrap.className = "deck-title-bilingual";

    const esLine = document.createElement("div");
    esLine.className = "deck-title-line lang-es bilingual-title-text";
    esLine.innerHTML = es;

    const enLine = document.createElement("div");
    enLine.className = "deck-title-line lang-en bilingual-title-text";
    enLine.innerHTML = en;

    wrap.append(esLine, enLine);
    h1.replaceWith(wrap);
    slide.classList.add("deck-title-slide");
    slide.dataset.bilingualTitle = "1";
  }

  function fixPoGraphLayout() {
    const slideSelectors = [
      "section.po-graph-slide",
      "#potential-outcomes-why-randomization-works",
      "#potential-outcomes-heterogeneous-effects",
      "#potential-outcomes-a-bad-randomization",
    ];

    slideSelectors.forEach((sel) => {
      document.querySelectorAll(sel).forEach((slide) => {
        const display = slide.querySelector(".cell-output-display");
        if (!display) return;

        display.style.setProperty("display", "block", "important");
        display.style.setProperty("text-align", "center", "important");

        display.querySelectorAll("p").forEach((p) => {
          p.style.setProperty("display", "block", "important");
          p.style.setProperty("width", "100%", "important");
          p.style.setProperty("margin", "0", "important");
          p.style.setProperty("text-align", "center", "important");
        });
      });
    });
  }

  document.addEventListener("DOMContentLoaded", () => {
    toolbar();
    transformTitleSlide();
    fixPoGraphLayout();
    setMode("both");
    if (typeof Reveal !== "undefined" && Reveal.on) {
      Reveal.on("ready", fixPoGraphLayout);
      Reveal.on("slidechanged", fixPoGraphLayout);
    }
  });

  window.addEventListener("load", fixPoGraphLayout);
  window.addEventListener("resize", fixPoGraphLayout);
})();
