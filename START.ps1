Add-Type -assembly System.Windows.Forms
Add-Type -assembly System.Drawing

function showScriptDir
{
    $ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
	return $ScriptDir
}

$start_form = New-Object System.Windows.Forms.Form
$start_form.Text = 'Total Commander'
$start_form.Size = New-Object System.Drawing.Size(400,250)
$start_form.StartPosition = 'CenterScreen'
$start_form.FormBorderStyle = 'FixedDialog'


$ScriptDir = showScriptDir
$imgPath = '\TC.png'

$Path = $ScriptDir + $imgPath
 
$img = [System.Drawing.Image]::Fromfile($Path)
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Location = New-Object System.Drawing.Point(10,10)
$pictureBox.Width = 40
$pictureBox.Height = 40
$pictureBox.Image = $img
$start_form.controls.add($pictureBox)

$labelUpperBig = New-Object System.Windows.Forms.Label
$labelUpperBig.Location = New-Object System.Drawing.Point(50,5)
$labelUpperBig.Size = New-Object System.Drawing.Size(350,25)
$labelUpperBig.Text = "Total Commander version 9.21a"
$labelUpperBig.Font = New-Object System.Drawing.Font("Arial",17,[System.Drawing.FontStyle]::Bold)
$start_form.Controls.Add($labelUpperBig)

$labelUpperSmall = New-Object System.Windows.Forms.Label
$labelUpperSmall.Location = New-Object System.Drawing.Point(50,35)
$labelUpperSmall.Size = New-Object System.Drawing.Size(350,20)
$labelUpperSmall.Text = "Copyleft 1993-2018 by Krystecka Inc. - All Rights Reserved"
$labelUpperSmall.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Bold)
$start_form.Controls.Add($labelUpperSmall)

$1button = New-Object System.Windows.Forms.Button
$1button.Location = New-Object System.Drawing.Point(75,170)
$1button.Size = New-Object System.Drawing.Size(75,23)
$1button.Text = '1'
$1button.DialogResult = [System.Windows.Forms.DialogResult]::OK
$start_form.AcceptButton = $1button
$start_form.Controls.Add($1button)


$2button = New-Object System.Windows.Forms.Button
$2button.Location = New-Object System.Drawing.Point(160,170)
$2button.Size = New-Object System.Drawing.Size(75,23)
$2button.Text = '2'
$2button.DialogResult = [System.Windows.Forms.DialogResult]::OK
$start_form.AcceptButton = $2button
$start_form.Controls.Add($2button)

$3button = New-Object System.Windows.Forms.Button
$3button.Location = New-Object System.Drawing.Point(245,170)
$3button.Size = New-Object System.Drawing.Size(75,23)
$3button.Text = '3'
$3button.DialogResult = [System.Windows.Forms.DialogResult]::OK
$start_form.AcceptButton = $3button
$start_form.Controls.Add($3button)

$progInfoButton = New-Object System.Windows.Forms.Button
$progInfoButton.Location = New-Object System.Drawing.Point(10,120)
$progInfoButton.Size = New-Object System.Drawing.Size(180,23)
$progInfoButton.Text = 'Program Information'
$start_form.Controls.Add($progInfoButton)

$regInfoButton = New-Object System.Windows.Forms.Button
$regInfoButton.Location = New-Object System.Drawing.Point(200,120)
$regInfoButton.Size = New-Object System.Drawing.Size(180,23)
$regInfoButton.Text = 'Registration Information'
$start_form.Controls.Add($regInfoButton)


$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,60)
$label.Size = New-Object System.Drawing.Size(380,50)
$label.Text = "This program is Shareware, i.e. you can test this fully functional demo version for one month. After this trial period you must register or delete the program from your hard disk. You may also freely redistribute this program. Please press Registration info for further information."
$start_form.Controls.Add($label)

$rand = Get-Random -InputObject 1, 2, 3

$pressLabel = New-Object System.Windows.Forms.Label
$pressLabel.Location = New-Object System.Drawing.Point(70,150)
$pressLabel.Size = New-Object System.Drawing.Size(350,20)
$pressLabel.Text = "Please press button Nr.$rand to start the program!"
$pressLabel.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Bold)

$start_form.Controls.Add($pressLabel)

$start_form.Topmost = $true


$result = $start_form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)

{

Write-Host = "review"
.\WinForms.ps1

}

Else

{

Write-Host = "Ignore"

}