
// PEOPLE 탭의 사람들 목록을 가져와서 동적으로 표시하는 함수
function people_List() {
    console.log("[PEOPLE 탭 - 2] people_List url 요청함");

    $.ajax({
        url: "people_List",
        type: "GET",
        dataType: "json", // 데이터 형식을 JSON으로 지정
        success: function(response) {
            var canFollowList = response.canFollow;
            var mostFamousList = response.mostFamous;

            // 받아온 데이터를 활용해 동적으로 카드 추가
            if (canFollowList && canFollowList.length > 0) {
                var cardsContainer = document.getElementById("canFollowPeople-cards-container");

                // 컨테이너 초기화
                cardsContainer.innerHTML = "";

                // 받아온 데이터를 기반으로 카드 생성 및 추가
                var maxCards = 5; // 원하는 출력 개수를 설정
                for (var i = 0; i < canFollowList.length && i < maxCards; i++) {
                    var follow = canFollowList[i];
                    
                    var card = document.createElement("div");
                    card.classList.add("account-item");
                    card.classList.add("pf-item");
                    card.innerHTML = `
                        <a href="profile" class="p-3 border-bottom d-flex text-dark text-decoration-none">
                            <img src="img/uploads/profile/${follow.member_Profile_Image}" class="img-fluid rounded-circle me-3" alt="profile-img">
                            <div>
                                <p class="fw-bold mb-0 pe-3 d-flex align-items-center">${follow.member_Id}</p>
                                <div class="text-muted fw-light">
                                    <p class="mb-1 small">${follow.member_Name}</p>
                                </div>
                            </div>
                            <div class="ms-auto">
                                <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                    <input type="checkbox" class="btn-check" name="btncheckbox" id="btncheck${follow.member_Id}">
                                    <label class="btn btn-outline-primary btn-sm px-3 rounded-pill" for="btncheck${follow.member_Id}" onclick="changeFollow('${follow.member_Id}')">
                                        <span class="following d-none">Following</span>
                                        <span class="follow">+ Follow</span>
                                    </label>
                                </div>
                            </div>
                        </a>`;

                    // 컨테이너에 카드 추가
                    cardsContainer.appendChild(card);
                }
            } else {
                var cardsContainer = document.getElementById("canFollowPeople-cards-container");

                // 컨테이너 초기화
                cardsContainer.innerHTML = "";

                var card = document.createElement("div");
                card.innerHTML = `
                    <div>
                        <br>
                        <h5 align="center">Nobody To Follow</h5>
                        <br>
                    </div>
                `;
                cardsContainer.appendChild(card);
            }

            if (mostFamousList && mostFamousList.length > 0) {
                var cardsContainer2 = document.getElementById("mostFollowPeople-cards-container");

                // 컨테이너 초기화
                cardsContainer2.innerHTML = "";

                // 받아온 데이터를 기반으로 카드 생성 및 추가
                var maxCards = 5; // 원하는 출력 개수를 설정
                for (var i = 0; i < mostFamousList.length && i < maxCards; i++) {
                    var famous = mostFamousList[i];
                    if(famous.follow_Check == "n") {
                    	
                        var card2 = document.createElement("div");
                        card2.classList.add("account-item");
                        card2.classList.add("pf-item");
                        card2.innerHTML = `
                            <a href="profile" class="p-3 border-bottom d-flex text-dark text-decoration-none">
                                <img src="img/uploads/profile/${famous.member_Profile_Image}" class="img-fluid rounded-circle me-3" alt="profile-img">
                                <div>
                                    <p class="fw-bold mb-0 pe-3 d-flex align-items-center">${famous.member_Id}</p>
                                    <div class="text-muted fw-light">
                                        <p class="mb-1 small">${famous.member_Name}</p>
                                        <p class="mb-1 small">${famous.member_Follow_Count}'s Followers</p>
                                    </div>
                                </div>
                                <div class="ms-auto">
                                    <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                        <input type="checkbox" class="btn-check" name="btncheckbox" id="btncheck2${famous.member_Id}">
                                        <label class="btn btn-outline-primary btn-sm px-3 rounded-pill" for="btncheck2${famous.member_Id}" onclick="changeFollow('${famous.member_Id}')">
                                            <span class="following d-none">Following</span>
                                            <span class="follow">+ Follow</span>
                                        </label>
                                    </div>
                                </div>
                            </a>`;

                        // 컨테이너에 카드 추가
                        cardsContainer2.appendChild(card2);          
                    } else {
                    	
                        var card2 = document.createElement("div");
                        card2.classList.add("account-item");
                        card2.classList.add("pf-item");
                        card2.innerHTML = `
                            <a href="profile" class="p-3 border-bottom d-flex text-dark text-decoration-none">
                                <img src="img/uploads/profile/${famous.member_Profile_Image}" class="img-fluid rounded-circle me-3" alt="profile-img">
                                <div>
                                    <p class="fw-bold mb-0 pe-3 d-flex align-items-center">${famous.member_Id}</p>
                                    <div class="text-muted fw-light">
                                        <p class="mb-1 small">${famous.member_Name}</p>
                                        <p class="mb-1 small">${famous.member_Follow_Count}'s Followers</p>
                                    </div>
                                </div>
                                <div class="ms-auto">
                                    <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                        <input type="checkbox" class="btn-check" name="btncheckbox" id="btncheck2${famous.member_Id}" checked="checked">
                                        <label class="btn btn-outline-primary btn-sm px-3 rounded-pill" for="btncheck2${famous.member_Id}" onclick="changeFollow('${famous.member_Id}')">
                                            <span class="following d-none">Following</span>
                                            <span class="follow">+ Follow</span>
                                        </label>
                                    </div>
                                </div>
                            </a>`;

                        // 컨테이너에 카드 추가
                        cardsContainer2.appendChild(card2);                              	
                    }

 
                }
            } else {
                var cardsContainer2 = document.getElementById("mostFollowPeople-cards-container");

                // 컨테이너 초기화
                cardsContainer2.innerHTML = "";

                var card2 = document.createElement("div");

                card2.innerHTML = `
                    <div>
                        <br>
                        <h5 align="center">Nobody To Follow</h5>
                        <br>
                    </div>
                `;
                cardsContainer2.appendChild(card2);
            }
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}
