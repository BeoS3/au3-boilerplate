; -----------------------------------------------------------------------------
; SHA384/512 Hash Machine Code UDF
; Purpose: Provide The Machine Code Version of SHA384/512 Hash Algorithm In AutoIt
; Author: Ward
; -----------------------------------------------------------------------------

#Include-once
#Include <Memory.au3>

Global $_SHA384_512_CodeBuffer, $_SHA384_512_CodeBufferMemory
Global $_SHA384_InitOffset, $_SHA384_InputOffset, $_SHA384_ResultOffset
Global $_SHA512_InitOffset, $_SHA512_InputOffset, $_SHA512_ResultOffset

Global $_HASH_SHA384[4] = [48, 200, '_SHA384_', '_SHA384_512_']
Global $_HASH_SHA512[4] = [64, 200, '_SHA512_', '_SHA384_512_']

Func _SHA384_512_Exit()
	$_SHA384_512_CodeBuffer = 0
	_MemVirtualFree($_SHA384_512_CodeBufferMemory, 0, $MEM_RELEASE)
EndFunc

Func _SHA384_512_Startup()
	If Not IsDllStruct($_SHA384_512_CodeBuffer) Then
		If @AutoItX64 Then
			Local $Code = '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'
				$Code &= 'XZ27ywCgB9V8NioUKZpimQAX3XAwWgFZU5G4Hrk5Rw732JMvFSmAkbiAuDELwP9nOSYzwFh0CIseihEVgWiHSrSOAKeP+QRkDS4M2wCkT/q+HRVItUewIhhFIBG4WDDyF+QGIa77Hy7ox0AirijXAJgvikLNZe8jD5FEN3FgO03sz/sBwLW824mBpdO56TjoSPMAW8JWORnQBbY58REPWZtPQK+kgj+SABiBbdrVXhyrAEICA6OYqgfYAL5vcEUBW4MSD4yy5E6AhTEk4rQA/9XDfQxVb4kAe/J0Xb5ysZYdFjv+QN6ANRLHJQCnBtyblCZpzzt08Y7B0kqunr7/gOTjJU84hkcAvu+11YyLxp0AwQ9lnKx3zKEADCR1AitZbywA6S2D5KZuqoQAdErU+0G93KkAsFy1UxGD2ogA+Xar32buUlEAPpgQMrQtbcYHMag/IfvAyCcDsADkDu++x39ZvwDCj6g98wvgxsHqCpNHkdTVbz6CA4BRY8oGcG4OHApnKUAU/C/SRoX0txwnJsmAXDghGy7tACrEWvxtLE3fALOVnRMNOFPeAGOvi1RzCmWoDrJ3PLvganbmru0ARy7JwoE7NYIAFIUscpJkA/EATKHov6IBMEIAvEtmGqiRl/ge0HCLn8LAvlQGo1FsAMcYUu/WGeiSANEQqWVVJAaZ+CoAIHFXhTUO9LgA0bsycKBqEMg90NKAFsGkGVOrQQBRCGw3HpnrjgPfTHdIJ6iZm+EghbAANGNaycWzDBwAOcuKQeNKqtg7TnMAY3dPypxbowC4stbzby5o/O7vAF3ugo90YC8Xf0MAY6V4cqvwoRTsyACE7DlkGggCxwCMKB5jI/r/vgCQ6b2C3utsUACkFXnGsvej+QC+K1Ny4/J4cfqcAGEm6s4+J8oHAMLAIce4htEeAOvgzdZ92up49G4e7n9PQPW6bxdyqgln8AamA1aixfhjCq5nDXgEwD8RG0cHHBM1C3FzhH3wI/V3ANsokyTHQHurAcoyvL7JFQrQnjwATA0QnMRnHUMPtkI+y+fUxfAqfmX8JJwpkQDs+tY6q28Ay18XWEdKjBkFRGxew1bTnc8mBtbNAcH886RfoSIQENDLqoy/AA=='
		Else
			Local $Code = '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'
				$Code &= '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'
				$Code &= 'R0FCS0a7IQZimPo+LuiA/YAirijXmC8AikLNZe8jkUQ9N3GAO03sz/vAtQe824mBpU7n6TigSPNbwgBWORnQBbbxEeRZPZtPAK+kgj+SGIEAbdrVXhyrQgIAA6OYqgfYvm8AcEUBW4MSjLI+5E4AhTEk4rT/1QDDfQxVb4l78gB0Xb5ysZYWO3X+AN6ANRLHJacGANyblCZpz3Tx7sE60kq6nvv+5ADjJU84hke+7wC11YyLxp3BDwBlnKx3zKEMJAB1AitZbyzpLQKD5KZuqoTgUtT7AEG93KmwXLVTABGD2oj5dqvfAGbuUlE+mBAyALQtbcYxqD8hfPsByCcDsOQO7yCjfwBZv8KPqD3zCzDgxuoKk0d1kQ/Vb4IDoFFjygZwB24OCmcpEBT8L9I9RoUHtycmySBcOCEbAC7tKsRa/G0sAE3fs5WdEw04CVPeY6+Aa3MKZagOsnc8u+Bqduau7QBHLsnCgTs1ggAUhSxykmQD8QBMoei/ogEwQgC8S2YaqJGX+B7QcIufwsC+VAajUWwAxxhS79YZ6JIA0RCpZVUkBpn4KgAgcVeFNQ70uADRuzJwoGoQyD3Q0oAWwaQZU6tBAlEIbDcemeDr30wOd0gnqGSb4YCFsDRjAFrJxbMMHDnLAIpB40qq2E5z7GMAd0/KnFujuLID1vNvLmj8uO9d7gGCj3RgLxdD/GOlA3hyq/ChFLDIhOwAOWQaCALHjCgSHmMjAPm+kOm9ggDe62xQpBV5xgCy96P5vitTcg/j8nhxoJxhJurOAD4nygfCwCHHALiG0R7r4M3WD33a6nhBbu5/T+T1ugBvF3KqZ/AGppBWP6LFhmMKrg14fAQAPxEbRxwTNQt3cT+EfQEj9XfbKJMwbkAAe6vKMry+yRV0CgCePEwNEJzEZwMdQ7ZCPsv51MX8Kn4JZfycKQCR7PrWOgCrb8tfF1hHSgCMGURsXsNWV55SHQwddCwlY4XJyC/8gwv5CHInCanDPofhAqRJOKbegQVmpYPp/InKnKUtwU/R8OED7qRu6xaMX4hXyHcQhTAPttAEacAB2QOtCJB0A4IKqkmQCnX2qD/881KrQAyqX8MA'
		EndIf
		Local $Opcode = String(_SHA384_512_CodeDecompress($Code))
		$_SHA384_InitOffset = (StringInStr($Opcode, "89DB") - 3) / 2
		$_SHA384_InputOffset = (StringInStr($Opcode, "87DB") - 3) / 2
		$_SHA384_ResultOffset = (StringInStr($Opcode, "09DB") - 3) / 2
		$_SHA512_InitOffset = (StringInStr($Opcode, "89C9") - 3) / 2
		$_SHA512_InputOffset = (StringInStr($Opcode, "87C9") - 3) / 2
		$_SHA512_ResultOffset = (StringInStr($Opcode, "09C9") - 3) / 2
		$Opcode = Binary($Opcode)

		$_SHA384_512_CodeBufferMemory = _MemVirtualAlloc(0, BinaryLen($Opcode), $MEM_COMMIT, $PAGE_EXECUTE_READWRITE)
		$_SHA384_512_CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]", $_SHA384_512_CodeBufferMemory)
		DllStructSetData($_SHA384_512_CodeBuffer, 1, $Opcode)
		OnAutoItExitRegister("_SHA384_512_Exit")
	EndIf
