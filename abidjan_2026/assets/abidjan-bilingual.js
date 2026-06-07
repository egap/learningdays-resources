/* Language focus toggle for Abidjan bilingual slides.
   Keys: B = both, E = English only, F = French only */

(function () {
  const MODES = ["lang-mode-both", "lang-mode-en", "lang-mode-fr"];

  function setMode(mode) {
    document.body.classList.remove(...MODES);
    if (mode === "en") document.body.classList.add("lang-mode-en");
    else if (mode === "fr") document.body.classList.add("lang-mode-fr");
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
      <button type="button" data-lang="both" title="Both (B)">Both</button>
      <button type="button" data-lang="en" title="English only (E)">EN</button>
      <button type="button" data-lang="fr" title="French only (F)">FR</button>
    `;
    bar.querySelectorAll("button").forEach((btn) => {
      btn.addEventListener("click", () => setMode(btn.dataset.lang));
    });
    document.body.appendChild(bar);
  }

  document.addEventListener("keydown", (e) => {
    if (e.target.matches("input, textarea")) return;
    const k = e.key.toLowerCase();
    if (k === "b") setMode("both");
    if (k === "e") setMode("en");
    if (k === "f") setMode("fr");
  });

  function transformTitleSlide() {
    const slide = document.getElementById("title-slide");
    const h1 = slide?.querySelector("h1.title");
    if (!slide || !h1 || slide.dataset.bilingualTitle === "1") return;

    const html = h1.innerHTML;
    const idx = html.indexOf("|");
    if (idx === -1) return;

    const en = html.slice(0, idx).trim();
    const fr = html.slice(idx + 1).trim();
    if (!en || !fr) return;

    const wrap = document.createElement("div");
    wrap.className = "deck-title-bilingual";

    const enLine = document.createElement("div");
    enLine.className = "deck-title-line lang-en bilingual-title-text";
    enLine.innerHTML = en;

    const frLine = document.createElement("div");
    frLine.className = "deck-title-line lang-fr bilingual-title-text";
    frLine.innerHTML = fr;

    wrap.append(enLine, frLine);
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
