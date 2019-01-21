# Warsaw University of Technology, Faculty of Mechatronics
# Operating Systems project
Add-Type -assembly System.Windows.Forms
Add-Type -assembly System.Drawing
Add-Type -AssemblyName Microsoft.VisualBasic
Add-Type -AssemblyName PresentationFramework

#create main form
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'PowerShell Commander'
$main_form.Width = 1200
$main_form.Height = 600
$height_offset = 60
$width_offset = 20
$main_form.AutoSize = $true
$gbHeight = $main_form.Height - $height_offset
$gbWidth = $main_form.Width / 2 - $width_offset
$main_form.Opacity = 0.94
$main_form.StartPosition = 'CenterScreen'
$main_form.AutoSize = $True
#$main_form.WindowState = $Normal
$main_form.SizeGripStyle = "hide"
$main_form.MinimizeBox = $False
$main_form.MaximizeBox = $False

$icon = New-Object system.drawing.icon(".\PC.ico")
$main_form.Icon = $icon

# textbox: add command box
#$commandBox = New-Object System.Windows.Forms.TextBox
#$command_box_margin = 10
#$commandBox.Location = New-Object System.Drawing.Point($command_box_margin, $gbHeight)
#$commandBox.Size = New-Object System.Drawing.Size(($main_form.width - 3 * $command_box_margin), 20)

#Groupbox : add groupboxL
$groupboxL = New-Object system.Windows.Forms.Groupbox
$groupboxL.Height = $gbHeight
$groupboxL.Width = $gbWidth
$groupboxL.Text = "pane 1"
$groupboxL.location = New-Object System.Drawing.Point(10, 5)

#Groupbox : add groupboxR
$groupboxR = New-Object system.Windows.Forms.Groupbox
$groupboxR.Height = $gbHeight
$groupboxR.Width = $gbWidth
$groupboxR.Text = "pane 2"
$groupboxR.Location = New-Object System.Drawing.Point((20 + $gbWidth), 5)

$path_left = ""
$path_rigth = ""

# TextBox : pathBoxLeft
$pathBoxL = New-Object System.Windows.Forms.TextBox
$pathBoxL.Location = New-Object System.Drawing.Point(15, 20)
$pathBoxL.Size = New-Object System.Drawing.Size(($gbWidth - 40), 20)
$pathBoxL.Width = $groupboxL.Width - $width_offset

# TextBox : pathBoxRight
$pathBoxR = New-Object System.Windows.Forms.TextBox
$pathBoxR.Location = New-Object System.Drawing.Point(15, 20)
$pathBoxR.Size = New-Object System.Drawing.Size(($gbWidth - 40), 20)

#$pathBoxR.selectionMode = "One"
#$pathBoxL.selectionMode = "One"

# ListBox: left Files List
$leftFileList = New-Object System.Windows.Forms.ListBox
$leftFileList.Location = New-Object System.Drawing.Size(10, 40)
$leftFileList.Size = New-Object System.Drawing.Size(($gbWidth - 40), 20)
$leftFileList.location = New-Object System.Drawing.Point(15, 50)
$leftFileList.Height = $gbHeight - $height_offset
$leftFileList.Width = $groupboxL.Width - $width_offset


# ListBox: right Files List
$rightFileList = New-Object System.Windows.Forms.ListBox
$rightFileList.Location = New-Object System.Drawing.Size(10, 40)
$rightFileList.Size = New-Object System.Drawing.Size(($gbWidth - 40), 20)
$rightFileList.location = New-Object System.Drawing.Point(15, 50)
$rightFileList.Height = $gbHeight - $height_offset


function showScriptDir {
    $ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
    $pathBoxL.Text = "$ScriptDir"
	return $ScriptDir
}

function Show-Dir-TxBx-R ($path) {
    $pathBoxR.Text = "$path"
    return $path
}

function Show-Dir-TxBx-L ($path) {
    $pathBoxL.Text = "$path"
    return $path
}

function Show-FilesR ($output) {
    $files = Get-ChildItem -Path "$output"
    [string[]]$tmpArray = @(".")
    $tmpArray += ".."
    foreach ($file in $files) {
        if( $file.Name.Length + $file.Extension.Length -lt 30 ) {
            $str_to_add = "{0,-30} {1,-16} {2,-10} {3,-8}" -f $file.Name, $file.CreationTime, $file.Extension, $file.Length
            $tmpArray += $str_to_add
        } 
        elseif( $file.Name.Length + $file.Extension.Length -ge 30 ) {
            $str_to_add = "{0,-30} {1,-16} {2,-10} {3,-8}" -f $file.Name.Substring(0,30-$file.Extension.Length), $file.CreationTime, $file.Extension, $file.Length
            $tmpArray += $str_to_add
        }
    }
    $rightFileList.DataSource = $tmpArray
#    $rightFileList.Font = "Courier New"
    $rightFileList.Font = "Lucida Sans Typewriter"
}

