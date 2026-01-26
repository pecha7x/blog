// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// import "trix"
import "lexxy"
import "@rails/actiontext"

// Function to re-initialize Preline and another components
const init = () => {
  setTimeout(() => {
    window.scroll({ top: -1, left: 0, behavior: "smooth" });
  }, 10); 

  if (window.HSStaticMethods) {
    window.HSStaticMethods.autoInit();
  }
};

// Re-initialize Preline after different Turbo events
document.addEventListener("turbo:load", init); // For full page loads
document.addEventListener("turbo:render", init); // For Turbo Frame/Stream renders
document.addEventListener("turbo:after-stream-render", init); // Another hook for Turbo Streams
