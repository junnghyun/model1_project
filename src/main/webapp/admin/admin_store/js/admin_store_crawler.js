/**
 * JavaScript code to fetch and display stores with improved error handling and UI feedback
 */
function initializeStoreFetcher() {
    const regionSelect = document.getElementById("regionSelect");
    const fetchButton = document.getElementById("fetchButton");
    const loader = document.getElementById("loader");
    const tableBody = document.getElementById("storesTableBody");
    const checkAllBox = document.getElementById("checkAll");

    function createTableRow(store) {
        return `
            <tr>
                <td><input type='checkbox' class='storeCheckbox' data-store='${JSON.stringify(store)}'/></td>
                <td>${store.name}</td>
                <td>${store.address}</td>
                <td>${store.phone}</td>
                <td>${store.lat}</td>
                <td>${store.lng}</td>
            </tr>
        `;
    }

    function updateUI(state, message) {
        fetchButton.disabled = state === 'loading';
        loader.style.display = state === 'loading' ? "inline-block" : "none";

        if (message) {
            tableBody.innerHTML = `
                <tr>
                    <td colspan='6' class='empty-message'>${message}</td>
                </tr>
            `;
        }
    }

    function fetchStores(region) {
        updateUI('loading', '매장 정보를 불러오는 중...');

        fetch(`/model1_project/api/stores/${region}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(stores => {
                if (!stores || stores.length === 0) {
                    updateUI('empty', '해당 지역에 매장이 없습니다.');
                    return;
                }

                const tableRows = stores.map(store => createTableRow(store)).join('');
                tableBody.innerHTML = tableRows;

                updateUI('success');
                initializeCheckboxes();
            })
            .catch(error => {
                console.error("매장 정보 조회 중 오류 발생:", error);
                updateUI('error', '매장 정보를 가져오는데 실패했습니다.');
            });
    }

    function initializeCheckboxes() {
        const checkboxes = document.querySelectorAll('.storeCheckbox');

        checkAllBox.addEventListener('change', (e) => {
            checkboxes.forEach(checkbox => checkbox.checked = e.target.checked);
        });

        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', () => {
                checkAllBox.checked = [...checkboxes].every(cb => cb.checked);
            });
        });
    }

    fetchButton.addEventListener("click", () => {
        const selectedRegion = regionSelect.value;
        if (!selectedRegion) {
            alert("지역을 선택해주세요.");
            return;
        }
        fetchStores(selectedRegion);
    });

    // 초기 상태 설정
    updateUI('initial', '지역을 선택하고 매장 정보를 조회해주세요.');
}

document.addEventListener("DOMContentLoaded", initializeStoreFetcher);
