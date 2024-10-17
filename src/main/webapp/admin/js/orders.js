/**
 * 
 */

 function deleteProduct() {
    const userConfirmed = confirm("삭제하시겠습니까?");
    if (userConfirmed) {
        deleteItem(); // 삭제 기능 실행
    }
}