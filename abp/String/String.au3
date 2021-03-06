﻿#include-once

#include <StringConstants.au3>

; #INDEX# =======================================================================================================================
; Title .........: String Snippets
; File name .....: StringSnippets.au3
; AutoIt Version : 3.3.10+
; Description ...: Collection of functions offering extended string handling
; Author(s) .....: rindeal
; Dll ...........:
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _str_split
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _str_split
; Description ...: Converts a string to an array based on the length.
; Syntax ........: _str_split($sString[, $iMaxLength = 1])
; Parameters ....: $sString             - The input string.
;                  $iMaxLength          - [optional] Maximum length of the chunk. ( 0 < $iMaxLength < 65536 )
; Return values .: Success - If the optional $iMaxLength parameter is specified, the returned array will be broken down into chunks
;                            with each being $iMaxLength in length, otherwise each chunk will be one character in length.
;                  Failure - 0 and sets the @error:
;                  |1 - $sString failure
;                  |2 - $iMaxLength failure
;                  |3 - StringRegExp failure (its @error can be found in @extended)
; Author ........: rindeal
; Modified ......:
; Version .......: 2014-01-21
; Performance ...: The speed greatly depends on the number of chunks, for a few chunks it takes ~40 ms for 1,000,000 chunks it takes ~550 ms
; Remarks .......:
; Related .......: PHP str_split (http://www.php.net/manual/en/function.str-split.php)
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _str_split($sString, $iMaxLength = 1)
	If Not IsString($sString) And Not IsBinary($sString) Then Return SetError(1, 0, 0)
	If Not IsInt($iMaxLength) Or $iMaxLength <= 0 Or $iMaxLength > 65535 Then Return SetError(2, 0, 0)
	Local $asReturn = StringRegExp(String($sString), '(?s).{1,' & $iMaxLength & '}', 3)
	If @error Then Return SetError(3, @error, 0)
	Return $asReturn
EndFunc   ;==>_str_split

; #FUNCTION# ====================================================================================================================
; Name ..........: _str_repeat
; Description ...: Repeats the provided string n-times
; Syntax ........: _str_repeat($sString, $iMultiplier)
; Parameters ....: $sString     - The string to be repeated.
;                  $iMultiplier - Number of time the input string should be repeated.
;                                 |$iMultiplier has to be greater than or equal to 0.
;                                 If the $iMultiplier is set to 0, the function will return an empty string.
; Return values .: Success - Returns the repeated string.
;                  Failure - Returns an empty string and sets the @error flag to a non-zero value.
; Version .......: 2014-03-26
; Requirements ..:
; Performance ...: For short strings with few iterations 1-2 ms/call
; Remarks .......: The fastest method known to me (rindeal) so far.
; Related .......: _StringRepeat (Strings.au3)
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _str_repeat($sString, $iMultiplier)
	If (Not StringIsInt($iMultiplier)) Or StringLen($sString) < 1 Or $iMultiplier <= 0 Then Return SetError(1, 0, "")
	Local $sReturn
	For $i = 1 To $iMultiplier
		$sReturn &= $sString
	Next
	Return $sReturn
EndFunc   ;==>_str_repeat

; #FUNCTION# ====================================================================================================================
; Name ..........: _StringRandom
; Description ...:
; Syntax ........: _StringRandom([$sType = "an"[, $iLength = 5]])
; Parameters ....: $sType               - [optional] A string value. Default is "an".
;																						combination of a/au/al and h/n
;																						au = uppercase alphabet
;																						al = lowercase alphabet
;																						a  = au + al
;																						h  = hexadeciaml
;																						n/d/i = numeric (decimal)
;                  $iLength             - [optional] An integer value. Default is 5.
; Return values .: A string built exactly by your specs
; Author ........: rindeal
; ===============================================================================================================================
Func _StringRandom($sType = "an", $iLength = 5)
	Local $sAlphaL = "abcdefghijklmnopqrstuvwxyz", $sAlphaU = StringUpper($sAlphaL), $sNumeric = "012345678901234567890123456789", $sHex = "0123456789ABCDEF0123456789ABCDEF"
	Local $sReturn, $sMix, $aMix, $iMODE = $STR_NOCASESENSEBASIC

	If StringInStr($sType, "al", $iMODE) Then
		$sMix &= $sAlphaL
	ElseIf StringInStr($sType, "au", $iMODE) Then
		$sMix &= $sAlphaU
	ElseIf StringInStr($sType, "a", $iMODE) Then
		$sMix &= $sAlphaL & $sAlphaU
	EndIf

	If StringInStr($sType, "h", $iMODE) Then
		$sMix &= $sHex
	ElseIf StringInStr($sType, "n", $iMODE) Or StringInStr($sType, "d", $iMODE) Or StringInStr($sType, "i", $iMODE) Then
		$sMix &= $sNumeric
	EndIf

	$aMix = StringSplit($sMix, "", $STR_ENTIRESPLIT)
	If @error Then Return SetError(1, 0, 0)
	For $i = 1 To $iLength
		$sReturn &= $aMix[Random(0, $aMix[0], 1)]
	Next

	Return $sReturn
EndFunc   ;==>_StringRandom

; #FUNCTION# ====================================================================================================================
; Name ..........: _sprintf
; Description ...:
; Syntax ........: _sprintf($sFormat[, $argN = ""])
; Parameters ....: $sFormat             - (string)
;                  $argN                - (array)(unknown) [optional]->[""]
; Return values .: Success - (integer) 1
;                  Failure - (integer) 0 and sets the @error flag to a non-zero value.
; Author ........: rindeal <dev.rindeal at outlook.com>
; Modified ......:
; Version .......: 2014-03-17
; Requirements ..:
; Performance ...:
; Remarks .......:
; Related .......: PHP sprintf
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _sprintf($sFormat, $arg1 = "", $arg2 = "", $arg3 = "", $arg4 = "", $arg5 = "", $arg6 = "", $arg7 = "", $arg8 = "", $arg9 = "", $arg10 = "", $arg11 = "", $arg12 = "", $arg13 = "", $arg14 = "", $arg15 = "", $arg16 = "", _
		$arg17 = "", $arg18 = "", $arg19 = "", $arg20 = "", $arg21 = "", $arg22 = "", $arg23 = "", $arg24 = "", $arg25 = "", $arg26 = "", $arg27 = "", $arg28 = "", $arg29 = "", $arg30 = "", $arg31 = "", $arg32 = "")

	; TODO: Error checking, optimize RegExes

	Local $sNewParams, $sFSpec
	Local $aFormatSpecs = StringRegExp($sFormat, "(?<!%)%(\d{0,2}\$?[# +\-*\d.a-zA-Z]*[a-zA-Z])", 3)

	For $i = 0 To UBound($aFormatSpecs) - 1
		$sFSpec = $aFormatSpecs[$i]
		If StringInStr($sFSpec, "$") Then
			$sFormat = StringReplace($sFormat, $sFSpec, StringRegExpReplace($sFSpec, "(.*\$)", "", 1), 1)
			$sNewParams &= "$arg" & StringRegExp($sFSpec, "(\d*)\$", 3)[0] & ","
		Else
			$sNewParams &= "$arg" & $i + 1 & ","
		EndIf

	Next
	$sNewParams = StringRegExpReplace($sNewParams, "\W*$", "")

	Return Execute('StringFormat($sFormat,' & $sNewParams & ')')
EndFunc   ;==>_sprintf


; #FUNCTION# ====================================================================================================================
; Name ..........: _StringToASCII
; Description ...:
; Syntax ........: _StringToASCII($sString)
; Parameters ....: $sString             - (string)
; Return values .: Success - (integer) 1
;                  Failure - (integer) 0 and sets the @error flag to a non-zero value.
; Author ........: rindeal <dev.rindeal at outlook.com>
; Modified ......:
; Version .......: 2014-03-19
; Requirements ..: this script file has to be saved as UTF8 with BOM otherwise it won't work
; Performance ...:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _StringToASCII($sString)
	Local $asReplaceTable = [ _
			['ae', 'ä|æ|ǽ'], _
			['oe', 'ö|œ'], _
			['ue', 'ü'], _
			['Ae', 'Ä'], _
			['Ue', 'Ü'], _
			['Oe', 'Ö'], _
			['A', 'À|Á|Â|Ã|Ä|Å|Ǻ|Ā|Ă|Ą|Ǎ'], _
			['a', 'à|á|â|ã|å|ǻ|ā|ă|ą|ǎ|ª'], _
			['C', 'Ç|Ć|Ĉ|Ċ|Č'], _
			['c', 'ç|ć|ĉ|ċ|č'], _
			['D', 'Ð|Ď|Đ'], _
			['d', 'ð|ď|đ'], _
			['E', 'È|É|Ê|Ë|Ē|Ĕ|Ė|Ę|Ě'], _
			['e', 'è|é|ê|ë|ē|ĕ|ė|ę|ě'], _
			['G', 'Ĝ|Ğ|Ġ|Ģ'], _
			['g', 'ĝ|ğ|ġ|ģ'], _
			['H', 'Ĥ|Ħ'], _
			['h', 'ĥ|ħ'], _
			['I', 'Ì|Í|Î|Ï|Ĩ|Ī|Ĭ|Ǐ|Į|İ'], _
			['i', 'ì|í|î|ï|ĩ|ī|ĭ|ǐ|į|ı'], _
			['J', 'Ĵ'], _
			['j', 'ĵ'], _
			['K', 'Ķ'], _
			['k', 'ķ'], _
			['L', 'Ĺ|Ļ|Ľ|Ŀ|Ł'], _
			['l', 'ĺ|ļ|ľ|ŀ|ł'], _
			['N', 'Ñ|Ń|Ņ|Ň'], _
			['n', 'ñ|ń|ņ|ň|ŉ'], _
			['O', 'Ò|Ó|Ô|Õ|Ō|Ŏ|Ǒ|Ő|Ơ|Ø|Ǿ'], _
			['o', 'ò|ó|ô|õ|ō|ŏ|ǒ|ő|ơ|ø|ǿ|º'], _
			['R', 'Ŕ|Ŗ|Ř'], _
			['r', 'ŕ|ŗ|ř'], _
			['S', 'Ś|Ŝ|Ş|Š'], _
			['s', 'ś|ŝ|ş|š|ſ'], _
			['T', 'Ţ|Ť|Ŧ'], _
			['t', 'ţ|ť|ŧ'], _
			['U', 'Ù|Ú|Û|Ũ|Ū|Ŭ|Ů|Ű|Ų|Ư|Ǔ|Ǖ|Ǘ|Ǚ|Ǜ'], _
			['u', 'ù|ú|û|ũ|ū|ŭ|ů|ű|ų|ư|ǔ|ǖ|ǘ|ǚ|ǜ'], _
			['Y', 'Ý|Ÿ|Ŷ'], _
			['y', 'ý|ÿ|ŷ'], _
			['W', 'Ŵ'], _
			['w', 'ŵ'], _
			['Z', 'Ź|Ż|Ž'], _
			['z', 'ź|ż|ž'], _
			['AE', 'Æ|Ǽ'], _
			['ss', 'ß'], _
			['IJ', 'Ĳ'], _
			['ij', 'ĳ'], _
			['OE', 'Œ'], _
			['f', 'ƒ'] _
			]

	For $i = 0 To UBound($asReplaceTable) - 1
		$sString = StringRegExpReplace($sString, '(*UCP)' & $asReplaceTable[$i][1], $asReplaceTable[$i][0])
	Next

	Return $sString
EndFunc   ;==>_StringToASCII

Func _StringRegExpSingle($sInput, $sPattern)
	Local $aReturn = StringRegExp($sInput, $sPattern, 3)
	Return (@error ? "" : $aReturn[0])
EndFunc   ;==>_StringRegExpSingle
