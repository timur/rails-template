import { render } from "react-dom";
import h from "components/htm_create_element";

import Gallery from "components/gallery";

document.addEventListener("DOMContentLoaded", () => {
  const node = document.getElementById("photos");
  const photos = JSON.parse(node.getAttribute("data"));

  render(
    h`<${Gallery} photos=${photos}/>
      <div>1</div>`,
    document.getElementById("root")
  );
});
