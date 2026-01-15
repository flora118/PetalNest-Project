<?php
session_start();
include 'includes/db.php';

if(!isset($_SESSION['reg_data'])){
    header("Location: register.php");
    exit;
}

$error = "";

if(isset($_POST['verify'])){

    $inputOtp = $_POST['otp'];
    $data = $_SESSION['reg_data'];

    if($inputOtp == $data['otp']){

        $stmt = $conn->prepare("INSERT INTO users(username,email,password_hash,otp,verified,email_verified)
        VALUES(?,?,?,?,1,1)");

        $stmt->bind_param("ssss",
            $data['username'],
            $data['email'],
            $data['password'],
            $data['otp']
        );
        $stmt->execute();

        unset($_SESSION['reg_data']);

        header("Location: login.php?verified=1");
        exit;

    } else {
        $error = "Invalid OTP Code";
    }
}
?>

<main class="verification-page">
    <div class="verification-container">
        <h2>Verify Your Email</h2>
        <p>We sent a 6-digit code to <b><?= htmlspecialchars($_SESSION['reg_data']['email']) ?></b></p>

        <?php if($error) echo "<div class='error-message'>$error</div>"; ?>

        <form method="POST">
            <input type="text" name="otp" placeholder="Enter OTP" maxlength="6" required>
            <button name="verify" class="cta-btn">Verify Account</button>
        </form>

        <p><a href="register.php">Start Over</a></p>
    </div>
</main>

<style>
/* OTP Verification Page */
.verification-page {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 80vh;
    background: #f0f6f8;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.verification-container {
    background: #fff;
    padding: 40px 30px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    max-width: 400px;
    width: 100%;
    text-align: center;
    transition: transform 0.3s ease;
}

.verification-container:hover {
    transform: translateY(-5px);
}

.verification-container h2 {
    font-size: 28px;
    margin-bottom: 15px;
    color: #2c3e50;
}

.verification-container p {
    font-size: 14px;
    color: #555;
    margin-bottom: 25px;
}

.verification-container b {
    color: #00796b;
}

.verification-container form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.verification-container input[type="text"] {
    padding: 12px 15px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 16px;
    text-align: center;
    letter-spacing: 2px;
    transition: border-color 0.3s ease;
}

.verification-container input[type="text"]:focus {
    border-color: #00796b;
    outline: none;
}

.verification-container .cta-btn {
    background-color: #00796b;
    color: #fff;
    font-size: 16px;
    padding: 12px;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.verification-container .cta-btn:hover {
    background-color: #004d40;
}

.verification-container .error-message {
    background: #ffebee;
    color: #c62828;
    padding: 10px 15px;
    border-radius: 8px;
    font-size: 14px;
    margin-bottom: 10px;
}

.verification-container a {
    color: #00796b;
    text-decoration: none;
    font-weight: 500;
    font-size: 14px;
}

.verification-container a:hover {
    text-decoration: underline;
}

@media (max-width: 500px) {
    .verification-container {
        padding: 30px 20px;
    }
}
</style>
