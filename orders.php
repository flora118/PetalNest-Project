<?php
$title = 'My Orders - PetalNest';

// Includes
include_once __DIR__ . '/includes/header.php';
include_once __DIR__ . '/includes/functions.php';

// Check login
if (!is_logged_in()) {
    redirect('login.php'); // root relative
}

$user = $_SESSION['user'];
$orders = get_user_orders($user['id']);
?>

<section class="orders-section">
    <div class="container">
        <h2 class="section-title">My Orders</h2>
        
        <?php if ($orders->num_rows): ?>
        <div class="orders-table">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($order = $orders->fetch_assoc()): ?>
                    <tr>
                        <td>#<?= sprintf("%05d", $order['id']) ?></td>
                        <td><?= date('d M Y', strtotime($order['created_at'])) ?></td>
                        <td>$<?= number_format($order['total'], 2) ?></td>
                        <td>
                            <span class="status-badge status-<?= strtolower($order['status']) ?>">
                                <?= $order['status'] ?>
                            </span>
                        </td>
                        <td>
                            <a href="order-details.php?id=<?= $order['id'] ?>" class="btn-view">View Details</a>
                        </td>
                    </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
        <?php else: ?>
        <div class="empty-orders">
            <i class="fas fa-shopping-bag"></i>
            <h3>You haven't placed any orders yet</h3>
            <a href="../../products.php" class="cta-btn">Start Shopping</a>
        </div>
        <?php endif; ?>
    </div>
</section>
<?php include_once __DIR__ . '/includes/footer.php'; ?>
