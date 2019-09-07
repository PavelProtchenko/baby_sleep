$(document).on('turbolinks:load', function() {
  // In your custom js file, for example:
  // /app/javascript/utils/trix.js
  const trixOnEditorReady = () => {
    Trix.config.blockAttributes.default.breakOnReturn = false;
    trixAddAttachmentButtonToToolbar();
  };

  const trixAddAttachmentButtonToToolbar = () => {
    let trixBlockButtons = document.querySelector(".trix-button-group--block-tools");
    const strikeBtn = document.querySelector('.trix-button.trix-button--icon.trix-button--icon-strike');
    const btnLink = document.querySelector('.trix-button.trix-button--icon.trix-button--icon-link');
    const codeBtn = document.querySelector('.trix-button.trix-button--icon.trix-button--icon-code');
    const decreaseBtn = document.querySelector('.trix-button.trix-button--icon.trix-button--icon-decrease-nesting-level');
    const increaseBtn = document.querySelector('.trix-button.trix-button--icon.trix-button--icon-increase-nesting-level');
    const quoteBtn = document.querySelector('.trix-button.trix-button--icon.trix-button--icon-quote');
    const buttonHTML = `
        <button
          type="button"
          class="trix-button trix-button--icon trix-button--icon-attach-files"
          data-trix-action="x-attach" title="Attach Files"
          tabindex="-1"
        >Attach Files</button>
      `;
    checker(strikeBtn, btnLink, codeBtn, quoteBtn, increaseBtn, decreaseBtn)

    if(trixBlockButtons === undefined) {
      return;
    }else if(trixBlockButtons === null) {
      return
    }else{
      trixBlockButtons.innerHTML += buttonHTML;
    }

    document.querySelector(".trix-button--icon-attach-files")
      .addEventListener("click", trixAddAttachment)
  };

  checker = (...elements) => {
    elements.map(el => {
      if(el != null) {
        return el.remove();
      }else if(el === null) {
        return
      }else{
        return
      }
    })
  }

  const trixAddAttachment = () => {
    const fileInput = document.createElement("input");

    fileInput.setAttribute("type", "file");
    fileInput.setAttribute("accept", ".jpg, .jpeg, .png, .gif");
    fileInput.setAttribute("multiple", "");

    fileInput.addEventListener("change", () => {
      const {files} = fileInput;
      Array.from(files).forEach(insertAttachment)
    });

    fileInput.click()
  };

  trixOnEditorReady();

  const insertAttachment = (file) => {
    const trixEditor = document.querySelector("trix-editor").editor;
    trixEditor.insertFile(file);
  };
  // After that, we should invoke trixOnEditorReady on document ready. Please be careful when you use Torbolinks:

  // For example, in app/javascript/packs/application.js

  // import {trixOnEditorReady} from "../utils/trix";
});
