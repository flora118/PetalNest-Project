<?php
session_start();
$title = 'Register - PetalNest';
include 'includes/header.php';
include 'includes/db.php';

$errors = [];

if($_SERVER['REQUEST_METHOD']==='POST'){

    $username = trim($_POST['username']);
    $email    = trim($_POST['email']);
    $pass     = $_POST['password'];
    $cpass    = $_POST['cpassword'];

    if(!$username || !$email || !$pass || !$cpass){
        $errors[] = "All fields are required.";
    }
    elseif(!filter_var($email, FILTER_VALIDATE_EMAIL)){
        $errors[] = "Invalid email format.";
    }
    elseif($pass !== $cpass){
        $errors[] = "Passwords do not match.";
    } else {

        $chk = $conn->prepare("SELECT id FROM users WHERE username=? OR email=?");
        $chk->bind_param("ss",$username,$email);
        $chk->execute();
        $chk->store_result();

        if($chk->num_rows>0){
            $errors[] = "Username or Email already exists.";
        } else {

            $otp = rand(100000,999999);

            $_SESSION['reg_data'] = [
                'username'=>$username,
                'email'=>$email,
                'password'=>password_hash($pass,PASSWORD_DEFAULT),
                'otp'=>$otp
            ];

            include 'includes/mailer.php';

            if(sendOTPEmail($email,$otp)){
                header("Location: verify_otp.php");
                exit;
            } else {
                $errors[] = "Email sending failed. Please try again.";
            }
        }
    }
}
?>

<main class="auth-page">
    <div class="auth-container">
        <h2><i class="fas fa-user-plus"></i> Create New Account</h2>
        <p>Please register with a valid email address. You will receive an OTP to verify your email.</p>
        
        <?php foreach ($errors as $e): ?>
            <div class="error-message"><?= $e ?></div>
        <?php endforeach; ?>
        
        <form method="POST">
            <input type="text" name="username" placeholder="Username" required>
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="cpassword" placeholder="Confirm Password" required>
            <button type="submit" class="cta-btn">Register</button>
        </form>
        
        <p>Already have an account? <a href="login.php">Login here</a></p>
    </div>
</main>
<?php include 'includes/footer.php'; ?>




