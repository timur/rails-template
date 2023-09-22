import { render } from "react-dom";
import { useState } from "react";
import h from "components/htm_create_element";
import Gallery from "components/gallery";

export default function Wrapper() {
  const [layout, setLayout] = useState("rows");
  const node = document.getElementById("photos");
  const photos = JSON.parse(node.getAttribute("data"));

  const handleClick = (layout) => {
    setLayout(layout);
  };

  return h`
  <div class="space-x-2 mb-2">
  <button class="btn btn-blue" onClick="${() =>
    handleClick("masonry")}">Masonry</button>

  <button class="btn btn-blue" onClick="${() =>
    handleClick("rows")}">Rows</button>

  <button class="btn btn-blue" onClick="${() =>
    handleClick("columns")}">Columns</button>
    </div>
  
  <${Gallery} photos=${photos} layout="${layout}"/><div>1</div>`;
}

document.addEventListener("DOMContentLoaded", () => {
  render(h`<${Wrapper} />`, document.getElementById("root"));
});
