document.addEventListener("DOMContentLoaded", function() {
  const content = document.getElementById("content");
  const expandButton = document.getElementById("expand-button");

  const maxHeight = content.clientHeight;

  expandButton.addEventListener("click", function() {
      if (content.style.maxHeight === "") {
          content.style.maxHeight = maxHeight + "20px";
          expandButton.textContent = "Ver menos";
      } else {
          content.style.maxHeight = "";
          expandButton.textContent = "Ver más";
      }
  });
});