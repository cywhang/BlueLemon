
  var input = document.getElementById("uploaderInput");
  var initLabel = document.getElementById("uploaderLabel");
  
  // 파일 선택 시 이벤트 핸들러
  input.addEventListener("change", (event) => {
    const files = changeEvent(event);
    handleUpdate(files);
  });
  
  // 드래그 영역에 마우스 오버 시 이벤트 핸들러
  initLabel.addEventListener("mouseover", (event) => {
	  event.preventDefault();
	  const label = document.getElementById("uploaderLabel");
	  if (label instanceof HTMLElement) {
		    label.classList.add("label--hover");
	  }
	});
  
	// 드래그 영역에서 마우스 벗어날 때 이벤트 핸들러
	initLabel.addEventListener("mouseout", (event) => {
	  event.preventDefault();
	  const label = document.getElementById("uploaderLabel");
	  if (label instanceof HTMLElement) {
		    label.classList.remove("label--hover");
	  }
	});

  // 드래그 영역에 들어갔을 때 이벤트 핸들러
  document.addEventListener("dragenter", (event) => {
	  event.preventDefault();
	  console.log("dragenter");
	  if (event.target.className === "uploaderInner") {
		  event.target.style.background = "#dee2e6";
	  }
  });
  
  //드래그 영역에서 움직일 때 이벤트 핸들러
  document.addEventListener("dragover", (event) => {
	  console.log("dragover");
      event.preventDefault();
  });
  
  //드래그 영역에서 나올 때 이벤트 핸들러
  document.addEventListener("dragleave", (event) => {
	  event.preventDefault();
	  console.log("dragleave");
	  if (event.target.className === "uploaderInner") {
		  event.target.style.background = "#dee2e6";
	  }
  });

  //드롭 시 이벤트 핸들러
  document.addEventListener("drop", (event) => {
  event.preventDefault();
  console.log("drop");
	  if (event.target.className === "uploaderInner") {
		  const files = event.dataTransfer.files;
		  event.target.style.background = "#dee2e6";
	      handleUpdate([...files]);
	  }
  });
  
  //파일 선택 이벤트에서 파일 목록 추출 함수
  function changeEvent(event){
    const { target } = event;
    return [...target.files];
  };
  
  //이미지 업데이트 처리 함수
  function handleUpdate(fileList){
    const preview = document.getElementById("preview");
    
    // 각 파일에 대해 FileReader를 사용하여 이미지 로드 이벤트 처리
    fileList.forEach((file) => {
    	const reader = new FileReader();
    	// 이미지 로드 완료 시 실행될 이벤트 처리
    	reader.addEventListener("load", (event) => {
    		// 로드된 이미지를 새로운 img 요소로 생성
    		const img = el("img", {
    		className: "embed-img",
    		src: event.target.result,
    });
    // 이미지를 감싸는 컨테이너 요소 생성
    const imgContainer = el("div", { className: "container-img" }, img);
    	// preview 컨테이너에 이미지 컨테이너 추가
        preview.append(imgContainer);
      });
    	// FileReader를 사용하여 파일의 데이터를 읽음
      reader.readAsDataURL(file);
    });
  };
  
  //요소 생성을 위한 도우미 함수
  function el(nodeName, attributes, ...children) {
    const node =
      nodeName === "fragment"
    ? document.createDocumentFragment()
    : document.createElement(nodeName);

Object.entries(attributes).forEach(([key, value]) => {
  if (key === "events") {
    Object.entries(value).forEach(([type, listener]) => {
      node.addEventListener(type, listener);
    });
  } else if (key in node) {
    try {
      node[key] = value;
    } catch (err) {
      node.setAttribute(key, value);
    }
  } else {
    node.setAttribute(key, value);
  }
});

children.forEach((childNode) => {
  if (typeof childNode === "string") {
        node.appendChild(document.createTextNode(childNode));
      } else {
        node.appendChild(childNode);
      }
    });

    return node;
}
  
  //파일로부터 이미지 요소 생성 함수
  function createImageElement(file) {
	    const reader = new FileReader();
	    const imgContainer = el("div", { className: "container-img" });
		const img = el("img", {
		  className: "embed-img",
		  src: "#",
		});
		const cancelBtn = el("button", { className: "cancel-button" });
		const cancelIcon = el("span", { className: "material-icons" });
		cancelIcon.textContent = "close";
		cancelBtn.appendChild(cancelIcon);
		cancelBtn.addEventListener("click", () => {
		  imgContainer.remove(); // 이미지 컨테이너 제거
		  const fileIndex = fileList.indexOf(file);
		  if (fileIndex !== -1) {
		    fileList.splice(fileIndex, 1); // fileList에서 해당 파일 제거
		  }
		});

reader.addEventListener("load", (event) => {
      img.src = event.target.result;
    });

    reader.readAsDataURL(file);

    imgContainer.appendChild(img);
    imgContainer.appendChild(cancelBtn);
    return imgContainer;
  }
  
  // 이미지 업데이트 처리 함수
  function handleUpdate(fileList) {
    const preview = document.getElementById("preview");

    fileList.forEach((file) => {
      const imgContainer = createImageElement(file);
      preview.appendChild(imgContainer);
    });
  }


