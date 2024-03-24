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

function bytesToSize(bytes) {
  const units = ['byte', 'kilobyte', 'megabyte', 'gigabyte', 'terabyte'];

  const navigatorLocal = navigator.languages && navigator.languages.length >= 0 ? navigator.languages[0] : 'en-US'
  const unitIndex      = Math.max(0, Math.min(Math.floor(Math.log(bytes) / Math.log(1024)), units.length - 1));

  return Intl.NumberFormat(navigatorLocal, {
    style: 'unit',
    unit : units[unitIndex]
  }).format(bytes / (1024 ** unitIndex))
}

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
        console.error(error);
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

          // load the image from imagekit to get the width and height, because the metadata job wont't be done yet
          preloadImage(responseJSON.thumb).then( (entry) => {
            this.applyImage(entry.target, responseJSON.id, divLoader);
          });
        }
      }
    });
  }

  async applyImage (img, id, divLoader) {
    const grid = document.querySelector("#grid");

    fetch(`/pictures/${id}/render_picture?width=${img.width}&height=${img.height}`)
      .then((r) => r.text())
      .then((html) => {
        const fragment = document
          .createRange()
          .createContextualFragment(html);

        divLoader.remove();
        grid.appendChild(fragment);
        const uploadFinished = new CustomEvent("file-uploaded", { detail: { id: this.directUpload.id } });
        window.dispatchEvent(uploadFinished);    
    });
  }

  /** Insert upload in popup progress bar */
  insertUpload() {
    const fileUpload = document.createElement("div");

    fileUpload.innerHTML = `
    <div id="upload_${this.directUpload.id}" class="my-1 flex max-w-md items-center bg-gray-100 px-2 py-1">
      <div class="mt-2">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewbox="0 0 24 24" stroke-width="1" stroke="currentColor" class="h-10 w-10 text-slate-500">
          <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m2.25 0H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" />
        </svg>
      </div>
      <div class="m-2 flex w-full flex-col">
        <div class="flex grow upload-container">
          <div class="semibold grow max-w-56 truncate text-sm text-gray-700">${this.directUpload.file.name}</div>
          <div class="progress-bar-percent ml-auto pl-2 percent text-sm text-gray-700"></div>
        </div>
        <div class="progress-bar mt-1 flex items-center rounded-full bg-gray-200">
          <div class="progress h-3 w-0 rounded-full bg-green-400 transition-all duration-200 ease-out"></div>
        </div>
      </div>
    </div>`;

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
      const uploadItems = document.querySelector("#upload-items");
      let count = Number.parseInt(uploadItems.innerHTML);
      if (count === NaN) {
        count = 1;
      } else {
        count++;
      }
      uploadItems.innerHTML = count;
      const id = `upload_${this.directUpload.id}`;

      const svgHTML = `
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewbox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="ml-auto h-6 w-6 text-green-600">
        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
      </svg>
      `;

      document.querySelector(`#${id} .progress-bar`).remove();
      let node = document.querySelector(`#${id} .progress-bar-percent`);
      node.innerHTML = svgHTML;

      setTimeout(() => {
        const e = document.querySelector(`#${id}`);
        e.parentElement.remove();
      }, 2000);
      const uploadList = document.querySelector("#uploads");

      setTimeout(() => {
        if (uploadList.children.length === 0) {
          Alpine.store('uploadModal').toggle();
        }
      }, 2100);
    })
  }

  updateProgress(event) {
    const percentage = (event.loaded / event.total) * 100;
    const progress = document.querySelector(`#upload_${this.directUpload.id} .progress`);
    progress.style.width = `${0 + percentage}%`;

    const percent = document.querySelector(`#upload_${this.directUpload.id} .percent`);
    percent.innerHTML = `${Math.round(percentage)}%`;
  }
}

export default class extends Controller {
  static targets = ["fileInput"];
  totalUploads = 0;

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
    const trigger = new CustomEvent("refresh-lightbox");
    window.dispatchEvent(trigger);
  }

  acceptFiles(event) {
    Alpine.store('uploadModal').toggle();
    event.preventDefault();
    const files = event.dataTransfer ? event.dataTransfer.files : event.target.files;
    this.totalUploads = files.length;
    const uploadTotal = document.querySelector("#upload-total");
    uploadTotal.innerHTML = `${this.totalUploads} files uploaded`;
    [...files].forEach((f) => {
      new Upload(f).process();
    });
  }
}
