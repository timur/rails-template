//= require_directory ../../../vendor/javascripts

window.Prism = Prism;

document.addEventListener("turbo:load", function() {
  Prism.highlightAll();
});