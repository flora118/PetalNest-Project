<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'includes/PHPMailer.php';
require 'includes/SMTP.php';
require 'includes/Exception.php';

function sendOTPEmail($to, $otp){

$mail = new PHPMailer(true);
try{
    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'furmi177@gmail.com';
    $mail->Password   = 'zuql wgds ykie zocu';
    $mail->SMTPSecure = 'tls';
    $mail->Port       = 587;

    $mail->setFrom('furmi177@gmail.com','PetalNest');
    $mail->addAddress($to);

    $mail->isHTML(true);
    $mail->Subject = "Verify your PetalNest Account";

    $mail->Body = "
    <div style='max-width:520px;margin:auto;font-family:Segoe UI,Arial,sans-serif;background:#ffffff;border-radius:14px;overflow:hidden;border:1px solid #eee'>

      <div style='background:#ff1493;color:white;padding:18px 22px;font-size:20px;font-weight:600;text-align:center'>
        PetalNest Email Verification
      </div>

      <div style='padding:30px 25px;text-align:center'>
        <p style='font-size:15px;color:#444'>Thank you for creating an account with <b>PetalNest</b>.</p>
        <p style='font-size:14px;color:#777'>Use the verification code below to complete your registration.</p>

        <div style='margin:25px 0'>
          <span style='display:inline-block;background:#ff1493;color:white;padding:14px 30px;font-size:28px;letter-spacing:8px;border-radius:10px'>
            $otp
          </span>
        </div>

        <p style='font-size:13px;color:#888'>
          This code will expire in 10 minutes. Do not share this code with anyone.
        </p>
      </div>

      <div style='background:#fafafa;padding:14px;text-align:center;font-size:12px;color:#999'>
        © ".date("Y")." PetalNest. All rights reserved.
      </div>

    </div>
    ";

    $mail->send();
    return true;

}catch(Exception $e){
    return false;
}
}
