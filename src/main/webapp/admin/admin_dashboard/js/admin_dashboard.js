/**
 * 
 */

document.addEventListener('DOMContentLoaded', function() {
    // AJAX 요청을 통해 서버에서 매출 데이터를 가져옴
    fetch('/model1_project/getMonthlySales')
        .then(response => response.json())
        .then(data => {
            // 월별 매출 데이터를 가져옴
            var monthlySales = data.monthlySales;
            
            // 월별 레이블(YYYY-MM) 추출
            var salesLabels = Object.keys(monthlySales);
            // 월별 매출 데이터 추출
            var salesData = Object.values(monthlySales);

            // 레이블과 데이터를 역순으로 정렬
            salesLabels.reverse();
            salesData.reverse();

            // 매출 분석 차트 그리기
            const salesCtx = document.getElementById('salesChart').getContext('2d');
            new Chart(salesCtx, {
                type: 'line',
                data: {
                    labels: salesLabels,  // 역순으로 된 월별 레이블
                    datasets: [{
                        label: '매출 (원)',
                        data: salesData,  // 역순으로 된 매출 데이터
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // 매출 요약 표시
            var currentMonthSales = salesData[salesData.length - 1] || 0;  // 최신 달(오른쪽 끝)
            var previousMonthSales = salesData[salesData.length - 2] || 0;  // 그 이전 달

            // 이번 달, 저번 달 매출 표시
            document.getElementById('monthMoney').innerHTML = `매출: ${currentMonthSales.toLocaleString()} 원`;
            document.getElementById('prevMonthMoney').innerHTML = `매출: ${previousMonthSales.toLocaleString()} 원`;
        })
        .catch(error => console.error('Error fetching sales data:', error));
});


