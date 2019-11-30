#To create a new variable
New-Variable -Name myVar -Value "Hello World"
$a = 'Hello World'

#To assign object emitted from a cmdlet to a variable
Get-Process -Name explorer -OutVariable myVar

#variable names must begin with $ character. Best practices: var name should include alphanumeric and underscores
$myVar

#To get help on any command
Get-Help -Name Get-Command

#To remove a variable
Remove-Variable -Name myVar

#To create readonly or constant var (readonly and constant cannot be reassigned)
New-Variable -Name testVar -Option ReadOnly
New-Variable -Name testVar2 -Option Constant

#To get a list of currently defined variables in the session
Get-Variable 

#To get the type of a variable
$myVar.GetType()

#powershell variables are weakly typed, if you want to ensure strong typed variables, use [] cast operator
[int]$testVar = 23

#Automatic varibles: created and maintained by powershell (Get-Help Automatic_Variables)
#examples
$null #empty value
$Error #most recent errors
$HOME #full path of user's home directory

#Example to validate user's input (ValidateRange, ValidateInput, ValidateLength)
[ValidateRange(200,300)]$numRange = Read-Host 'Enter a number between 200 and 300' 

#Strings in powershell are of two types; Literal and expandable strings
#literal strings use single quotes - display literally what's inside them
$specialChars = '`,$,",{,&,('

#Expandable strings use double quotes- allow you to expand the contents of a variable within a string
$service = get-service alg
"$service.DisplayName is $service.Status"
result : System.ServiceProcess.ServiceController.DisplayName is System.ServiceProcess.ServiceController.Status

#Sub-expressions denoted by $() : Force processing of an entire statement as a whole
"$($service.DisplayName) is $($service.Status)"
result: Application Layer Gateway Service is Stopped

#Everything in powershell is an object. To get more info on the member, use Get-Member
'Hello-World' | Get-Member
Get-Date | Get-Member  -Static
[System.Environment] | Get-Member -MemberType Method

#To assign the output of a cmdlet to a variable
$cultureDate = Get-Culture

#To verify the datatype of the object use -is, -isNot type operators
$cultureDate -is [DateTime]
False
$cultureDate -isNot [DateTime]
True

#powershell's escape character is backtick denoted by `. 
#Indicates a literal, line continuation, special characters
"Each `n word `n is `n on `n a `n new `n line"

Get-CimInstance -Namespace root/cimv2 -OperationTimeoutSec 10 `
>>             -Query "SELECT * FROM Win32_Service `
>>             WHERE StartMode='Auto' AND State='Stopped'"

#To create a new alias for any cmdlet
New-Alias gh Get-Help

#To implement an automatic check point, set whatif to true
$PSDefaultParameterValues = @{'New*:WhatIf'=$true}

#To clear all default parameter values
$PSDefaultParameterValues = $null