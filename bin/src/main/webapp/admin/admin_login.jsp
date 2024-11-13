<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 로그인</title>
    <style>
        :root {
            --bg-color: #f0f0f0;
            --container-bg-color: white;
            --text-color: #333;
            --input-border-color: #ddd;
            --button-bg-color: #007bff;
            --button-hover-bg-color: #0056b3;
        }
        
        .dark-mode {
            --bg-color: #333;
            --container-bg-color: #444;
            --text-color: #f0f0f0;
            --input-border-color: #555;
            --button-bg-color: #0056b3;
            --button-hover-bg-color: #003d82;
        }

        body { 
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: var(--bg-color);
            color: var(--text-color);
            transition: background-color 0.3s, color 0.3s;
        }
        .login-container {
            background-color: var(--container-bg-color);
            padding: 3rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            width: 400px;
            max-width: 90%;
        }
        h1 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2rem;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        input {
            margin: 15px 0;
            padding: 15px;
            border: 2px solid var(--input-border-color);
            border-radius: 8px;
            background-color: var(--container-bg-color);
            color: var(--text-color);
            font-size: 1rem;
        }
        button {
            background-color: var(--button-bg-color);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 1.1rem;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: var(--button-hover-bg-color);
        }
        #toggleMode {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: transparent;
            border: 2px solid var(--text-color);
            color: var(--text-color);
            padding: 10px 15px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <button id="toggleMode">라이트/다크 모드</button>
    <div class="login-container">
        <h1>관리자 로그인</h1>
        <form id="loginForm">
            <input type="text" id="username" placeholder="사용자 이름" required>
            <input type="password" id="password" placeholder="비밀번호" required>
            <button type="submit">로그인</button>
        </form>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            
            // 여기에 로그인 로직을 구현하세요.
            console.log('로그인 시도:', username, password);
            alert('로그인 기능은 백엔드 구현이 필요합니다.');
        });

        const toggleModeButton = document.getElementById('toggleMode');
        toggleModeButton.addEventListener('click', function() {
            document.body.classList.toggle('dark-mode');
            if (document.body.classList.contains('dark-mode')) {
                localStorage.setItem('mode', 'dark');
            } else {
                localStorage.setItem('mode', 'light');
            }
        });

        // 페이지 로드 시 저장된 모드 적용
        if (localStorage.getItem('mode') === 'dark') {
            document.body.classList.add('dark-mode');
        }
    </script>
</body>
</html>
