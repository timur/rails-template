import { useState } from "react";
import PhotoAlbum from "react-photo-album";
import Lightbox from "yet-another-react-lightbox";
import Fullscreen from "yet-another-react-lightbox/plugins/fullscreen";
import Slideshow from "yet-another-react-lightbox/plugins/slideshow";
import Thumbnails from "yet-another-react-lightbox/plugins/thumbnails";
import Zoom from "yet-another-react-lightbox/plugins/zoom";
import h from "components/htm_create_element";

export default function Gallery({ photos, layout }) {
  const [index, setIndex] = useState(-1);

  return h`<${PhotoAlbum} layout="${layout}" spacing="5" photos="${photos}" onClick=${({
    index,
  }) => setIndex(index)}  />
    <${Lightbox}
      slides=${photos}
      open=${index >= 0}
      index=${index}
      close=${() => setIndex(-1)}
      plugins=${[Fullscreen, Slideshow, Thumbnails, Zoom]}
    />`;
}
