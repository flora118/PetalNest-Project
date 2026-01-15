<?php
session_start();
$title = 'Login - PetalNest';

include 'includes/header.php';
include 'includes/db.php';

$errors = [];

if($_SERVER['REQUEST_METHOD']==='POST'){

    $user_input = trim($_POST['user_input']);
    $password   = $_POST['password'];

    if(!$user_input || !$password){
        $errors[] = "Please fill in all fields.";
    } else {

        // Prepared statement (secure)
        $stmt = $conn->prepare(
            "SELECT id, username, email, password_hash, profile_pic, email_verified 
             FROM users 
             WHERE username = ? OR email = ? 
             LIMIT 1"
        );
        $stmt->bind_param("ss", $user_input, $user_input);
        $stmt->execute();
        $result = $stmt->get_result();

        if($result->num_rows === 1){

            $u = $result->fetch_assoc();

            if(!password_verify($password, $u['password_hash'])){
                $errors[] = "Invalid password.";
            }
            elseif(!$u['email_verified']){
                $errors[] = "Please verify your email before logging in.";
            }
            else{
                // Login success
                $_SESSION['user'] = [
                    'id'            => $u['id'],
                    'username'      => $u['username'],
                    'email'         => $u['email'],
                    'profile_pic'   => $u['profile_pic'],
                    'email_verified'=> $u['email_verified']
                ];

                header("Location: index.php");
                exit;
            }

        } else {
            $errors[] = "User not found.";
        }
    }
}
?>

<main class="auth-page">
<div class="auth-container">
<h2><i class="fas fa-sign-in-alt"></i> Login to Your Account</h2>

<?php foreach($errors as $e): ?>
    <div class="error-message"><?= $e ?></div>
<?php endforeach; ?>

<form method="POST">
    <input type="text" name="user_input" placeholder="Username or Email" required>
    <input type="password" name="password" placeholder="Password" required>
    <button type="submit" class="cta-btn">Login</button>
</form>

<p>Don't have an account? <a href="register.php">Register here</a></p>
<p><a href="forgot-password.php">Forgot password?</a></p>
</div>
</main>

<?php include 'includes/footer.php'; ?>

<style>
.testing-mode-notice {
    background-color: #fff3cd;
    color: #856404;
    padding: 10px 15px;
    border-radius: 5px;
    margin-bottom: 15px;
    text-align: center;
}

.testing-mode-notice i {
    margin-right: 8px;
}

.testing-mode-notice .otp-display {
    background-color: #ff1493;
    color: white;
    padding: 5px 10px;
    border-radius: 5px;
    font-weight: bold;
    letter-spacing: 2px;
}
</style>

<?php include 'includes/footer.php'; ?>


