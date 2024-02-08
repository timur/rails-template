import "@hotwired/turbo-rails"
import "./controllers"

addEventListener("turbo:before-fetch-request", (event) => {
  const headers = event.detail.fetchOptions.headers;
  console.log("before-fetch-request", headers);
});

addEventListener("turbo:frame-missing", (event) => {
  const { detail: { response, visit } } = event;
  console.log("frame-missing", response, visit);
});