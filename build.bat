echo @off
echo Starting build...
tasm /zi /l paint.asm
tasm /zi /l mouse.asm
tasm /zi /l ui.asm
tasm /zi /l video.asm

echo Linking...
tlink /v /x paint.obj video.obj mouse.obj ui.obj, paint.exe
