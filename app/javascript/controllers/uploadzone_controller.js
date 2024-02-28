import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";
import { post } from "@rails/request.js";

const preloadImage = url => {
  return new Promise((resolve, reject) => {
    const image = new Image();
    image.src = url;
    image.onload = resolve;
    image.onerror = reject;
  });
};

class Upload {
  constructor(file) {
    this.directUpload = new DirectUpload(file, "/rails/active_storage/direct_uploads", this);
  }

  process() {
    this.insertUpload();
    this.insertImage();

    this.directUpload.create(async (error, blob) => {
      if (error) {
        // Handle the error
      } else {
        const pictureData = { picture: { filename: blob.filename }, signed_blob_id: blob.signed_id };
        const response = await post("/examples/upload/picture", {
          body: pictureData,
          contentType: "application/json",
          responseKind: "json"
        });

        if (response.ok) {
          const responseJSON = await response.json;
          const imageDiv = document.querySelector(`#image_${this.directUpload.id}`);
          
          const iElements = imageDiv.querySelectorAll('i');
          iElements.forEach((iElement) => iElement.remove());
          
          preloadImage(responseJSON.thumb).then( (entry) => {
            this.applyImage(entry.target, responseJSON.thumb, imageDiv);
          });
        }
      }
    });
  }

  applyImage (img, src, div) {
    // Prevent this from being lazy loaded a second time.
    const width = img.width;
    const height = img.height;
    const w = width * 200 / height;
    const fg = width * 200 / height;

    div.style = `width:${w}px;flex-grow:${fg}`;

    const i = document.createElement("i");
    const ratio = (height / width) * 100;
    i.style = `padding-bottom:${ratio}%`;
    div.appendChild(i);

    img.classList.add('img-gallery');
    img.src = src;
    img.classList.add('lazy-load');
    div.appendChild(img);
  }

  insertUpload() {
    const fileUpload = document.createElement("div");

    fileUpload.id = `upload_${this.directUpload.id}`;
    fileUpload.className = "p-1 text-sm mb-2";
    fileUpload.textContent = this.directUpload.file.name;

    const progressWrapper = document.createElement("div");
    progressWrapper.className = "relative h-3 overflow-hidden rounded-full bg-secondary w-[100%]";
    fileUpload.appendChild(progressWrapper);

    const progressBar = document.createElement("div");
    progressBar.className = "progress h-full w-full flex-1 bg-green-500";
    progressBar.style = "transform: translateX(-100%);";
    progressWrapper.appendChild(progressBar);

    const uploadList = document.querySelector("#uploads");
    uploadList.appendChild(fileUpload);
  }

  insertImage() {
    const imageDiv = document.createElement("div");
    imageDiv.id = `image_${this.directUpload.id}`;
    imageDiv.style = "width:133px;flex-grow:133";
    const i = document.createElement("i");
    i.style = "padding-bottom:150%";
    
    imageDiv.appendChild(i);

    const grid = document.querySelector("#grid");
    grid.prepend(imageDiv);
  }

  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress", (event) => this.updateProgress(event));
    request.upload.addEventListener("loadend", event => {
      const id = `upload_${this.directUpload.id}`;
      document.getElementById(id).remove();
      const uploadList = document.querySelector("#uploads");
      if (uploadList.children.length === 0) {
        Alpine.store('uploadModal').toggle();
      }
    })
  }

  updateProgress(event) {
    const percentage = (event.loaded / event.total) * 100;
    const progress = document.querySelector(`#upload_${this.directUpload.id} .progress`);
    progress.style.transform = `translateX(-${100 - percentage}%)`;
  }
}

export default class extends Controller {
  static targets = ["fileInput"];

  connect() {
    this.element.addEventListener("dragover", this.preventDragDefaults);
    this.element.addEventListener("dragenter", this.preventDragDefaults);
  }

  disconnect() {
    this.element.removeEventListener("dragover", this.preventDragDefaults);
    this.element.removeEventListener("dragenter", this.preventDragDefaults);
  }

  preventDragDefaults(e) {
    e.preventDefault();
    e.stopPropagation();
  }

  trigger() {
    this.fileInputTarget.click();
  }

  acceptFiles(event) {
    Alpine.store('uploadModal').toggle();
    event.preventDefault();
    const files = event.dataTransfer ? event.dataTransfer.files : event.target.files;
    [...files].forEach((f) => {
      new Upload(f).process();
    });
  }
}
