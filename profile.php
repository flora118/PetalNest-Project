<?php
$title = 'My Profile - PetalNest';

// Absolute-safe includes
include_once __DIR__ . '/includes/functions.php';
include_once __DIR__ . '/includes/db.php';
include_once __DIR__ . '/includes/header.php';

// Check login
if (!is_logged_in()) {
    redirect('login.php'); // relative to PetalNest root
}

$user = $_SESSION['user'];
$success = $error = '';

$user = $_SESSION['user'];
$success = $error = '';

// Handle profile update
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username']);
    $email    = trim($_POST['email']);
    $phone    = trim($_POST['phone']);
    $address  = trim($_POST['address']);

    if ($username && $email) {

        // Profile picture
        $profile_pic = $user['profile_pic'] ?? 'assets/images/default-user.png';

        if (isset($_FILES['profile_pic']) && $_FILES['profile_pic']['error'] === UPLOAD_ERR_OK) {
            $file_name = $_FILES['profile_pic']['name'];
            $file_tmp  = $_FILES['profile_pic']['tmp_name'];
            $file_ext  = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));
            $allowed_ext = ['jpg', 'jpeg', 'png', 'gif'];

            // File size limit 2MB
            if ($_FILES['profile_pic']['size'] > 10*1024*1024) {
                $error = "File too large. Max 2MB allowed.";
            }
            // Mime type check
            $finfo = finfo_open(FILEINFO_MIME_TYPE);
            $mime  = finfo_file($finfo, $file_tmp);
            $allowed_mimes = ['image/jpeg','image/png','image/gif'];
            if(!in_array($mime, $allowed_mimes)) {
                $error = "Invalid file type.";
            }
            finfo_close($finfo);

            // Extension check
            if (!in_array($file_ext, $allowed_ext)) {
                $error = "Invalid file format. Only JPG, JPEG, PNG, GIF allowed.";
            }

            if (empty($error)) {
                $new_file_name = 'profile_' . $user['id'] . '.' . $file_ext;
                $upload_path   = '../assets/images/' . $new_file_name;

                if (move_uploaded_file($file_tmp, $upload_path)) {
                    $profile_pic = 'assets/images/' . $new_file_name;
                } else {
                    $error = "Failed to upload profile picture.";
                }
            }
        }

        if (empty($error)) {
            $stmt = $conn->prepare("UPDATE users SET username=?, email=?, phone=?, address=?, profile_pic=? WHERE id=?");
            $stmt->bind_param("sssssi", $username, $email, $phone, $address, $profile_pic, $user['id']);

            if ($stmt->execute()) {
                $success = "Profile updated successfully!";

                // Update session
                $_SESSION['user'] = [
                    'id' => $user['id'],
                    'username' => $username,
                    'email' => $email,
                    'profile_pic' => $profile_pic,
                    'phone' => $phone,
                    'address' => $address,
                    'email_verified' => $user['email_verified'] ?? 0
                ];

                // Refresh $user for display
                $user = $_SESSION['user'];

            } else {
                $error = "Failed to update profile.";
            }
            $stmt->close();
        }

    } else {
        $error = "Username and Email are required.";
    }
}
?>

<section class="profile-section">
    <div class="container">
        <h2 class="section-title">My Profile</h2>

        <?php if ($success): ?>
            <div class="success-message"><?= htmlspecialchars($success) ?></div>
        <?php endif; ?>
        <?php if ($error): ?>
            <div class="error-message"><?= htmlspecialchars($error) ?></div>
        <?php endif; ?>

        <div class="profile-grid">
            <!-- Sidebar -->
            <div class="profile-sidebar">
                <div class="profile-avatar">
                    <img src="<?= htmlspecialchars($user['profile_pic']) ?>" alt="Profile Picture">
                    <h3><?= htmlspecialchars($user['username']) ?></h3>
                    <p><?= htmlspecialchars($user['email']) ?></p>
                    <?php if(empty($user['email_verified'])): ?>
                        <span class="email-not-verified">Email not verified</span>
                    <?php endif; ?>
                </div>

                <div class="profile-menu">
                    <a href="profile.php" class="active"><i class="fas fa-user"></i> Profile</a>
                    <a href="orders.php"><i class="fas fa-shopping-bag"></i> My Orders</a>
                    <a href="settings.php"><i class="fas fa-cog"></i> Settings</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>

            <!-- Main content -->
            <div class="profile-content">
                <h3>Edit Profile</h3>
                <form method="POST" enctype="multipart/form-data" class="profile-form">
                    <div class="form-group">
                        <label>Profile Picture</label>
                        <input type="file" name="profile_pic" accept="image/*">
                        <small>Leave blank to keep current picture (Max 2MB)</small>
                    </div>
                    <div class="form-group">
                        <label>Username *</label>
                        <input type="text" name="username" value="<?= htmlspecialchars($user['username']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Email Address *</label>
                        <input type="email" name="email" value="<?= htmlspecialchars($user['email']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="tel" name="phone" value="<?= htmlspecialchars($user['phone'] ?? '') ?>">
                    </div>
                    <div class="form-group">
                        <label>Address</label>
                        <textarea name="address"><?= htmlspecialchars($user['address'] ?? '') ?></textarea>
                    </div>
                    <button type="submit" class="cta-btn">Update Profile</button>
                </form>
            </div>
        </div>
    </div>
</section>

<?php include __DIR__ . '/includes/footer.php'; ?>