EndFunc

Func _SHA384Init()
	If Not IsDllStruct($_SHA384_512_CodeBuffer) Then _SHA384_512_Startup()

	Local $Context = DllStructCreate("byte[" & $_HASH_SHA384[1] & "]")
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($_SHA384_512_CodeBuffer) + $_SHA384_InitOffset, _
													"ptr", DllStructGetPtr($Context), _
													"int", 0, _
													"int", 0, _
													"int", 0)

	Return $Context
EndFunc

Func _SHA512Init()
	If Not IsDllStruct($_SHA384_512_CodeBuffer) Then _SHA384_512_Startup()

	Local $Context = DllStructCreate("byte[" & $_HASH_SHA384[1] & "]")
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($_SHA384_512_CodeBuffer) + $_SHA512_InitOffset, _
													"ptr", DllStructGetPtr($Context), _
													"int", 0, _
													"int", 0, _
													"int", 0)

	Return $Context
EndFunc

Func _SHA384Input(ByRef $Context, $Data)
	If Not IsDllStruct($_SHA384_512_CodeBuffer) Then _SHA384_512_Startup()
	If Not IsDllStruct($Context) Then Return SetError(1, 0, 0)

	$Data = Binary($Data)
	Local $InputLen = BinaryLen($Data)
	Local $Input = DllStructCreate("byte[" & $InputLen & "]")
	DllStructSetData($Input, 1, $Data)
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($_SHA384_512_CodeBuffer) + $_SHA384_InputOffset, _
													"ptr", DllStructGetPtr($Context), _
													"ptr", DllStructGetPtr($Input), _
													"uint", $InputLen, _
													"int", 0)
