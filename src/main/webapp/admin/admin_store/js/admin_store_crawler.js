/**
 * JavaScript code to fetch and display stores.
 */

function initializeStoreFetcher() {
    var regionSelect = document.getElementById("regionSelect");
    var fetchButton = document.getElementById("fetchButton");
    var loader = document.getElementById("loader");
    var tableBody = document.getElementById("storesTableBody");
    
    function createTableRow(store) {
        return "<tr>" +
               "<td>" + store.id + "</td>" +
               "<td>" + store.name + "</td>" +
               "<td>" + store.address + "</td>" +
               "<td>" + store.phone + "</td>" +
               "<td>" + store.hours + "</td>" +
               "</tr>";
    }

    function showLoading() {
        fetchButton.disabled = true;
        loader.style.display = "inline-block";
        tableBody.innerHTML = "<tr><td colspan='5' class='empty-message'>매장 정보를 불러오는 중...</td></tr>";
    }

    function hideLoading() {
        fetchButton.disabled = false;
        loader.style.display = "none";
    }

    function showError() {
        tableBody.innerHTML = "<tr><td colspan='5' class='empty-message'>매장 정보를 가져오는데 실패했습니다.</td></tr>";
    }

    function showEmptyMessage() {
        tableBody.innerHTML = "<tr><td colspan='5' class='empty-message'>해당 지역에 매장이 없습니다.</td></tr>";
    }

    function handleFetchClick() {
        var selectedRegion = regionSelect.value;

        if (!selectedRegion) {
            alert("지역을 선택해주세요.");
            return;
        }

        showLoading();

        fetch("/api/stores/" + selectedRegion)
            .then(function(response) {
                if (!response.ok) {
                    throw new Error("네트워크 응답이 정상적이지 않습니다.");
                }
                return response.json();
            })
            .then(function(stores) {
                if (!stores || stores.length === 0) {
                    showEmptyMessage();
                    return;
                }

                var tableRows = "";
                for (var i = 0; i < stores.length; i++) {
                    tableRows += createTableRow(stores[i]);
                }
                tableBody.innerHTML = tableRows;
            })
            .catch(function(error) {
                console.error("매장 정보 조회 중 오류 발생:", error);
                showError();
            })
            .finally(hideLoading);
    }

    fetchButton.addEventListener("click", handleFetchClick);
}

document.addEventListener("DOMContentLoaded", initializeStoreFetcher);