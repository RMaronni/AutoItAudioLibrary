#include <File.au3>

Global Enum $FLC_RETURN_TRUE  = 1, _
			$FLC_RETURN_FALSE = 0, _
			$FLC_RETURN_ERROR = -1


Global Enum $FLC_ERROR_NO = 0, _
			$FLC_ERROR_FLAC_FILE_NOT_FOUND = 1


Global Const $FLAC_PATH = "C:\Workspace\flac-1.3.1-win\win64\flac.exe"




Func FLC_FlacDecoder($flacFile, $waveFile = "")

	Local $command = ""

	; Check inputs
	If Not FileExists($flacFile) Then
		Return SetError($FLC_ERROR_FLAC_FILE_NOT_FOUND, $FLC_ERROR_NO, $FLC_RETURN_ERROR)
	EndIf

	$command = '"' & $FLAC_PATH & '"' & " -d " & '"' & $flacFile & '"'

	If $waveFile <> "" Then
		$command &= " -o " & '"' & $waveFile & '"'
	EndIf

	RunWait($command)

	Return $FLC_RETURN_TRUE

EndFunc


Func FLC_FlacDecoderDir($flacDir)

	Local $arrayFlacFiles = ""

	If StringRight($flacDir, 1) <> "\" Then $flacDir &= "\"

	$arrayFlacFiles = _FileListToArray($flacDir, "*.flac", 1)

	For $i = 1 To $arrayFlacFiles[0]

		FLC_FlacDecoder($flacDir & $arrayFlacFiles[$i])

	Next

	Return $FLC_RETURN_TRUE

EndFunc

