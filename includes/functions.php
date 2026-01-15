<?php
include 'db.php';

// Start session safely
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// All function definitions follow...

// Redirect
if (!function_exists('redirect')) {
    function redirect($url) {
        header("Location: $url");
        exit;
    }
}

// Check login
if (!function_exists('is_logged_in')) {
    function is_logged_in() {
        return isset($_SESSION['user']) && !empty($_SESSION['user']['id']);
    }
}

// Sanitize (optional if using prepared statements)
if (!function_exists('sanitize')) {
    function sanitize($str) {
        global $conn;
        return $conn->real_escape_string(trim($str));
    }
}

// Get single product
if (!function_exists('get_product')) {
    function get_product($id) {
        global $conn;
        $id = (int)$id;
        $res = $conn->query("SELECT * FROM products WHERE id = $id LIMIT 1");
        return $res ? $res->fetch_assoc() : null;
    }
}

// Get user orders
if (!function_exists('get_user_orders')) {
    function get_user_orders($user_id) {
        global $conn;
        $user_id = (int)$user_id;
        return $conn->query("SELECT * FROM orders WHERE user_id = $user_id ORDER BY created_at DESC");
    }
}

// Cart count
if (!function_exists('cart_count')) {
    function cart_count() {
        $cart = $_SESSION['cart'] ?? [];
        if(!is_array($cart)) return 0;
        return array_sum($cart);
    }
}

// Wishlist count
if (!function_exists('wishlist_count')) {
    function wishlist_count() {
        $wishlist = $_SESSION['wishlist'] ?? [];
        if(!is_array($wishlist)) return 0;
        return count($wishlist);
    }
}
