echo @off
echo Starting build...
tasm /zi paint.asm
tasm /zi mouse.asm
tasm /zi ui.asm
tasm /zi video.asm

echo Linking...
tlink /v /x paint.obj video.obj mouse.obj ui.obj, paint.exe
