package kr.co.truetrue.member;

public class LoginVO {
    private String userId;
    private String password;

    // 기본 생성자
    public LoginVO() {}

    // 매개변수를 받는 생성자
    public LoginVO(String userId, String password) {
        this.userId = userId;
        this.password = password;
    }

    // Getter 메서드
    public String getUserId() {
        return userId;
    }

    public String getPassword() {
        return password;
    }

    // Setter 메서드
    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
