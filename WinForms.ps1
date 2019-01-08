Add-Type -assembly System.Windows.Forms
Add-Type -assembly System.Drawing
Add-Type -AssemblyName Microsoft.VisualBasic
Add-Type -AssemblyName PresentationFramework

$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'PowerShell Commander'
$main_form.Width = 1000
$main_form.Height = 600
$main_form.AutoSize = $true
$gbHeight = $main_form.Height - 60
$gbWidth = $main_form.Width / 2-20

#Add groupBox
$groupboxL = New-Object system.Windows.Forms.Groupbox
$groupboxL.Height = $gbHeight
$groupboxL.Width = $gbWidth
$groupboxL.Text = "pane L"
$groupboxL.location = New-Object System.Drawing.Point(10, 5)


$groupboxP = New-Object system.Windows.Forms.Groupbox
$groupboxP.Height = $gbHeight
$groupboxP.Width = $gbWidth
$groupboxP.Text = "pane P"
$groupboxP.Location = New-Object System.Drawing.Point((20+ $gbWidth), 5)


#Add pathBox
$pathBoxL = New-Object System.Windows.Forms.TextBox
$pathBoxL.Location = New-Object System.Drawing.Point(15,20)
$pathBoxL.Size = New-Object System.Drawing.Size(($gbWidth - 40),20)

$pathBoxP = New-Object System.Windows.Forms.TextBox
$pathBoxP.Location = New-Object System.Drawing.Point(15,20)
$pathBoxP.Size = New-Object System.Drawing.Size(($gbWidth - 40),20)

$leftFileList = New-Object System.Windows.Forms.ListBox
$leftFileList.Location = New-Object System.Drawing.Size(10,40)
$leftFileList.Size = New-Object System.Drawing.Size(($gbWidth - 40),20)
$leftFileList.location = New-Object System.Drawing.Point(15,50)
$leftFileList.Height = $gbHeight - 60
$leftFileList.Width = $groupboxL.Width - 40

$rightFileList = New-Object System.Windows.Forms.ListBox
$rightFileList.Location = New-Object System.Drawing.Size(10,40)
$rightFileList.Size = New-Object System.Drawing.Size(($gbWidth - 40),20)
$rightFileList.location = New-Object System.Drawing.Point(15,50)
$rightFileList.Height = $gbHeight - 60

function Show-Files ($output) {
    $files = Get-ChildItem -Path "$output"
    $leftFileList.Items.Clear();
    $leftFileList.Items.Add(".")
    $leftFileList.Items.Add("..")    
    foreach ($file in $files) {    
       $leftFileList.Items.Add($file.Name)
    }
}

Show-Files(".")

$leftFileList.Add_keyDown({
    if ($_.KeyCode -eq "Enter") {
        $tmpPath = $leftFileList.SelectedItem.ToString($tmpPath)
        cd $tmpPath
        Show-files(".")        
    }
})
$pathBoxL.Add_KeyDown({
    if ($_.KeyCode -eq "Enter") {
            $path = $pathBoxL.Text
            
            if(!(Test-Path $path -PathType Container))
            {
                [System.Windows.MessageBox]::Show('Path not found')
            }
            else
            {
                Show-files($path)
            }
         }
})


$groupboxL.Controls.Add($pathBoxL)
$groupboxL.Controls.Add($leftFileList)
$main_form.Controls.AddRange(@($groupboxL,$files))
$groupboxL.Controls.AddRange(@($files))

$groupboxP.Controls.Add($pathBoxP)
$groupboxP.Controls.Add($rightFileList)
$main_form.Controls.AddRange(@($groupboxP,$files))
$groupboxP.Controls.AddRange(@($files))

$main_form.Add_Shown({$pathBoxL.Select()})

$main_form.Add_Shown({$pathBoxP.Select()})

function showScriptDir
{
    $ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
    $pathBoxL.Text = "$ScriptDir"
}
showScriptDir

$result = $main_form.ShowDialog()


