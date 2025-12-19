param (
    [string]$Namespace
)

while ($true) {
    Clear-Host
    Write-Host "-- $(Get-Date)"
    Write-Host "--"

    if ([string]::IsNullOrEmpty($Namespace)) {
        Write-Host "-- Estado de los namespaces del proyecto"
        
        Write-Host "`n[ARAVACA-P5]" -ForegroundColor Cyan
        minikube kubectl -- get pod,svc,ing -n aravaca-p5 | Out-String | Write-Host
        
        Write-Host "`n[CASTILLA-P5]" -ForegroundColor Cyan
        minikube kubectl -- get pod,svc,ing -n castilla-p5 | Out-String | Write-Host
        
        Write-Host "`n[MADRID-P5]" -ForegroundColor Cyan
        minikube kubectl -- get pod,svc,ing -n madrid-p5 | Out-String | Write-Host
    } else {
        Write-Host "-- Recursos desplegados en el namespace $Namespace"
        minikube kubectl -- get cm,pods,services,rs,deployment -o wide -n $Namespace | Out-String | Write-Host
    }
    
    Start-Sleep -Seconds 5
}
