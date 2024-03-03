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
    this.insertSpinner();

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
          const divLoader = document.querySelector(`#image_${this.directUpload.id}`);
          
          const iElements = divLoader.querySelectorAll('i');
          iElements.forEach((iElement) => iElement.remove());
          
          preloadImage(responseJSON.thumb).then( (entry) => {
            this.applyImage(entry.target, responseJSON.thumb, responseJSON.large, divLoader);
          });
        }
      }
    });
  }

  applyImage (img, thumb, large, divLoader) {
    const link = document.createElement("a");
    link.href = large;
    link.setAttribute('data-src', large);
    link.setAttribute('data-lightbox-target', "images");
    // Prevent this from being lazy loaded a second time.
    const width = img.width;
    const height = img.height;
    const w = width * 200 / height;
    const fg = width * 200 / height;

    link.style = `width:${w}px;flex-grow:${fg}`;
    link.className = "block relative m-1";

    const i = document.createElement("i");
    const ratio = (height / width) * 100;
    i.style = `padding-bottom:${ratio}%`;
    i.classList.add('block');

    divLoader.remove();
    link.appendChild(i);

    img.classList.add('img-gallery');
    img.src = thumb;
    img.classList.add('lazy-load');
    link.appendChild(img);
    const grid = document.querySelector("#grid");
    grid.appendChild(link);

    const uploadFinished = new CustomEvent("file-uploaded", { detail: { id: this.directUpload.id } });
    window.dispatchEvent(uploadFinished);

  }

  /** Insert upload in popup progress bar */
  insertUpload() {
    const fileUpload = document.createElement("div");

    fileUpload.id = `upload_${this.directUpload.id}`;
    fileUpload.className = "p-1 text-xs mb-2";
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

  insertSpinner() {
    const imageDiv = document.createElement("div");
    imageDiv.className = "relative";
    imageDiv.id = `image_${this.directUpload.id}`;
    imageDiv.style = "width:133px;flex-grow:133";

    /** Spinner temp */
    const i = document.createElement("i");
    i.style = "padding-bottom:150%";
    i.className = 'block bg-blue-50';
    const innerHTMLContent = `
      <div class="absolute top-1/2 start-1/2 transform -translate-x-1/2 -translate-y-1/2">
        <div class="animate-spin inline-block size-6 border-[3px] border-current border-t-transparent text-blue-600 rounded-full dark:text-blue-500" role="status" aria-label="loading">
          <span class="sr-only">Loading...</span>
        </div>
      </div>`;
    i.innerHTML = innerHTMLContent;    
    
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
  totalUploads = 0;
  totalUploaded = 0;

  connect() {
    this.totalUploads = 0;
    this.element.addEventListener("dragover", this.preventDragDefaults);
    this.element.addEventListener("dragenter", this.preventDragDefaults);
  }

  disconnect() {
    this.element.removeEventListener("dragover", this.preventDragDefaults);
    this.element.removeEventListener("dragenter", this.preventDragDefaults);
    this.totalUploads = 0;
  }

  preventDragDefaults(e) {
    e.preventDefault();
    e.stopPropagation();
  }

  trigger() {
    this.fileInputTarget.click();
  }

  uploaded(e) {
    this.totalUploaded++;

    if (this.totalUploaded === this.totalUploads) {
      const trigger = new CustomEvent("refresh-lightbox");
      window.dispatchEvent(trigger);
      this.totalUploaded = 0;
      this.totalUploads = 0;
    }
  }

  acceptFiles(event) {
    Alpine.store('uploadModal').toggle();
    event.preventDefault();
    const files = event.dataTransfer ? event.dataTransfer.files : event.target.files;
    this.totalUploads = files.length;
    [...files].forEach((f) => {
      new Upload(f).process();
    });
  }
}