EndFunc

Func _SHA512Input(ByRef $Context, $Data)
	If Not IsDllStruct($_SHA384_512_CodeBuffer) Then _SHA384_512_Startup()
	If Not IsDllStruct($Context) Then Return SetError(1, 0, 0)

	$Data = Binary($Data)
	Local $InputLen = BinaryLen($Data)
	Local $Input = DllStructCreate("byte[" & $InputLen & "]")
	DllStructSetData($Input, 1, $Data)
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($_SHA384_512_CodeBuffer) + $_SHA512_InputOffset, _
													"ptr", DllStructGetPtr($Context), _
													"ptr", DllStructGetPtr($Input), _
													"uint", $InputLen, _
													"int", 0)
EndFunc

Func _SHA384Result(ByRef $Context)
	If Not IsDllStruct($_SHA384_512_CodeBuffer) Then _SHA384_512_Startup()
	If Not IsDllStruct($Context) Then Return SetError(1, 0, "")

	Local $Digest = DllStructCreate("byte[" & $_HASH_SHA384[0] & "]")
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($_SHA384_512_CodeBuffer) + $_SHA384_ResultOffset, _
													"ptr", DllStructGetPtr($Context), _
													"ptr", DllStructGetPtr($Digest), _
													"int", 0, _
													"int", 0)
	Return DllStructGetData($Digest, 1)
EndFunc

Func _SHA512Result(ByRef $Context)
	If Not IsDllStruct($_SHA384_512_CodeBuffer) Then _SHA384_512_Startup()
	If Not IsDllStruct($Context) Then Return SetError(1, 0, "")

	Local $Digest = DllStructCreate("byte[" & $_HASH_SHA512[0] & "]")
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($_SHA384_512_CodeBuffer) + $_SHA512_ResultOffset, _
													"ptr", DllStructGetPtr($Context), _
													"ptr", DllStructGetPtr($Digest), _
													"int", 0, _
													"int", 0)
	Return DllStructGetData($Digest, 1)
EndFunc

Func _SHA384($Data)
	Local $Context = _SHA384Init()
	_SHA384Input($Context, $Data)
	Return _SHA384Result($Context)
EndFunc

Func _SHA512($Data)
	Local $Context = _SHA512Init()
	_SHA512Input($Context, $Data)
	Return _SHA512Result($Context)
EndFunc

