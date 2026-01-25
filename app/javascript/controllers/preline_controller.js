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
