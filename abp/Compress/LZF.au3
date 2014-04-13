; -----------------------------------------------------------------------------
; LZF Compression Machine Code UDF
; Purpose: Provide The Machine Code Version of LZF Algorithm In AutoIt
; Author: Ward
; LZF Copyright (C) 2000-2007 Marc Alexander Lehmann <schmorp@schmorp.de>
; -----------------------------------------------------------------------------

#Include-once
#Include <Memory.au3>

Global $_LZF_CodeBuffer, $_LZF_CodeBufferMemory, $_LZF_Compress, $_LZF_Decompress

Func _LZF_Exit()
	$_LZF_CodeBuffer = 0
	_MemVirtualFree($_LZF_CodeBufferMemory, 0, $MEM_RELEASE)
EndFunc

Func _LZF_Startup()
	If Not IsDllStruct($_LZF_CodeBuffer) Then
		If @AutoItX64 Then
			Local $Opcode = '0x89C04883EC38488B41084C894C2420488B094589C14989C0E81E0000004883C438C389DB4883EC084589C14C8B4108488B094883C408E94404000041574156415541544589CC4F8D2420555756534883EC184585C9488BB424800000000F841602000085D20F840E02000089D20FB6014D8D48014C8D3C110FB651014531DB418D5FFE498D6FFEC1E00809C2895C240C4889C8EB28EB01904D39E10F83D80100000FB6184183C3014883C0014188194983C1014183FB200F84710200004839E80F834E01000089D30FB650024C8D5002C1E30809DA8D3C9289D3C1EB0829FB81E3FFFF0000488D1CDE488B3B488903488D58FF4829FB4881FBFF1F000077994839F94C8D680473904D39FD738B440FB73766443B307581440FB67702453A320F8573FFFFFF498D51044939D40F8635010000448B54240CBA08010000458D73FF4129C24181FA08010000440F47D24489DAF7D24863D24588341131D24585DB0F94C24929D14183FA100F86FE010000440FB67703BA0200000041BB20000000443A70030F84030100004883C0014889DF48C1EF084101FB4588194983C1014801D04188194983C1024839E80F839F0100000FB658FE0FB650FF4C8D50FE498D7A01C1E30809DA0FB618C1E20809DA448D1C9289D3C1E208C1EB084429DB4531DB81E3FFFF00004C8914DE0FB65F0209DA89D3448D1492C1EB084429D381E3FFFF00004839E848893CDE0F82B7FEFFFFEB03909090498D51034939D4725C4C39F8732390900FB6104183C3014883C0014188114983C1014183FB200F84FF0000004939C777DF4489D8418D53FFF7D048984188140131C04585DB0F94C04929C14489C84429C0EB144585DB750D498D51034939D40F87B9FEFFFF31C04883C4185B5E5F5D415C415D415E415FC3440FB67704B20341BB40000000453A75000F85E6FEFFFF440FB66F05B20441BB60000000443A68050F85CFFEFFFF440FB66F06B20541BB80FFFFFF443A68060F85B8FEFFFF440FB66F07B20641BBA0FFFFFF443A68070F85A1FEFFFF440FB66F08B20741BBC0FFFFFF443A68080F858AFEFFFF0FB657093A50097450BA0800000031FF4883C0014989DA4188790149C1EA084183EA204588114983C102E970FEFFFF41C641DF1F4530DB4983C101E97EFDFFFF41C641DF1F4530DB4983C101E9F0FEFFFF4531DBE9BCFEFFFF0FB6570A3A500A7442BA09000000BF01000000EBA2BA0200000083C2014139D2760E4189D3460FB62C1F463A2C1874EA448D52FE4883C0014183FA06763D418D7AF9418D5201E970FFFFFF0FB6570B3A500B740FBA0A000000BF02000000E954FFFFFF0FB6570C3A500C7421BA0B000000BF03000000E93CFFFFFF4489D2C1E2054189D3418D5201E9A8FDFFFF0FB6570D3A500D740FBA0C000000BF04000000E912FFFFFF0FB6'
				$Opcode &= '570E3A500E740FBA0D000000BF05000000E9FAFEFFFF0FB6570F3A500F740FBA0E000000BF06000000E9E2FEFFFF0FB657103A5010740FBA0F000000BF07000000E9CAFEFFFF0FB657113A5011740FBA10000000BF08000000E9B2FEFFFF0FB657123A5012740FBA11000000BF09000000E99AFEFFFFBA12000000E9F3FEFFFF5789D24589C94989CA488D14114F8D0C08564C89C74883EC08EB2EEB008D4E0189C8488D34074939F10F8293000000498D04024839C20F82860000004C89D6F3A44989F24939D27357410FB6324983C20183FE1F76C74C39D2766789F1C1E90583F907744889C8450FB61A488D4407024939C1724D48C1E608450FB6DB81E6001F000048F7D6488D34374C29DE4939F077304983C20183C102F3A44939D272A989F84883C4085E4429C05FC390410FB60A4983C2014C39D276080FB6C983C107EBA34883C40831C05E5FC3'
		Else
			Local $Opcode = '0x89C083EC2C8B54243C8B442430895424108B5424388954240C8B5004895424088B542434895424048B00890424E83600000083C42CC2100089DB83EC1C8B4424208B5424288954240C8B5004895424088B542424895424048B00890424E86A04000083C41CC210005557565383EC208B4424408B4C243C8B54243801C185C0894C24100F841B02000085D20F84130200008B5C243431F6035424348B44243C8954241C0FB6138B7C241C0FB64B0183C001C1E20883EF0209D189DA897C240CEB213B4424100F83D90100000FB61A83C60183C201881883C00183FE200F84220200003B54240C0F835A0100008D6A0289CB896C24180FB64A02C1E30809D989CBC1EB088D3C8929FB8B7C244481E3FFFF00008D1C9F8B3B89138D5AFF29FB81FBFF1F0000895C24087797397C24348D6A04896C2414738A8B5C241C39DD73820FB71F663B1A0F8576FFFFFF8B6C24180FB65F023A5D000F8565FFFFFF8D4804394C24100F862A0100008B4C241C29D183E90281F9080100000F873001000089F385F6F7D3895C24188B6C24188D5EFF881C280F94C389DE81E6FF00000029F083F9100F86940100000FB66F03BE02000000C64424182089EB3A5A030F84F700000083C2018B4C2408C1E908024C2418880883C0010FB64C240801F2880883C0023B54240C0F830A0200000FB65AFE8D72FF0FB64AFF8D7AFEC1E30809D90FB61AC1E10809D989CB8D2C89C1EB0829EB8B6C244481E3FFFF0000C1E108897C9D000FB65E0209D989CBC1EB088D3C8929FB81E3FFFF000089749D0031F63B54240C0F82A6FEFFFF8D4803394C241072553B54241C731F8B5C241C0FB60A83C60183C201880883C00183FE200F84A300000039D377E589F2F7D28D4EFF880C1031D285F60F94C229D02B44243C83C4205B5E5F5DC385F6750D8D4803394C24100F87C5FEFFFF83C42031C05B5E5F5DC3B908010000E9C6FEFFFF8B6C241466BE0300C6442418400FB65F043A5D000F85EFFEFFFF0FB66F0566BE0400C64424186089EB3A5A050F85D7FEFFFF0FB6770689F33A5A06742DBE05000000C644241880E9BDFEFFFFC640DF1F6631F683C001E9CFFDFFFFC640DF1F6631F683C001E94EFFFFFF0FB6770789F33A5A077470BE06000000C6442418A0E985FEFFFFBE020000008B5C240801F78D2C32894C240483C6013974240476180FB64F0183C701884C24180FB64D0183C501384C241874DF8D4EFE83C20183F906895C2408765083E90783EE018B7C2408884801C1EF0883EF2089FB881883C002E937FEFFFF0FB6770889F33A5A08740FBE07000000C6442418C0E90AFEFFFF0FB6770989F33A5A09741BBE0800000031C983C201EBB6C1E10583EE01884C2418E9E7FDFFFF0FB6770A89F33A5A0A7413BE09000000B901000000EBD531F6E94BFEFFFF0FB6770B'
				$Opcode &= '89F33A5A0B740CBE0A000000B902000000EBB70FB6770C89F33A5A0C740CBE0B000000B903000000EBA00FB6770D89F33A5A0D740CBE0C000000B904000000EB890FB6770E89F33A5A0E740FBE0D000000B905000000E96FFFFFFF0FB6770F89F33A5A0F740FBE0E000000B906000000E955FFFFFF0FB6771089F33A5A10740FBE0F000000B907000000E93BFFFFFF0FB6771189F33A5A11740FBE10000000B908000000E921FFFFFF0FB6771289F33A5A12740FBE11000000B909000000E907FFFFFFBE12000000E975FEFFFF5557565383EC048B5424188B44241C8B4C2420034C24248B7C242001D0890C24EB1C8D4E018D1C0F391C2472778D1C0A39D8727089D6F3A489F239C273460FB63283C20183FE1F76D939D0765789F1C1E90583F907743B83C1020FB61A8D2C0F392C24723F83E61F0FB6DBC1E608F7D68D343729DE39742420772983C201F3A439C272BA89F82B44242083C4045B5E5F5DC30FB60A83C20139D076080FB6C983C107EBB383C40431C05B5E5F5DC3'
 		EndIf
		$_LZF_Compress = (StringInStr($Opcode, "89C0") - 3) / 2
		$_LZF_Decompress = (StringInStr($Opcode, "89DB") - 3) / 2
		$Opcode = Binary($Opcode)

		$_LZF_CodeBufferMemory = _MemVirtualAlloc(0, BinaryLen($Opcode), $MEM_COMMIT, $PAGE_EXECUTE_READWRITE)
		$_LZF_CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]", $_LZF_CodeBufferMemory)
		DllStructSetData($_LZF_CodeBuffer, 1, $Opcode)
		OnAutoItExitRegister("_LZF_Exit")
	EndIf
