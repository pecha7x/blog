// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// import "trix"
import "lexxy"
import "@rails/actiontext"

// Function to re-initialize Preline components
const initPreline = () => {
  if (window.HSStaticMethods) {
    window.HSStaticMethods.autoInit();
  }
};

// Re-initialize Preline after different Turbo events
document.addEventListener("turbo:load", initPreline); // For full page loads
document.addEventListener("turbo:render", initPreline); // For Turbo Frame/Stream renders
document.addEventListener("turbo:after-stream-render", initPreline); // Another hook for Turbo Streams

window.onbeforeunload = function () {
  console.log("scrollTo(0, 0);");
  window.scrollTo(0, 0);
}
