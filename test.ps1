# 脚本名称: CopyTestExe.ps1

$sourceFile = "C:\source\test.exe"  # 源文件路径
$targetRoot = "C:\"                 # 目标根目录

# 检查源文件是否存在
if (-Not (Test-Path $sourceFile)) {
    Write-Host "源文件 $sourceFile 不存在."
    exit
}

# 函数：尝试复制文件到目标路径，并记录结果
function TryCopyFile($source, $destination) {
    try {
        Copy-Item -Path $source -Destination $destination -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# 遍历 C 盘所有文件夹，并尝试复制 test.exe 到每个文件夹
Get-ChildItem -Path $targetRoot -Recurse -Directory | ForEach-Object {
    $targetFolder = $_.FullName
    $result = TryCopyFile -source $sourceFile -destination $targetFolder
    if ($result) {
        Write-Output "复制到 $targetFolder 成功"
    } else {
        Write-Output "复制到 $targetFolder 失败"
    }
}
