import { render } from "react-dom";
import h from "components/htm_create_element";

import Gallery from "components/gallery";

render(
  h`<${Gallery} />
    <div>1</div>`,
  document.getElementById("root")
);
