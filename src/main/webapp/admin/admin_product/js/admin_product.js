// 제품 종류 옵션 정의
const productTypes = {
    bread: [
        { value: "식빵", label: "식빵" },
        { value: "간식빵", label: "간식빵" },
        { value: "도넛/고로케", label: "도넛/고로케"}
    ],
    cake: [
        { value: "생크림케이크", label: "생크림케이크" },
        { value: "캐릭터케이크", label: "캐릭터케이크" },
        { value: "조각케이크", label: "조각케이크" }
    ]
};

// 종류 선택 업데이트 함수
function updateProductType(category) {
    // 모든 product_type select 요소를 찾습니다
    const typeSelects = document.querySelectorAll('#product_type');
    
	// 선택된 카테고리 값 가져오기
    const categoryId = category;

	// hidden input의 값 업데이트
	document.getElementById('hiddenCategoryId').value = categoryId;
   
	 typeSelects.forEach(typeSelect => {
        // 기존 옵션 제거
        typeSelect.innerHTML = '<option value="">선택하세요</option>';
        
        // 선택된 카테고리에 따라 새로운 옵션 추가
        productTypes[category==="1"?"bread":"cake"].forEach(option => {
            const optionElement = document.createElement('option');
            optionElement.value = option.value;
            optionElement.textContent = option.label;
            typeSelect.appendChild(optionElement);
        });
    });
}

// 모달 관리 함수들
function openAddProductModal() {
    loadTailwindCSS();
    const modal = document.getElementById('addProductModal');
    if (modal) {
        modal.style.display = 'block';
        initializeModal(modal);
    }
}

function openEditProductModal(productId) {
	loadTailwindCSS();
    // AJAX 요청으로 서버에서 제품 정보를 가져오기
    fetch(`product_detail.jsp?productId=${productId}`)
        .then(response => response.json())
        .then(data => {
            // 제품 정보로 모달 필드 채우기
            document.getElementById("product_id").value = data.product_id;  // 제품 ID
            document.getElementById("product_name").value = data.product_name;  // 제품명
            document.getElementById("description").value = data.detail;  // 제품 설명
            document.getElementById("total_weight").value = data.total_weight;  // 가격
            document.getElementById("calories").value = data.calories;  // 가격
            document.getElementById("sugar").value = data.sugar;  // 가격
            document.getElementById("protein").value = data.protein;  // 가격
            document.getElementById("saturated_fat").value = data.saturated_fat;  // 가격
            document.getElementById("sodium").value = data.sodium;  // 가격
            document.getElementById("price").value = data.price;  // 가격
            
			const imagePreview = document.getElementById("imagePreview");
			       if (data.product_img) {
			           imagePreview.src = `http://localhost/model1_project/truetrue/common/images/bread/${data.product_img}`;
			       } else {
			           // 이미지가 없는 경우 기본 이미지 설정
			           imagePreview.src = "http://localhost/model1_project/truetrue/common/images/bread/bread1.jpg";
			       }
			
            // 카테고리 라디오 버튼 선택 (현재 선택된 카테고리를 확인)
            const categoryRadio = document.querySelector(`input[name="category"][value="${data.category_id}"]`);
            if (categoryRadio) categoryRadio.checked = true;  // 해당 카테고리 선택

			// 제품 종류 (type) 드롭다운 설정
			const productTypeSelect = document.getElementById("product_type");
			productTypeSelect.innerHTML = "";  // 기존 항목 초기화

			// 데이터에서 카테고리 이름을 가져옵니다 (예: 'bread', 'cake')
			const category = data.category_id === '1' ? 'bread' : 'cake';  // 예시로 1이 'bread'이고, 다른 값은 'cake'로 설정

			// 해당 카테고리의 제품 옵션을 가져옵니다
			const productTypesForCategory = productTypes[category];

			// 각 옵션을 드롭다운에 추가
			productTypesForCategory.forEach(type => {
			    const option = document.createElement("option");
			    option.value = type.value;
			    option.textContent = type.label;
			    productTypeSelect.appendChild(option);
			});

			// 기본 값 설정
			productTypeSelect.value = data.product_type;


			// 알레르기 정보 체크박스 설정 (기존 선택된 알레르기 정보)
			const allergyCheckboxes = document.querySelectorAll("input[type='checkbox']");

			// data.allergy_info 배열이 존재하고 올바른 배열인 경우
			if (Array.isArray(data.allergy_ingredients)) {
			         // 알레르기 항목에 해당하는 체크박스 체크
			        allergyCheckboxes.forEach(checkbox => {
			            // 체크박스의 value 값이 data.allergy_ingredients 배열에 있는지 확인
			         checkbox.checked = data.allergy_ingredients.some(ingredient => ingredient.ingredient_name === checkbox.nextElementSibling.innerText);
			           });
			   } else {
			    console.warn("알레르기 정보가 배열이 아닙니다:", data.allergy_info);
			    allergyCheckboxes.forEach(checkbox => {
			        checkbox.checked = false; // 알레르기 정보가 없을 경우 기본적으로 체크 해제
			    });
			}


            // 모달을 화면에 표시
            document.getElementById("editProductModal").style.display = "block";
        })
        .catch(error => console.error("Error:", error));
}





