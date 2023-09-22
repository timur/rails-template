import { render } from "react-dom";
import { useState } from "react";
import h from "components/htm_create_element";
import Gallery from "components/gallery";

export default function Wrapper() {
  const [layout, setLayout] = useState("rows");
  const node = document.getElementById("photos");
  const photos = JSON.parse(node.getAttribute("data"));

  const handleClick = () => {
    if (layout === "rows") {
      setLayout("columns");
    } else {
      setLayout("rows");
    }
  };

  return h`<button class="btn btn-blue" onClick="${handleClick}">Change Layout</button><${Gallery} photos=${photos} layout="${layout}"/><div>1</div>`;
}

document.addEventListener("DOMContentLoaded", () => {
  render(h`<${Wrapper} />`, document.getElementById("root"));
});
