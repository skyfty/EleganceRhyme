<?php
// 检查是否有文件上传
if(isset($_FILES['image'])) {
    // 获取上传的文件信息
    $file_name = $_FILES['image']['name'];
    $file_tmp = $_FILES['image']['tmp_name'];
    $file_type = $_FILES['image']['type'];
    
    // 设置图片存储路径和文件名
    $upload_path = '../uploads/';
    $upPath = '/uploads/';
    $file_name = uniqid() . '.' . pathinfo($file_name, PATHINFO_EXTENSION);
    $upload_file = $upload_path . $file_name;
    $sqlUp = $upPath . $file_name;

    
    // 移动上传的文件到指定路径
    if(move_uploaded_file($file_tmp, $upload_file)) {
        // 图片上传成功，获取用户名
        $username = $_POST['username'];
        
        // 假设这里是你的数据库连接
        $db_host = 'localhost';
        $db_username = 'root';
        $db_password = 'Fei.1234';
        $db_name = 'elegance';
        
        // 创建数据库连接
        $conn = new mysqli($db_host, $db_username, $db_password, $db_name);
        
        // 检查连接是否成功
        if($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }
        
        // 更新数据库中对应用户名的图片地址
        $sql = "UPDATE fa_admin SET avatar='$sqlUp' WHERE username='$username'";
        
        if($conn->query($sql) === TRUE) {
            //JSON格式返回图片地址
            $data = array('image' => $sqlUp, 'success' => '修改成功');
            echo json_encode($data);
        } else {
            $data = array('error' => '更新错误: ' . $conn->error);
            echo json_encode($data);
        }
        
        // 关闭数据库连接
        $conn->close();
    } else {
        $data = array('error' => '文件上传失败');
        echo json_encode($data);
    }
} else {
    $data = array('error' => '没有文件上传');
    echo json_encode($data);
}
?>