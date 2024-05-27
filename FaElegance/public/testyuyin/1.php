<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 检查是否有上传的文件
    if ($_FILES['file']['error'] === UPLOAD_ERR_OK) {
        $tempFile = $_FILES['file']['tmp_name'];
        $targetPath = '../uploads/'; // 保存录音文件的目录

        // 生成一个唯一的文件名
        $fileName = uniqid('recording_') . '.wav';
$filePath = '/uploads/'. $fileName;
        // 将临时文件移动到目标路径
        if (move_uploaded_file($tempFile, $targetPath . $fileName)) {
            // 文件移动成功，可以在此处进行其他处理，如数据库插入或更新等
            $token = $_POST['username'];
            $bookName = $_POST['book_name'];

            // 连接数据库，执行插入或更新操作
            $servername = "localhost";
            $username = "root";
            $password = "Fei.1234";
            $dbname = "elegance";

            // 创建连接
            $conn = new mysqli($servername, $username, $password, $dbname);

            // 检查连接是否成功
            if ($conn->connect_error) {
                $response = [
                    'success' => false,
                    'error' => 'Failed to connect to the database.',
                ];
                echo json_encode($response);
                exit;
            }
$sql2 = "SELECT * FROM fa_admin where username='$token'";
$result2 = $conn->query($sql2);

    $row2 = $result2->fetch_assoc();
    $username2 = $row2['username'];

            // 检查是否存在相同的记录
            $sql = "SELECT * FROM fa_sound WHERE username = '$username2' AND book_name = '$bookName'";

            $result = $conn->query($sql);

            if ($result->num_rows > 0) {
                // 相同记录已存在，执行更新操作
                $sql = "UPDATE fa_sound SET sound_file = '$filePath' WHERE username = '$username2' AND book_name = '$bookName'";
            } else {
                // 相同记录不存在，执行插入操作
                $sql = "INSERT INTO fa_sound (username, book_name, sound_file) VALUES ('$username2', '$bookName', '$filePath')";
            }

            if ($conn->query($sql) === TRUE) {
                // 数据库操作成功
                $response = [
                    'success' => true,
                    'recording_url' => 'https://8.141.186.125/testyuyin' . $filePath,
                ];
                echo json_encode($response);
            } else {
                // 数据库操作失败
                $response = [
                    'success' => false,
                    'error' => 'Database operation failed.',
                ];
                echo json_encode($response);
            }

            // 关闭数据库连接
            $conn->close();
        } else {
            // 文件移动失败
            $response = [
                'success' => false,
                'error' => 'Failed to move the uploaded file.',
            ];
            echo json_encode($response);
        }
    } else {
        // 文件上传失败
        $response = [
            'success' => false,
            'error' => 'File upload failed.',
        ];
        echo json_encode($response);
    }
} else {
    // 不支持的请求方法
    $response = [
        'success' => false,
        'error' => 'Unsupported request method.',
    ];
    echo json_encode($response);
}