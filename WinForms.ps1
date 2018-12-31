Add-Type -assembly System.Windows.Forms

$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'PowerShell Commander'
$main_form.Width = 600
$main_form.Height = 400
$main_form.AutoSize = $true
$gbHeight = $main_form.Height

$groupboxL = New-Object system.Windows.Forms.Groupbox
$groupboxL.Height = $gbHeight
$groupboxL.Width = $main_form.Width / 2
$groupboxL.Text = "pane L"
$groupboxL.location = New-Object System.Drawing.Point(0,0)

$main_form.controls.AddRange(@($groupboxL,$files))
$groupboxL.Controls.AddRange(@($files))

$groupboxR = New-Object system.Windows.Forms.Groupbox
$groupboxR.Height = $gbHeight
$groupboxR.Width = $main_form.Width / 2
$groupboxR.Text = "pane R"
$position = $main_form.Width / 2
$groupboxR.location = New-Object System.Drawing.Point($position,0)

$main_form.controls.AddRange(@($groupboxR,$files))
$groupboxR.Controls.AddRange(@($files))

$main_form.ShowDialog()