EndFunc

Func _LZF_Compress_Core($Data)
	If Not IsDllStruct($_LZF_CodeBuffer) Then _LZF_Startup()

	$Data = Binary($Data)
	Local $InputLen = BinaryLen($Data)
	Local $Input = DllStructCreate("byte[" & $InputLen & "]")
	DllStructSetData($Input, 1, $Data)

	Local $OutputLen = Ceiling($InputLen + 1.04) + 16
	Local $Output = DllStructCreate("byte[" & $OutputLen & "]")

	Local $Var = DllStructCreate("ptr src; ptr dst")
	DllStructSetData($Var, "src", DllStructGetPtr($Input))
	DllStructSetData($Var, "dst", DllStructGetPtr($Output))

	Local $Buffer = DllStructCreate("byte[524288]")

	Local $Ret = DllCall("user32.dll", "uint", "CallWindowProc", "ptr", DllStructGetPtr($_LZF_CodeBuffer) + $_LZF_Compress, _
													"ptr", DllStructGetPtr($Var), _
													"uint", $InputLen, _
													"uint", $OutputLen, _
													"ptr", DllStructGetPtr($Buffer))

	Return BinaryMid(DllStructGetData($Output, 1), 1, $Ret[0])
EndFunc

Func _LZF_Decompress_Core($Data, $MaxBuffer)
	If Not IsDllStruct($_LZF_CodeBuffer) Then _LZF_Startup()

	$Data = Binary($Data)
	Local $InputLen = BinaryLen($Data)
	Local $Input = DllStructCreate("byte[" & $InputLen & "]")
	DllStructSetData($Input, 1, $Data)

	Local $Output = DllStructCreate("byte[" & $MaxBuffer & "]")

	Local $Var = DllStructCreate("ptr src; ptr dst")
	DllStructSetData($Var, "src", DllStructGetPtr($Input))
	DllStructSetData($Var, "dst", DllStructGetPtr($Output))

	Local $Ret = DllCall("user32.dll", "uint", "CallWindowProc", "ptr", DllStructGetPtr($_LZF_CodeBuffer) + $_LZF_Decompress, _
													"ptr", DllStructGetPtr($Var), _
													"uint", $InputLen, _
													"uint", $MaxBuffer, _
													"int", 0)

	Return BinaryMid(DllStructGetData($Output, 1), 1, $Ret[0])
EndFunc

Func _LZF_Compress($Data)
	If Not IsDllStruct($_LZF_CodeBuffer) Then _LZF_Startup()

	$Data = Binary($Data)
	Local $InputLen = BinaryLen($Data)
	Return BinaryMid(Binary($InputLen), 1, 4) & _LZF_Compress_Core($Data)
EndFunc

Func _LZF_Decompress($Data)
	If Not IsDllStruct($_LZF_CodeBuffer) Then _LZF_Startup()

	$Data = Binary($Data)
	Local $OutputLen = Int(BinaryMid($Data, 1, 4))
	Return _LZF_Decompress_Core(BinaryMid($Data, 5), $OutputLen)
EndFunc