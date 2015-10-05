#include <File.au3>

Global Enum $LME_RETURN_TRUE  = 1, _
			$LME_RETURN_FALSE = 0, _
			$LME_RETURN_ERROR = -1


Global Enum $LME_ERROR_NO = 0, _
			$LME_ERROR_WAVE_FILE_NOT_FOUND = 1


Global Const $LAME_PATH = "C:\Workspace\lame3.99.5-64\lame.exe"


Func LME_LameEncoderConstantBitRate($waveFile, $bitrate = "320", $q = "0", $m = "s", $outputFile = "")

	Local $command = ""

	; Check inputs
	If Not FileExists($waveFile) Then
		Return SetError($LME_ERROR_WAVE_FILE_NOT_FOUND, $LME_ERROR_NO, $LME_RETURN_ERROR)
	EndIf

	$command = '"' & $LAME_PATH & '"' & " -b " & $bitrate & " -q " & $q & " -m " & $m & ' "' & $waveFile & '"'

	RunWait($command)

	Return $LME_RETURN_TRUE

EndFunc

Func LME_LameEncoderConstantBitRateDir($waveDir, $bitrate = "320", $q = "0", $m = "s")

	Local $arrayWaveFiles = ""

	If StringRight($waveDir, 1) <> "\" Then $waveDir &= "\"

	$arrayWaveFiles = _FileListToArray($waveDir, "*.wav*", 1)

	For $i = 1 To $arrayWaveFiles[0]

		LME_LameEncoderConstantBitRate($waveDir & $arrayWaveFiles[$i], $bitrate, $q, $m)

	Next

	Return $LME_RETURN_TRUE

EndFunc

LME_LameEncoderConstantBitRateDir("C:\Users\Maronni\Downloads\Beethoven - The Very Best Of Beethoven (2005) [FLAC] dussin")

;~ LME_LameEncoderConstantBitRate("C:\Users\Maronni\Downloads\Beethoven - The Very Best Of Beethoven (2005) [FLAC] dussin\101_Beethoven_-_Symphony_No_5_in_C_minor_Op_67_I_Allegro_con_brio.wav")