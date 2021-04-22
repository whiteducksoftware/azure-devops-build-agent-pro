Param(
$vsts_URL,
$agent_Pool,
$agent_Name,
$pat_Token,
$agent_Tag
)

$tmpFile = "D:\wdscriptlog.log"
New-Item -ItemType File -Path $tmpFile -Force | Out-Null


Function WriteLog
{
   Param ([string]$logstring)

    $logstring = "$((Get-Date).ToString()): $logstring"
   Add-content $tmpFile -value $logstring
}

trap{
    WriteLog ("Error: {0}" -f $Error[0].Exception)
}

WriteLog("start script")
WriteLog("vstsURL: $vsts_URL")
WriteLog("agentPool: $agent_Pool")
WriteLog("agentName: $agent_Name")
WriteLog("agenttag: $agent_Tag")


Set-ExecutionPolicy Bypass -Scope Process -Force; 

#Install dotnet core, nodejs and npm with chocolatey
WriteLog("install chocholatey")
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
choco feature enable -n allowGlobalConfirmation;

WriteLog("install dotnetcore")
choco install dotnetcore-sdk -y;

WriteLog("install nodejs")
choco install nodejs -y;

WriteLog("install webdeploy")
choco install webdeploy -y;

WriteLog("download buildagent")

$downloadDirectory = Join-Path $env:SystemDrive 'agent'
New-Item -Path $downloadDirectory -ItemType Directory -force | Out-Null

$clnt = new-object System.Net.WebClient
$url = "https://vstsagentpackage.azureedge.net/agent/2.184.2/vsts-agent-win-x64-2.184.2.zip"
$file = Join-Path $downloadDirectory ([System.IO.Path]::GetFileName($url))
$clnt.DownloadFile($url,$file)

WriteLog("expand build agent")
Expand-Archive -Path $file -DestinationPath $downloadDirectory



WriteLog("install build agent")
#Ersetzt Agent mit dem gleichen Namen im selben Pool
#Agent startet mit Windows Login
#Agent arbeitet als Service
$agentoutput = C:/agent/bin/Agent.Listener.exe configure --url $vsts_URL --agent $agent_Name --pool $agent_Pool  --unattended --auth pat --token $pat_Token  --windowsLogonAccount "NT AUTHORITY\SYSTEM" --replace --runAsService --runAsAutoLogon

WriteLog($agentoutput)