Func _SHA384_512_CodeDecompress($Code)
	If @AutoItX64 Then
		Local $Opcode = '0x89C04150535657524889CE4889D7FCB28031DBA4B302E87500000073F631C9E86C000000731D31C0E8630000007324B302FFC1B010E85600000010C073F77544AAEBD3E85600000029D97510E84B000000EB2CACD1E8745711C9EB1D91FFC8C1E008ACE8340000003D007D0000730A80FC05730783F87F7704FFC1FFC141904489C0B301564889FE4829C6F3A45EEB8600D275078A1648FFC610D2C331C9FFC1E8EBFFFFFF11C9E8E4FFFFFF72F2C35A4829D7975F5E5B4158C389D24883EC08C70100000000C64104004883C408C389F64156415541544D89CC555756534C89C34883EC20410FB64104418800418B3183FE010F84AB00000073434863D24D89C54889CE488D3C114839FE0F84A50100000FB62E4883C601E8C601000083ED2B4080FD5077E2480FBEED0FB6042884C00FBED078D3C1E20241885500EB7383FE020F841C01000031C083FE03740F4883C4205B5E5F5D415C415D415EC34863D24D89C54889CE488D3C114839FE0F84CA0000000FB62E4883C601E86401000083ED2B4080FD5077E2480FBEED0FB6042884C078D683E03F410845004983C501E964FFFFFF4863D24D89C54889CE488D3C114839FE0F84E00000000FB62E4883C601E81D01000083ED2B4080FD5077E2480FBEED0FB6042884C00FBED078D389D04D8D7501C1E20483E03041885501C1F804410845004839FE747B0FB62E4883C601E8DD00000083ED2B4080FD5077E6480FBEED0FB6042884C00FBED078D789D0C1E2064D8D6E0183E03C41885601C1F8024108064839FE0F8536FFFFFF41C7042403000000410FB6450041884424044489E84883C42029D85B5E5F5D415C415D415EC34863D24889CE4D89C6488D3C114839FE758541C7042402000000410FB60641884424044489F04883C42029D85B5E5F5D415C415D415EC341C7042401000000410FB6450041884424044489E829D8E998FEFFFF41C7042400000000410FB6450041884424044489E829D8E97CFEFFFF56574889CF4889D64C89C1FCF3A45F5EC3E8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFFFEFFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F3031323358C3'
	Else
		Local $Opcode = '0x89C0608B7424248B7C2428FCB28031DBA4B302E86D00000073F631C9E864000000731C31C0E85B0000007323B30241B010E84F00000010C073F7753FAAEBD4E84D00000029D97510E842000000EB28ACD1E8744D11C9EB1C9148C1E008ACE82C0000003D007D0000730A80FC05730683F87F770241419589E8B3015689FE29C6F3A45EEB8E00D275058A164610D2C331C941E8EEFFFFFF11C9E8E7FFFFFF72F2C32B7C2428897C241C61C389D28B442404C70000000000C6400400C2100089F65557565383EC1C8B6C243C8B5424388B5C24308B7424340FB6450488028B550083FA010F84A1000000733F8B5424388D34338954240C39F30F848B0100000FB63B83C301E8CD0100008D57D580FA5077E50FBED20FB6041084C00FBED078D78B44240CC1E2028810EB6B83FA020F841201000031C083FA03740A83C41C5B5E5F5DC210008B4C24388D3433894C240C39F30F84CD0000000FB63B83C301E8740100008D57D580FA5077E50FBED20FB6041084C078DA8B54240C83E03F080283C2018954240CE96CFFFFFF8B4424388D34338944240C39F30F84D00000000FB63B83C301E82E0100008D57D580FA5077E50FBED20FB6141084D20FBEC278D78B4C240C89C283E230C1FA04C1E004081189CF83C70188410139F374750FB60383C3018844240CE8EC0000000FB654240C83EA2B80FA5077E00FBED20FB6141084D20FBEC278D289C283E23CC1FA02C1E006081739F38D57018954240C8847010F8533FFFFFFC74500030000008B4C240C0FB60188450489C82B44243883C41C5B5E5F5DC210008D34338B7C243839F3758BC74500020000000FB60788450489F82B44243883C41C5B5E5F5DC210008B54240CC74500010000000FB60288450489D02B442438E9B1FEFFFFC7450000000000EB9956578B7C240C8B7424108B4C241485C9742FFC83F9087227F7C7010000007402A449F7C702000000740566A583E90289CAC1E902F3A589D183E103F3A4EB02F3A45F5EC3E8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFFFEFFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F3031323358C3'
	EndIf
	Local $AP_Decompress = (StringInStr($Opcode, "89C0") - 3) / 2
	Local $B64D_Init = (StringInStr($Opcode, "89D2") - 3) / 2
	Local $B64D_DecodeData = (StringInStr($Opcode, "89F6") - 3) / 2
	$Opcode = Binary($Opcode)

	Local $CodeBufferMemory = _MemVirtualAlloc(0, BinaryLen($Opcode), $MEM_COMMIT, $PAGE_EXECUTE_READWRITE)
	Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]", $CodeBufferMemory)
	DllStructSetData($CodeBuffer, 1, $Opcode)

	Local $B64D_State = DllStructCreate("byte[16]")
	Local $Length = StringLen($Code)
	Local $Output = DllStructCreate("byte[" & $Length & "]")

	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer) + $B64D_Init, _
													"ptr", DllStructGetPtr($B64D_State), _
													"int", 0, _
													"int", 0, _
													"int", 0)

	DllCall("user32.dll", "int", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer) + $B64D_DecodeData, _
													"str", $Code, _
													"uint", $Length, _
													"ptr", DllStructGetPtr($Output), _
													"ptr", DllStructGetPtr($B64D_State))

	Local $ResultLen = DllStructGetData(DllStructCreate("uint", DllStructGetPtr($Output)), 1)
	Local $Result = DllStructCreate("byte[" & ($ResultLen + 16) & "]")

	Local $Ret = DllCall("user32.dll", "uint", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer) + $AP_Decompress, _
													"ptr", DllStructGetPtr($Output) + 4, _
													"ptr", DllStructGetPtr($Result), _
													"int", 0, _
													"int", 0)


	_MemVirtualFree($CodeBufferMemory, 0, $MEM_RELEASE)
	Return BinaryMid(DllStructGetData($Result, 1), 1, $Ret[0])
EndFunc