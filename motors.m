x = 30;
brick.SetColorMode(3, 2);
distance = 0;
reading = 0;
color = 0;
red = false;
blue = false;
green = false;
notKilled = true;
while notKilled
    distance = brick.UltrasonicDist(4);
    color = brick.ColorCode(3);
    reading = brick.TouchPressed(1);
    display(color);
    if color == 5 && ~red
        pause(0.2);
        brick.StopAllMotors('Brake');
        pause(1);
        brick.MoveMotor('AD', 20);
        red = true;
    end
    if color ~= 5
        red = false;
    end
    if color == 2 && ~blue
        pause(0.2);
        brick.StopAllMotors('Brake');
        brick.beep();
        pause(1);
        brick.beep();
        blue = true;
    end
    if color ~= 2
        blue = false;
    end
    if color == 3 && ~green
        pause(0.2);
        brick.StopAllMotors('Brake');
        brick.beep();
        brick.beep();
        brick.beep();
        brick.MoveMotor('AD', 20);
        green = true;
    end
    if color ~= 3
        green = false;
    end
    if distance >= x
        brick.StopAllMotors('Brake');
    end
    if reading == 0
        brick.StopAllMotors('Brake');
    end
    brick.MoveMotor('AD', 20);
    if reading == 1
        brick.StopAllMotors('Brake');
        notKilled = false;
    end
end 