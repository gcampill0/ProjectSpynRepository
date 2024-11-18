global key;
InitKeyboard();
while 1
    pause(0.1);
    switch key
        case 'uparrow'
            brick.MoveMotor("AD", 30);
        case 'downarrow'
            brick.MoveMotor("AD", -30);
        case 'leftarrow'
            brick.MoveMotor("A", 30);
            brick.MoveMotor("D", -30);
        case 'rightarrow'
            brick.MoveMotor("A", -30);
            brick.MoveMotor("D", 30);
        case 0
            brick.StopAllMotors();
        case 'q'
            break;
    end
end

CloseKeyboard();

