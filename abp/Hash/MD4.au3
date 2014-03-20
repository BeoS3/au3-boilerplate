; -----------------------------------------------------------------------------
; MD4 Hash Machine Code UDF
; Purpose: Provide The Machine Code Version of MD4 Hash Algorithm In AutoIt
; Author: Ward
; -----------------------------------------------------------------------------

#Include-once
#Include <Memory.au3>

Global $_MD4_CodeBuffer, $_MD4_CodeBufferMemory
Global $_MD4_InitOffset, $_MD4_InputOffset, $_MD4_ResultOffset

Global $_HASH_MD4[4] = [16, 88, '_MD4_', '_MD4_']

Func _MD4_Exit()
	$_MD4_CodeBuffer = 0
	_MemVirtualFree($_MD4_CodeBufferMemory, 0, $MEM_RELEASE)
EndFunc

Func _MD4_Startup()
	If Not IsDllStruct($_MD4_CodeBuffer) Then
		If @AutoItX64 Then
			Local $Code = 'kwgAAIkO2+nGBhwZhw4ZEgkE+UdBVydWR1VnVD8dwFNIg+woRBiLSgwIQgiAcgSBKfka8XGPGInIx3kM02kQyTHAjChRFAhZBxhBjVwdD6Yh8BgwYSAuyIl8BiQYjQQDMt5q3lTHFMHAvu5c4RxBAdmYHsM+8yHeCxlGQga3JSJXwRYHK818yw2ZJP66JJsM2FT+MjbAC1Aw55ifDBIB6M8u3tQwEMYTIMth8w1FAdFShCyPMPvPaLG6dBoIFRxeylDYYc80lygcW4mTEFJSy61lC/XgSmLZJvlPXnpsxw8G99m9kihRXyHPUxDYM8rWDPh/WKa6QcfNRfHCuhD7U8rXKDBY+iFt8iFNzdBTuTQ0rUGlSrIEy7ZeO3nCzZshDeax3TjMSTyjZ/QbNQYo0IkMJAx/+M/PjUoOazxoyWwUxgkACc5CjYQomRl5glrG+Zkox3QTCI0ojCkUzLLORP7Q5rIbAfAM5v/NHsZ7uzAyR24gEiwgkAF28dujdD33BWyqgDmEQ0Vs+UDw3wwbQXU7iAnCc6oZDcxyArV0Q+5l63QNSIwwSJ2imod+ICVoFPWDsfSMMQkUkVGOi0KD0CUrDIWUR0vQl5qWNImBJgRci0KmTISd0Zh+kJ30UYqbkZBk8xmLFtGWVxllgBgnILkfFjLdEUcX2RgiFLRUjReoEIXRCArxNCRKigCNrCih69lukx7IiaIWjKWsHKQZQjEoIRpsQRawzauXJCjFZmkTsGYWKMTAZOkSzNQWWSdsCQfsfsjMVuUuwKqTAhfBxWib6Ilv7ypc/EyDihkWvrQPGhKAHcKV7pchKzKti8TkEMaJwyzxdClXI1g17pRC0YgB3WWqpqV9Pizre6xQtZNQoCg6iWVDRXSNG/wY8+8htyomvCBBaRDFihwiphM7yLWfK14y7whEKMyAzr8BbfW8xwxhGIfojJrYWA9StWaabg9cEeQF90oMKFgDbwK1JWoID12Jm7cAPARIg8QoW14OX11BXFsIx28pw0aAH0mJ1ZlUCszn8kxC7+aJHU2FwMGLcVB0X/DmPwNMjXlAQb6fDALrFA1JAagBUEiF/3RG6kQhOfUpUav8Ofs9dgS+/fb+8cyK2Ibq7XEoxAHuA0gp3+h6AgNqg/5AdcgzLPoG4cgw9uh5CXH/rEYpdbqSclAMDEiJ11YIzm9TZPWMHSBJAvh/dn6Dj0FQ6OA/dUBHZhlAMe1A+Zk+4sjpvkR/Pui076qDjQQrBhr4P3fkRDRDwDobwV67QWJnMlQHh4Mm8QFeUJHfIIXDvSHRKcVDsugzMu+Q67nw/ruIM6Kw8dHEAaM0LmgLUOnI0VGXOhhM6jdQhw7gBCQBI0VYZ3J38okzq82Wi2AgGQj+3LpgmBEMdlQyYxCqQUBtMCsT8ymXGNg0EqASKNIKDOYwCtbSBgwaOAps+kCBy13s+cLUwAGg0jjGAwQRgA+GtwXZicFBuCS4DdNrUERmgO8pwDFq0mJpFCKzlHpnBtmyqPiAoPbDAbphOFEPhdmfDUDMxwIU3YxABLOIidGwNwXB6QP2wgG1yfNIq7sqxYAcAnV0g+IB6mqggkNQ0JtTDcHgAw74OOhsULEsQIvzBlAQ/EZvBAywIAhATAzQYs2fIT1Syn+Eg+rp6dElLwi3OIoIrLXowEPobgYl65bGBwodkWbHqsBRg6eg+4Fx66IPJREEQ5MPhGlQhpvbpBUUg+oEGBjpOynGA5IKD3sBsjfNGR0WRT5FAtDpEolWNErPklyAoMH8BfOkX17DIhDQGaoxbIAA'
		Else
			Local $Code = 'TggAAIkA24PsBItEJAjz26DoVQbhw/vE+cIQwYeRLxwbKIk3eRGKBCcgIX4FCByJCR0PHxBHBqBVV1ZhU0JAizjIcgzqKu5awJRKBIl8JB08Af2B9zHfIc/Ts43zPYCLaAQAwccDiWwkOAF27gfdMc0h/U7bFAQsCMHGB080juvI/Zv1CGAULAzBwwuJMPHp2xsk/SFgphTHLBDBFBNPLIzvhfU2Ic0IFMosFFhEKFkk3VhYGIzjHiMcESDn+MQceCSMRxiIKMQUeCyMRxCIMMQMeDSMRwiUPhRAPFuIBHnB6/UjwvB+vxv4IdiPbwyK0kyFPLmNALwHmXmCWonYDgnwIciE6IuQG40EBxnBwAMyLgzOMgneyCEHxobuOwwcjTQ3xgXIOithwwnL0cVHlSfzhus7DQyNHB/M7yE6KZ7xtPYZsj7Z4emDOziNDA8g4A1CKJCKQYgMdCiPRBh6IQjR2aLsdEc0pxj0RxSiBL3oETDoII9EEG4VLCRzuDyFgqHr2W4MJyw5MfAJyAHHJOUc0CuNtAaoGsgxSNj9QYP3ISArMFEMifugkAkxcstmw8IeLlQpJ8HJMxSRL/nL9rZ+Dkh0SWS+Dwg3Yd4xxsnOVKs2b1njoLK4ZAO58A4HaLxSYcLzXFwf5ryGzS84wAJc8RMpqy4XmxiyR8tc3iHxCA+IMHxDEOIgHShrhVtoV2IDMqxZmYn0Abil5wdnQvuAwkBbXl8DXcNVidVXms/jyL+rgMpMhcmLcVAOdHmNQD9L4j+n9DxEXIGK6yIikH6QT3gwZkwIxxhwNN8DNTSAukhQEQBYVIX/dEe+QMAnKdY5/nY6AolRL/H3Y9A/9SRU1TZ36krQRjs9AnPfJYDyg/pAdajKFzwtD+izzv8hMdLrl0KVTDLkWUkswzNIQUB22f7+VH+RHBwPhoAqRPXQQlAFg+A/dUSI3zF7/ybFQEI5D+op+C/vJuhkn6EcN+/oP3fq8EYUwInCznXeWcxUE+ouixRhAXK7PXpk4Cwyv5C/idpMKXreB/kB+6H+6OPPEorrotkgsipsBJDCewGA67zScRrNYAM86btAUawQ00sDflBAx5cwASNFZ94O96UPzEJqqzDN7w4I/twgupgGDHZUMhA46wm9iElzJCxiSOCSMEklIJKzUED7KdR8UkPfB8YEA4BywAGFyjgI+aiUuqnA3ynCjWv1QuIDpJYIl5GYSJ5EIVQFUQnkYvmglfbD/LphODMPhbmFDffHAkgMnYCJ0THAwekcAvbCwvOrdXxBHQHVcrnfgFNUD6TCA8Fv4K6pOC9N7DyW6G0ZkzhDXAY/CkSZRgQMSAIIBEwKDK6VIL5IFkWy8pLGKrYZienvKBF5oKaOo4qtNKZgexHrjsYH3wqNZscMRAoRm4QND4R4cEJy6JET6gYsNOlTJYfrBI2BdrI39TqNG1ZX3QJ6EGmMFDGv5C/8BYP5CHInCN4BvwoCpEnoz0EFZqWDQeKJylPn89Uf8A7hA+ak6xboXxlew1d3EBAwD7aglQxpkF7ZA60IkHQDggqqSZAKdfapP/whJAhAqjBfwwA='
		EndIf
		Local $Opcode = String(_MD4_CodeDecompress($Code))
		$_MD4_InitOffset = (StringInStr($Opcode, "89DB") - 3) / 2
		$_MD4_InputOffset = (StringInStr($Opcode, "87DB") - 3) / 2
		$_MD4_ResultOffset = (StringInStr($Opcode, "09DB") - 3) / 2
		$Opcode = Binary($Opcode)

		$_MD4_CodeBufferMemory = _MemVirtualAlloc(0, BinaryLen($Opcode), $MEM_COMMIT, $PAGE_EXECUTE_READWRITE)
		$_MD4_CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]", $_MD4_CodeBufferMemory)
		DllStructSetData($_MD4_CodeBuffer, 1, $Opcode)
		OnAutoItExitRegister("_MD4_Exit")
	EndIf
