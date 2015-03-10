# Blatant copy & paste of the download logic from installer.ps1.

$basedir = "C:\FrameworkBenchmarks"
$workdir = "$basedir\installs"
New-Item -Path $workdir -Type directory -Force | Out-Null

function GetMd5FileHash($fileName) {
    [Reflection.Assembly]::LoadWithPartialName("System.Security") | out-null
    $md5 = [System.Security.Cryptography.MD5]::Create()

    $file = [System.IO.File]::OpenRead($fileName)
    $hash = $md5.ComputeHash($file)
    $file.Dispose()

    $sb = New-Object System.Text.StringBuilder
    $hash | % { [Void]$sb.Append($_.ToString("x2")) }
    $sb.ToString()
}

function DownloadFile($name, $url, $local) {
    if (Test-Path $local) {
        Write-Host "Skipping $name (already downloaded to $local)..."
    } else {
        Write-Host "Downloading $name ($url) to $local..."
        (New-Object System.Net.WebClient).DownloadFile($url, $local)
    }
}


# Download all the packages first.
$rewrite_url = "http://download.microsoft.com/download/6/7/D/67D80164-7DD0-48AF-86E3-DE7A182D6815/rewrite_2.0_rtw_x64.msi"
$rewrite_local = "$workdir\rewrite_2.0_rtw_x64.msi"
DownloadFile "rewrite" $rewrite_url $rewrite_local

$sdktools_url = "http://download.microsoft.com/download/F/1/3/F1300C9C-A120-4341-90DF-8A52509B23AC/standalonesdk/sdksetup.exe"
$sdktools_local = "$workdir\sdksetup.exe"
DownloadFile "sdktools" $sdktools_url $sdktools_local

$webdeploy_url = "http://download.microsoft.com/download/1/B/3/1B3F8377-CFE1-4B40-8402-AE1FC6A0A8C3/WebDeploy_amd64_en-US.msi"
$webdeploy_local = "$workdir\WebDeploy_amd64_en-US.msi"
DownloadFile "webdeploy" $webdeploy_url $webdeploy_local

$node_installer_file      = "node-v0.10.13-x64.msi"
$node_installer_path      = "v0.10.13/x64/$node_installer_file"
$node_installer_url       = "http://nodejs.org/dist/$node_installer_path"
$node_installer_local     = "$workdir\$node_installer_file"
DownloadFile "node.js" $node_installer_url $node_installer_local

$python_installer_file    = "python-2.7.5.amd64.msi"
$python_installer_path    = "2.7.5/$python_installer_file"
$python_version           = "27"
$python_installer_url     = "http://www.python.org/ftp/python/$python_installer_path"
$python_installer_local   = "$workdir\$python_installer_file"
DownloadFile "python" $python_installer_url $python_installer_local

$pyparallel_build         = "99482"
$pyparallel_installer_file= "pyparallel-3.3.$pyparallel_build.amd64.msi"
$pyparallel_version       = "33"
$pyparallel_installer_url = "http://download.pyparallel.org/$pyparallel_installer_file"
$pyparallel_installer_local = "$workdir\$pyparallel_installer_file"
DownloadFile "pyparallel" $pyparallel_installer_url $pyparallel_installer_local

$wincache_installer_file  = "wincache-1.3.4-5.4-nts-vc9-x86.exe"
$wincache_installer_path  = "wincache-1.3.4/$wincache_installer_file"
$wincache_url = "http://heanet.dl.sourceforge.net/project/wincache/$wincache_installer_path"
$wincache_local = "$workdir\$wincache_installer_file"
DownloadFile "wincache" $wincache_installer_url $wincache_installer_local

#$composer_url = "https://getcomposer.org/Composer-Setup.exe"
#$composer_local = "$workdir\Composer-Setup.exe"
#DownloadFile "composer" $composer_url $composer_local

$go_installer_file  = "go1.4.2.windows-amd64.msi"
$go_url = "https://storage.googleapis.com/golang/$go_installer_file"
$go_local = "$workdir\$go_installer_file"
DownloadFile "go" $go_url $go_local

$jre_installer_file       = "jdk-7u75-windows-x64.exe"
$jdk_installer_file       = "jdk-7u75-windows-x64.exe"
$jdk_master_hash          = "ff2cb8fa5b9703741d2df35ea62e0009"
$jdk_url = "http://download.pyparallel.org/$jdk_installer_file"
$jdk_local = "$workdir\$jdk_installer_file"
$jdk_dir = "C:\Java\jdk"
DownloadFile "jdk" $jdk_url $jdk_local

$resin_version = "resin-4.0.41"
$resin_installer_file = "$resin_version.zip"
$resin_url = "http://www.caucho.com/download/$resin_installer_file"
$resin_local = "$workdir\$resin_installer_file"
$resin_dir = "C:\Java\resin"
DownloadFile "resin" $resin_url $resin_local

$maven_version  = "apache-maven-3.0.5"
$maven_installer_file = "$maven_version-bin.zip"
$maven_installer_path = "maven-3/3.0.5/binaries/$maven_installer_file"
$maven_url = "http://mirror.cc.columbia.edu/pub/software/apache/maven/$maven_installer_path"
$maven_local = "$workdir\$maven_installer_file"
$maven_dir = "C:\Java\maven"
DownloadFile "maven" $maven_url $maven_local

$play_version = "2.2.0"
$play_installer_file = "play-$play_version.zip"
$play_url = "http://downloads.typesafe.com/play/$play_version/$play_installer_file"
$play_local = "$workdir\$play_installer_file"
$play_dir = "C:\Java\play"
DownloadFile "play" $play_url $play_local

$sbt_version = "0.13.5"
$sbt_installer_file = "sbt-$sbt_version.zip"
$sbt_url = "http://dl.bintray.com/sbt/native-packages/sbt/$sbt_version/$sbt_installer_file"
$sbt_local = "$workdir\$sbt_installer_file"
$sbt_dir = "C:\Java\sbt"
DownloadFile "sbt" $sbt_url $sbt_local

$mercurial_installer_file = "mercurial-2.6.1-x64.msi"
$hg_installer_url = "https://bitbucket.org/tortoisehg/files/downloads/$mercurial_installer_file"
$hg_installer_local = "$workdir\$mercurial_installer_file"
DownloadFile "hg" $hg_installer_url $hg_installer_local

$cygwin_installer_file = "setup-x86_64.exe"
$cygwin_installer_url = "http://cygwin.com/$cygwin_installer_file"
$cygwin_installer_dir = $workdir + "\cygwin-installer"
New-Item -Path $cygwin_installer_dir -Type directory -Force | Out-Null
$cygwin_installer_local = "$cygwin_installer_dir\$cygwin_installer_file"
DownloadFile "cygwin" $cygwin_installer_url $cygwin_installer_local