function closeProductModal() {
    const modals = document.querySelectorAll('#addProductModal, #editProductModal');
    modals.forEach(modal => {
        if (modal) {
            modal.style.display = 'none';
        }
    });
    removeTailwindCSS();
}

// 모달 초기화 함수
function initializeModal(modal) {
    // 해당 모달 내의 라디오 버튼 초기값으로 종류 옵션 설정
    const initialCategory = modal.querySelector('input[name="category"]:checked');
    if (initialCategory) {
        updateProductType(initialCategory.value);
    }
    
    // 카테고리 변경 이벤트 리스너 설정
    const categoryInputs = modal.querySelectorAll('input[name="category"]');
    categoryInputs.forEach(input => {
        input.addEventListener('change', (e) => updateProductType(e.target.value==="1"?"bread":"cake"));
    });
}

// Tailwind CSS 관리 함수들
function loadTailwindCSS() {
    if (!document.getElementById('tailwindCSS')) {
        const tailwindLink = document.createElement('link');
        tailwindLink.rel = 'stylesheet';
        tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css';
        tailwindLink.id = 'tailwindCSS';
        document.head.appendChild(tailwindLink);
    }
}

function removeTailwindCSS() {
    const tailwindLink = document.getElementById('tailwindCSS');
    if (tailwindLink) {
        document.head.removeChild(tailwindLink);
    }
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    if (event.target.matches('.modal-overlay')) {
        closeProductModal();
    }
};

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    // 모든 모달에 대해 초기화 수행
    const modals = document.querySelectorAll('#addProductModal, #editProductModal');
    modals.forEach(modal => {
        if (modal.style.display === 'block') {
            initializeModal(modal);
        }
    });
		const productImageInput = document.getElementById("product_image");
	   const imagePreview = document.getElementById("imagePreview");

	   // 파일 선택 시 미리보기 이미지 업데이트
	   productImageInput.addEventListener("change", function () {
	       const file = this.files[0];
	       if (file) {
	           const reader = new FileReader();
	           reader.onload = function (e) {
	               imagePreview.src = e.target.result; // 선택된 이미지를 미리보기로 설정
	           };
	           reader.readAsDataURL(file);
	       }
	   });
});

// 제품 삭제 함수
function deleteProduct(prdId) {
    if (confirm("정말로 이 제품을 삭제하시겠습니까?")) {
        // AJAX 요청으로 삭제 처리
        fetch('delete_product.jsp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'productId=' + prdId // productId를 POST로 전송
        })
        .then(response => response.text())
        .then(data => {
			alert(data);
			location.reload(); // 페이지 새로고침
        })
        .catch(error => {
            console.error('삭제 중 오류 발생:', error);
            alert("오류가 발생했습니다.");
        });
    }
}