EndFunc

Func _MD4Init()
	If Not IsDllStruct($_MD4_CodeBuffer) Then _MD4_Startup()

	Local $Context = DllStructCreate("byte[" & $_HASH_MD4[1] & "]")
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($_MD4_CodeBuffer) + $_MD4_InitOffset, _
													"ptr", DllStructGetPtr($Context), _
													"int", 0, _
													"int", 0, _
													"int", 0)

	Return $Context
EndFunc

Func _MD4Input(ByRef $Context, $Data)
	If Not IsDllStruct($_MD4_CodeBuffer) Then _MD4_Startup()
	If Not IsDllStruct($Context) Then Return SetError(1, 0, 0)

	$Data = Binary($Data)
	Local $InputLen = BinaryLen($Data)
	Local $Input = DllStructCreate("byte[" & $InputLen & "]")
	DllStructSetData($Input, 1, $Data)
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($_MD4_CodeBuffer) + $_MD4_InputOffset, _
													"ptr", DllStructGetPtr($Context), _
													"ptr", DllStructGetPtr($Input), _
													"uint", $InputLen, _
													"int", 0)
EndFunc

Func _MD4Result(ByRef $Context)
	If Not IsDllStruct($_MD4_CodeBuffer) Then _MD4_Startup()
	If Not IsDllStruct($Context) Then Return SetError(1, 0, "")

	Local $Digest = DllStructCreate("byte[" & $_HASH_MD4[0] & "]")
	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($_MD4_CodeBuffer) + $_MD4_ResultOffset, _
													"ptr", DllStructGetPtr($Context), _
													"ptr", DllStructGetPtr($Digest), _
													"int", 0, _
													"int", 0)
	Return DllStructGetData($Digest, 1)
EndFunc

Func _MD4($Data)
	Local $Context = _MD4Init()
	_MD4Input($Context, $Data)
	Return _MD4Result($Context)
EndFunc

Func _MD4_CodeDecompress($Code)
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