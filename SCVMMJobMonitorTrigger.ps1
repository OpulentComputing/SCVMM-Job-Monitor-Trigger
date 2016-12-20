<# 
Monitor SCVMM for COMPLETED SUCCESSFULL jobs.
Microsoft System Center VMM Job Monitor Trigger script allows for easy automation activities on SCVMM jobs. 
This was written as an alternative to Service Management Automation (SMA) in a Windows Azure Pack (WAP) environment because SMA was not going to be implemented in WAP. 
The only dependency is System Center Virtual Machine Monitor. 
Script was developed and tested with SC VMM 2012 R2.  

Created by: Nick Conder Opulent Computing
Change Log:
10/03/2016 v1.00 - Base template complete
Monitors SC VMM jobs for Delete, Modified, New Cloud VM, and New VM monitoring
#>
 
Import-module virtualmachinemanager
$vmmServer = "VMMSERVER OF CHOICE" ###UPDATE###
Get-SCVMMServer -ComputerName $vmmServer -SetAsDefault  | Out-Null
 
# Set infinite loop sleep time in seconds
$sleep = 1198 ###UPDATE###
 
# Start infinite loop
While($true)
{
 
# Set sleep for infinite loop.
Start-Sleep -Seconds $sleep
 
# Set date to match scvmm format
$date = get-date
$cdate = $date.ToString("MM/dd/yyy hh:mm:ss tt")
#$cdate
# Set range in minutes to monitor for a COMPLETED SUCESSFULL job
$cdate2 = $date.AddMinutes(-20) ###UPDATE###
$cdate2 = $cdate2.ToString("MM/dd/yyy hh:mm:ss tt")
#$cdate2
 
# Get all completed successful jobs in a time range.
$ModVMMJob = Get-scjob -Full | where {$_.CmdletName -eq "Set-SCVirtualMachine" -and $_.Progress -eq "100 %" -and $_.Name -EQ "Change properties of virtual machine" -and ` 
$_.status -match "Completed"} | where {$_.EndTime -gt $cdate2} | Select-Object -Property ID,Owner,Description,Progress,ResultName,ResultObjectTypeName,EndTime
$DelVMMJob = Get-scjob -Full | where {$_.CmdletName -eq "Remove-SCVirtualMachine" -and $_.Progress -eq "100 %" -and $_.Name -EQ "Remove virtual machine" -and `
$_.status -match "Completed"} | where {$_.EndTime -gt $cdate2} | Select-Object -Property ID,Owner,Description,Progress,ResultName,ResultObjectTypeName,EndTime
$NewVMMJob = Get-scjob -Full | where {$_.CmdletName -eq "New-SCVirtualMachine" -and $_.Progress -eq "100 %" -and $_.Name -EQ "Create virtual machine" -and `
$_.status -match "Completed"} | where {$_.EndTime -gt $cdate2} | Select-Object -Property ID,Owner,Description,Progress,ResultName,ResultObjectTypeName,EndTime
$NewCloudVMMJob = Get-scjob -Full | where {$_.CmdletName -eq "New-SCVirtualMachine" -and $_.Progress -eq "100 %" -and $_.Name -EQ "Create virtual machine in cloud" -and `
$_.status -match "Completed"} | where {$_.EndTime -gt $cdate2} | Select-Object -Property ID,Owner,Description,Progress,ResultName,ResultObjectTypeName,EndTime
        
 
Foreach ($ID in $ModVMMJob){        
        
        IF([string]::IsNullOrEmpty($ModVMMJob)) {    
        
        Write-Host "Your string VMMJob is EMPTY or NULL"            
        } 
        
        else {            
        
        $ModVMMJob
             
        }
    }

Foreach ($ID in $DelVMMJob){        
        
        IF([string]::IsNullOrEmpty($DelVMMJob)) {    
        
        Write-Host "Your string VMMJob is EMPTY or NULL"            
        } 
        
        else {            
        
        $DelVMMJob
        
        }
    }

Foreach ($ID in $NewVMMJob){        
        
        IF([string]::IsNullOrEmpty($NewVMMJob)) {    
        
        Write-Host "Your string VMMJob is EMPTY or NULL"            
        } 
        
        else {            
        
        $NewVMMJob
         
        }
    }

Foreach ($ID in $NewCloudVMMJob){        
        
        IF([string]::IsNullOrEmpty($NewCloudVMMJob)) {    
        
        Write-Host "Your string VMMJob is EMPTY or NULL"            
        } 
        
        else {            
        
        $NewCloudVMMJob
        
        }
    }
}
Contact GitHub API Training Shop Blog About
© 2016 GitHub, Inc. Terms Privacy Security Status Help
