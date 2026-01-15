<?php
// Include necessary files
include_once __DIR__ . '/includes/functions.php';
include_once __DIR__ . '/includes/db.php';

// Start session safely
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Clear all session variables
$_SESSION = [];

// Destroy session cookie
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Destroy session
session_destroy();

// Redirect to login page
redirect('login.php'); // relative to root
exit;