function Show-Files ($output) {
    $files = Get-ChildItem -Path "$output"
    [string[]]$tmpArray = @(".")
    $tmpArray += ".."
    foreach ($file in $files) {
        if( $file.Name.Length + $file.Extension.Length -lt 30 ) {
            $str_to_add = "{0,-30} {1,-16} {2,-10} {3,-8}" -f $file.Name, $file.CreationTime, $file.Extension, $file.Length
            $tmpArray += $str_to_add
        } 
        elseif( $file.Name.Length + $file.Extension.Length -ge 30 ) {
            $str_to_add = "{0,-30} {1,-16} {2,-10} {3,-8}" -f $file.Name.Substring(0,30-$file.Extension.Length), $file.CreationTime, $file.Extension, $file.Length
            $tmpArray += $str_to_add
        }
    }
    $leftFileList.DataSource = $tmpArray
#    $leftFileList.Font = "Courier New"
    $leftFileList.Font = "Lucida Sans Typewriter"
}

#$handler_

$path_left = Show-Files(".")
$path_right = Show-FilesR(".")
Show-Dir-TxBx-L(pwd)
Show-Dir-TxBx-R(pwd)

$leftFileList.Add_keyDown({
    if ($_.KeyCode -eq "Enter") {
<<<<<<< HEAD
        $tmpNameLong = $leftFileList.SelectedItem.ToString()
        $tmpNameArray = $tmpNameLong.Split(" ")
        $tmpPath = $tmpNameArray[0]
        cd $tmpPath
        Show-Files(".")        
        $pathBoxL.Text = pwd
=======
            $tmpPath = $leftFileList.SelectedItem.ToString()
            $actDir = pwd
            $absDir = "$actDir"+"\"+ $tmpPath

            if(Test-Path -Path $absDir -PathType leaf)
            {
                Invoke-Item -Path $absDir
            }
            else
            {            
                cd $tmpPath
                Show-Files(".")        
                $pathBoxL.Text = pwd
            }
>>>>>>> c5982256d22fee94482d2825e8a33d8d1b77849f
    }
})
$rightFileList.Add_keyDown({
    if ($_.KeyCode -eq "Enter") {
<<<<<<< HEAD
        $tmpNameLong = $rightFileList.SelectedItem.ToString()
        $tmpNameArray = $tmpNameLong.Split(" ")
        $tmpPath = $tmpNameArray[0]
        $actDir = pwd
        $tmpPathFull = "$actDir + $tmpPath"
        cd $tmpPath
        Show-FilesR(".")        
        $pathBoxR.Text = pwd
=======
    
            $tmpPath = $rightFileList.SelectedItem.ToString()
            $actDir = pwd
            $absDir = "$actDir"+"\"+ $tmpPath
            
            if(Test-Path -Path $absDir -PathType leaf)
            {
                Invoke-Item -Path $absDir
            }
            else
            {
                cd $tmpPath
                Show-FilesR(".")        
                $pathBoxR.Text = pwd
            }
>>>>>>> c5982256d22fee94482d2825e8a33d8d1b77849f
    }
})
$pathBoxL.Add_KeyDown({
    if ($_.KeyCode -eq "Enter") {
            $path = $pathBoxL.Text
            if(!(Test-Path $path -PathType Container)) {
                [System.Windows.MessageBox]::Show('Path not found')
            }
            else {
                Show-files($path)
            }
         }
})
$pathBoxR.Add_KeyDown({
    if ($_.KeyCode -eq "Enter") {
            $path = $pathBoxP.Text
            if(!(Test-Path $path -PathType Container)) {
                [System.Windows.MessageBox]::Show('Path not found')
            }
            else {
                Show-filesR($path)
            }
         }
})

$groupboxL.Controls.Add($pathBoxL)
$groupboxL.Controls.Add($leftFileList)
$main_form.Controls.AddRange(@($groupboxL,$files))
$groupboxL.Controls.AddRange(@($files))

$groupboxR.Controls.Add($pathBoxR)
$groupboxR.Controls.Add($rightFileList)
$main_form.Controls.AddRange(@($groupboxR,$files))
$groupboxR.Controls.AddRange(@($files))

#$main_form.Controls.Add($commandBox)
#$main_form.Add_Shown({$commandBox.Select()})

$main_form.Add_Shown({$pathBoxL.Select()})
$main_form.Add_Shown({$pathBoxR.Select()})

$result = $main_form.ShowDialog()
