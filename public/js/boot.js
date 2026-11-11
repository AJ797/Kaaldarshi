/* Parser-blocking and external, so it runs before first paint without needing
   an inline-script hash in the CSP. Its only job is to tell the stylesheet
   that JavaScript is available, so progressive-enhancement states can hide
   themselves without ever hiding content from a no-JS visitor. */
document.documentElement.classList.add('js');
