/* Backup: set src on any remaining data-src images after Reveal starts */
(function () {
  function wireAll() {
    document.querySelectorAll(".reveal img[data-src]").forEach((img) => {
      const path = img.getAttribute("data-src");
      if (path) {
        img.setAttribute("src", path);
        img.removeAttribute("data-src");
      }
    });
  }

  function hook() {
    if (typeof Reveal === "undefined" || typeof Reveal.on !== "function") {
      setTimeout(hook, 50);
      return;
    }
    Reveal.on("ready", wireAll);
    Reveal.on("slidechanged", wireAll);
    wireAll();
  }

  hook();
  window.addEventListener("load", wireAll);
})();
