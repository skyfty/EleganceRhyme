<?php

namespace app\admin\controller\webadd;

use app\common\controller\Backend;
use fast\admin\service\Admin;
use mpdf\Mpdf;


/**
 * testforma
 *
 * @icon fa fa-circle-o
 */
class Test extends Backend
{

    /**
     * Test模型对象
     * @var \app\admin\model\webadd\Test
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\webadd\Test;

    }

    public function index()
    {
          // 获取当前登录账户
    $currentUser = $this->auth->getUserInfo();
        // 将当前登录账户信息传递给前端页面
    $this->view->assign('currentUser', $currentUser);
        //设置过滤方法
        if ($this->request->isAjax()) {
        $this->request->filter(['strip_tags', 'trim']);
        if (false === $this->request->isAjax()) {
            return $this->view->fetch();
        }
        //如果发送的来源是 Selectpage，则转发到 Selectpage
        if ($this->request->request('keyField')) {
            return $this->selectpage();
        }
        [$where, $sort, $order, $offset, $limit] = $this->buildparams();
        $list = $this->model
            ->where($where)
            ->order($sort, $order)
            ->paginate($limit);
      
      

        $result = ['total' => $list->total(), 'rows' => $list->items()];
     // 获取当前登录账户
     $currentUser = $this->auth->getUserInfo();
    
     // 将当前登录账户信息传递给前端页面
     $this->view->assign('currentUser', $currentUser);
        return json($result);//返回json数据
    }
    return $this->view->fetch('index');//返回视图
    }




//    public function upload()
//  
//    {
//        header('Access-Control-Allow-Origin: *');
//        header('Access-Control-Allow-Methods: POST');
//        header("Content-Type: application/json; charset=UTF-8");
//        $data = $this->request->param();
//        $name = $data['name'];
//        $book_image = $data['book_image'];
//        $sound_file = $data['sound_file'];
//        $phone = $data['phone'];
//        $htmlContent = $data['htmlContent'];
//        // require_once '../mpdf/mpdf-7.1.0/src/Mpdf.php';
//
//        $testurl = 'http://8.141.86.125/FaElegance/';
//        $targetDir = 'public';
//
//        if (!file_exists($targetDir)) {
//            mkdir($targetDir, 0777, true);
//             $response = ['success' => '创建成功'];
//    return json($response);
//        }
//
//        if ($this->request->isPost()) {
//            // $htmlContent = $this->request->post('htmlContent');
//            $mpdf = new \Mpdf\Mpdf();
//            $mpdf->autoLangToFont = true;
//$mpdf->autoScriptToLang = true;
//            $mpdf->WriteHTML($htmlContent);
//            $mpdf->Output($targetDir.'/'.$name . '.pdf', 'F');
//$aa = '/uploads/pdf/' . $name . '.pdf';
//            $htmlContent = '<head><script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML"></script></head>' . $htmlContent;
//
//            $fileName = uniqid() . '.html';
//            $targetFile = $targetDir . '/' . $fileName;
//            $dd = $testurl . '/' . $fileName;
//
//            file_put_contents($targetFile, $htmlContent);
//
//            if ($htmlContent) {
//             
//
//                $servername = "localhost";
//                $username = "root";
//                $password = "Fei.1234";
//                $dbname = "elegance";
//
//                $conn = new \mysqli($servername, $username, $password, $dbname);
//                $conn->set_charset("utf8");
//
//                if ($conn->connect_error) {
//                    die("数据库连接失败: " . $conn->connect_error);
//                    echo "数据库连接失败";
//                } else {
//                    $sql = "INSERT INTO fa_list_books (book_name, book_file,book_image,sound_file) VALUES ('$name',  '$aa','$book_image','$sound_file')";
//
//if ($conn->query($sql) === TRUE) {
//    $response = ['success' => '插入成功'];
//    return json($response);
//    
//} else {
//    $response = ['error' => '插入失败: ' . $conn->error];
//    return json($response);
//    
//}
//                    // $sql = "UPDATE testbook SET url = '$dd' WHERE name = '$name' AND phone = '$phone'";
//                    // if ($conn->query($sql) === TRUE) {
//                    //     $response = ['success' => '上传成功'];
//                    //     return json($response);
//                    //     echo "HTML文件地址更新成功";
//                    // } else {
//                    //     $response = ['error' => 'HTML文件地址更新失败: ' . $conn->error];
//                    //     return json($response);
//                    //     echo "HTML文件地址更新失败: " . $conn->error;
//                    // }
//                    echo "数据库连接成功";
//                }
//
//                $conn->close();
//            } else {
//                $response = ['error' => '上传失败'];
//                return json($response);
//            }
//        } else {
//            $response = ['error' => 'HTML内容上传失败'];
//            return json($response);
//        }
//    } 

public function upload()
    {ini_set('memory_limit', '256M');
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Methods: POST');
        header("Content-Type: application/json; charset=UTF-8");
        $data = $this->request->param();
        
        // 获取请求参数
        $name = $data['name'];
        $book_image = $data['book_image'];
        $sound_file = $data['sound_file'];
        $phone = $data['phone'];
        $htmlContent = $data['htmlContent'];
    
        $targetDir = '../public/uploads/pdf';
    
        if (!file_exists($targetDir)) { 
            mkdir($targetDir, 0777, true);
        }
    
        if ($this->request->isPost()) {
            // 生成PDF文件
            $mpdf = new \Mpdf\Mpdf();
            $mpdf->autoLangToFont = true;
            $mpdf->autoScriptToLang = true;
            $mpdf->WriteHTML($htmlContent);
    
            // 保存PDF文件到目标目录
            $pdfFile = $targetDir . '/' . $name . '.pdf';
            $addFile = '/uploads/pdf/'.$name . '.pdf';
            if (!file_exists($targetDir)) {
                mkdir($targetDir, 0777, true);
            }
            // if (!$mpdf->Output($pdfFile, 'F')) {
            //     ini_set('display_errors', 1);
            //     $ppp=error_reporting(E_ALL);
            //     $response = ['error' => '无法保存PDF文件','name' => $ppp];
            //     echo json_encode($response);
            //     return;
            // }
            if (!$mpdf->Output($pdfFile, 'F')) {
                // ...
                $jsonError = json_last_error();
                if ($jsonError !== JSON_ERROR_NONE) {
                    $response = ['error' => 'JSON 编码错误', 'json_error' => $jsonError];
                }
                // ...
             }
            $htmlContent = '<head><script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML"></script></head>' . $htmlContent;
    
            $fileName = uniqid() . '.html';
            $targetFile = $targetDir . '/' . $fileName;
         
    
            // 保存HTML文件到目标目录
            if (!file_put_contents($targetFile, $htmlContent)) {

                $response = ['error' => '无法保存HTML文件'];
                echo json_encode($response);
                return;
            }
    
            // 连接数据库
       
                $servername = "localhost";
                $username = "root";
                $password = "Fei.1234";
                $dbname = "elegance";
    
            $conn = new \mysqli($servername, $username, $password, $dbname);
            $conn->set_charset("utf8");
    
            if ($conn->connect_error) {
                $response = ['error' => '数据库连接失败: ' . $conn->connect_error];
                echo json_encode($response);
                return;
            } else {
                $sql = "INSERT INTO fa_list_books (book_name, book_file, book_image, sound_file) VALUES ('$name',  '$addFile', '$book_image', '$sound_file')";
    
                if ($conn->query($sql) === TRUE) {
                    $response = ['success' => '插入成功'];
                    echo json_encode($response);
                } else {
                    $response = ['error' => '插入失败: ' . $conn->error];
                    echo json_encode($response);
                }
            }
    
            $conn->close();
        } else {
            $response = ['error' => '非POST请求'];
            echo json_encode($response);
        }
    }




//public function upload()
//{
//    ini_set('memory_limit', '256M');
//    header('Access-Control-Allow-Origin: *');
//    header('Access-Control-Allow-Methods: POST');
//    header("Content-Type: application/json; charset=UTF-8");
//
//    // 获取请求参数
//    $data = $this->request->param();
//    $name = $data['name'];
//    $book_image = $data['book_image'];
//    $sound_file = $data['sound_file'];
//    $phone = $data['phone'];
//    $htmlContent = $data['htmlContent'];
//
//    $testurl = 'http://8.141.86.125/FaElegance/';
//    $targetDir = '../../../../public/uploads/pdf';
//
//    // 创建目标目录（如果不存在）
////    if (!file_exists($targetDir)) {
////        mkdir($targetDir, 0777, true);
////    }
//
//    // 检查请求方法
//    if (!$this->request->isPost()) {
//        $response = ['error' => '非POST请求'];
//        echo json_encode($response);
//        return;
//    }
//
//    // 生成PDF文件
//    $mpdf = new \Mpdf\Mpdf();
//    $mpdf->autoLangToFont = true;
//    $mpdf->autoScriptToLang = true;
//    $mpdf->WriteHTML($htmlContent);
//
//    // 保存PDF文件到目标目录
//    $pdfFile = $targetDir . '/' . $name . '.pdf';
//    if (!$mpdf->Output($pdfFile, 'F')) {
//        $jsonError = json_last_error();
//        if ($jsonError !== JSON_ERROR_NONE) {
//            $response = ['error' => 'JSON 编码错误', 'json_error' => $jsonError];
//            echo json_encode($response);
//            return;
//        }
//        $response = ['error' => '无法保存PDF文件'];
//        echo json_encode($response);
//        return;
//    }
//
//    // 为HTML内容添加MathJax脚本
//    $htmlContent = '<head><script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML"></script></head>' . $htmlContent;
//
//    // 保存HTML文件到目标目录
//    $fileName = uniqid() . '.html';
//    $targetFile = $targetDir . '/' . $fileName;
//    $dd = $testurl . '/' . $fileName;
//    if (!file_put_contents($targetFile, $htmlContent)) {
//        $response = ['error' => '无法保存HTML文件'];
//        echo json_encode($response);
//        return;
//    }
//
//    // 连接数据库 
//    $servername = "localhost";
//    $username = "root";
//    $password = "Fei.1234";
//    $dbname = "elegance";
//
//    $conn = new \mysqli($servername, $username, $password, $dbname);
//    $conn->set_charset("utf8");
//
//    if ($conn->connect_error) {
//        $response = ['error' => '数据库连接失败: ' . $conn->connect_error];
//        echo json_encode($response);
//        return;
//    }
//
//    // 插入数据到数据库
//    $sql = "INSERT INTO fa_list_books (book_name, book_file, book_image, sound_file) VALUES ('$name',  '$pdfFile', '$book_image', '$sound_file')";
//    if ($conn->query($sql) === TRUE) {
//        $response = ['success' => '插入成功'];
//        echo json_encode($response);
//    } else {
//        $response = ['error' => '插入失败: ' . $conn->error];
//        echo json_encode($response);
//    }
//
//    $conn->close();
//}


    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


}