// 폼 제출 처리
// 저장 버튼 클릭 시 실행되는 업데이트용 함수
   document.querySelector("#editProductForm").addEventListener("submit", function (e) {
       e.preventDefault(); // 폼의 기본 동작(페이지 새로 고침)을 방지합니다.

       // 폼 데이터를 JSON 형식으로 변환
       const formData = new FormData(this);
       const data = {
           product_id: formData.get("product_id"),
           category_id: formData.get("category"),
           product_name: formData.get("product_name"),
           product_type: formData.get("product_type"),
           detail: formData.get("description"),
           total_weight: formData.get("total_weight"),
           calories: formData.get("calories"),
           sugar: formData.get("sugar"),
           protein: formData.get("protein"),
           saturated_fat: formData.get("saturated_fat"),
           sodium: formData.get("sodium"),
           price: formData.get("price"),
           allergy_info: [],
           product_img: formData.get("product_image")
       };

       // 알레르기 정보를 체크박스로부터 가져오기
	   const allergyCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
	   allergyCheckboxes.forEach(function (checkbox) {
	       // 각 체크박스의 value를 ingredient_name으로 사용
	       const ingredientName = checkbox.value;

	       // 알레르기 정보를 객체 형태로 추가 (ingredient_name 포함)
	       data.allergy_info.push({
	           ingredient_name: ingredientName
	       });
	   });
		formData.append('data',JSON.stringify(data));
       // JSON 데이터를 콘솔로 확인
       console.log(data);

       // AJAX 요청으로 데이터를 update_product.jsp에 전송
       const xhr = new XMLHttpRequest();
       xhr.open("POST", "update_product.jsp", true);

       // JSON 데이터로 전송
       xhr.send(formData);

       // 응답 처리
       xhr.onload = function () {
           if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);
               if (response.success) {
                   alert("제품 정보가 업데이트되었습니다.");
                   closeProductModal(); // 모달 닫기
               } else {
                   alert("제품 정보 업데이트에 실패했습니다.");
               }
           } else {
               alert("서버 오류가 발생했습니다.");
           }
       };
   });
   
   // 저장 버튼 클릭 시 실행되는 제품추가용 함수
   document.querySelector("#addProductForm").addEventListener("submit", function (e) {
          e.preventDefault(); // 폼의 기본 동작(페이지 새로 고침)을 방지합니다.

          // 폼 데이터를 JSON 형식으로 변환
          const formData = new FormData(this);
		  
		  const categoryId=document.getElementById('hiddenCategoryId').value;
			
		  console.log(categoryId);
		  

		  
		   const data = {
              category_id: categoryId,
              product_name: formData.get("product_name"),
              product_type: formData.get("product_type"),
              detail: formData.get("description"),
              total_weight: formData.get("total_weight"),
              calories: formData.get("calories"),
              sugar: formData.get("sugar"),
              protein: formData.get("protein"),
              saturated_fat: formData.get("saturated_fat"),
              sodium: formData.get("sodium"),
              price: formData.get("price"),
              allergy_info: [],
              product_img: formData.get("product_image")
          };

          // 알레르기 정보를 체크박스로부터 가져오기
   	   const allergyCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
   	   allergyCheckboxes.forEach(function (checkbox) {
   	       // 각 체크박스의 value를 ingredient_name으로 사용
   	       const ingredientName = checkbox.value;

   	       // 알레르기 정보를 객체 형태로 추가 (ingredient_name 포함)
   	       data.allergy_info.push({
   	           ingredient_name: ingredientName
   	       });
   	   });
   		formData.append('data',JSON.stringify(data));
          // JSON 데이터를 콘솔로 확인
          console.log(data);

          // AJAX 요청으로 데이터를 update_product.jsp에 전송
          const xhr = new XMLHttpRequest();
          xhr.open("POST", "insert_product.jsp", true);

          // JSON 데이터로 전송
          xhr.send(formData);

          // 응답 처리
          xhr.onload = function () {
              if (xhr.status === 200) {
                  const response = JSON.parse(xhr.responseText);
                  if (response.success) {
                      alert("제품 정보가 추가되었습니다.");
                      closeProductModal(); // 모달 닫기
                  } else {
                      alert("제품 정보 추가에 실패했습니다.");
                  }
              } else {
                  alert("서버 오류가 발생했습니다.");
              }
          };
      });
	  
   function searchProducts() {
       const productName = document.getElementById("product-name").value.trim();  // 제품명 입력값 가져오기

       if (productName === "") {
           alert("검색어를 입력해주세요.");
           return;
       }

       // 서버에 AJAX 요청 보내기
       fetch(`search_product.jsp?productName=${encodeURIComponent(productName)}`, {
           method: "GET",  // HTTP GET 요청
           headers: {
               "Content-Type": "application/json"  // 요청 헤더 설정
           }
       })
       .then(response => response.json())  // JSON 형식으로 응답받기
       .then(data => {
			
           const products = data.products;
           if (products && products.length > 0) {
               updateProductTable(products);  // 검색된 제품 목록을 테이블에 업데이트
           } else {
               alert("검색 결과가 없습니다.");
               clearProductTable();  // 검색 결과가 없으면 테이블 비우기
           }
       })

   }



   // 검색된 제품 목록을 테이블에 표시하는 함수
   function updateProductTable(products) {
		const productTableBody = document.querySelector(".product-table tbody");  // 제품 목록을 표시할 테이블 tbody
	    productTableBody.innerHTML = "";  // 기존 테이블 내용 비우기


       products.forEach(product => {
           const row = document.createElement("tr");

           row.innerHTML = `
               <td>${product.product_id}</td>
               <td>${product.category}</td>
               <td>${product.product_name}</td>
               <td>${product.input_date}</td>
               <td>${product.price}원</td>
               <td>${product.delete_flag}</td>
               <td>
                   <button class="action-btn" onclick="openEditProductModal(${product.product_id})">편집</button>
                   <button class="action-btn delete-btn" onclick="deleteProduct(${product.product_id})">삭제</button>
               </td>
           `;
           
           productTableBody.appendChild(row);  // 테이블에 행 추가
       });
   }

   // 테이블을 초기화하는 함수
   function clearProductTable() {
	  const productTableBody = document.querySelector(".product-table tbody");
	  productTableBody.innerHTML = "";  // 모든 행 삭제
   }
   //초기화 버튼 
   function resetFilters() {
       document.getElementById("product-name").value = "";  // 검색어 초기화
	   fetch('getall_product.jsp')  // JSP 페이지 URL
	           .then(response => response.json())
	           .then(data => {
	               updateProductTable(data.products);
	           })
	           .catch(error => console.error('Error fetching products:', error));
	   
	 }
