global key;
disp("Start");
open = false;
correctAngle = 0;
brick.GyroCalibrate(4);
red = false;
green = false;
yellow = false;
firstYellow = true;
blue = false;
turnReady = false;
stopped = false;
stillYellow = false;
while ~stopped
    while true
        angle = brick.GyroAngle(4);
        touch = brick.TouchPressed(1);
        color = brick.ColorCode(3);
        distance = brick.UltrasonicDist(2);
        display(angle);
        if color == 5 && ~red
            red = true;
            turnReady = true;
            brick.StopAllMotors('Brake');
            brick.playTone(100, 200, 1000);
            pause(1);
        elseif color ~= 5
            red = false;
        end
        if color == 3 && ~green
            green = true;
            brick.StopAllMotors('Brake');
            break;
        elseif color ~= 4
            green = false;
        end
        if color == 4 && ~yellow
            yellow = true;
            brick.StopAllMotors('Brake');
            brick.playTone(100, 300, 250);
            pause(0.5);
            brick.playTone(100, 300, 250);
            pause(0.5);
            brick.playTone(100, 300, 250);
            if ~firstYellow && stillYellow
                if color == 4
                    stopped = true;
                    break
                end
            else
                stillYellow = true;
            end
        elseif color ~= 4
            stillYellow = false;
            yellow = false;
            firstYellow = false;
        end
        if color == 2 && ~blue
            blue = true;
            brick.StopAllMotors('Brake');
            break;
        elseif color ~= 2
            blue = false;
        end
        if true
            if angle - 10 < correctAngle && correctAngle < angle + 10
                brick.MoveMotor('AD', -40);
            end
            if correctAngle <= angle - 8
                brick.MoveMotor('A', 20);
                brick.MoveMotor('D', -20);
            end
            if correctAngle >= angle + 8
                brick.MoveMotor('A', -20);
                brick.MoveMotor('D', 20);
            end
            if 0 < distance && distance < 40
                %turnReady = true;
                if touch == 1
                    brick.StopAllMotors('Brake');
                    brick.MoveMotor('AD', 40);
                    pause(0.75);
                    correctAngle = correctAngle + 90;
                end
            elseif 60 < distance && distance < 100
                if touch == 1
                    brick.StopAllMotors('Brake');
                    brick.MoveMotor('AD', 40);
                    pause(0.75);
                    correctAngle = correctAngle - 90;
                elseif turnReady
                    turnReady = false;
                    pause(0.5);
                    correctAngle = correctAngle - 90;
                end
            elseif 120 < distance && distance < 160
                if touch == 1
                    brick.StopAllMotors('Brake');
                    brick.MoveMotor('AD', 40);
                    pause(0.75);
                    correctAngle = correctAngle - 90;
                elseif turnReady
                    turnReady = false;
                    pause(0.5);
                    correctAngle = correctAngle - 90;
                end
            elseif 200 < distance
                if touch == 1
                    brick.StopAllMotors('Brake');
                    brick.MoveMotor('AD', 40);
                    pause(0.75);
                    correctAngle = correctAngle - 90;
                elseif turnReady
                    turnReady = false;
                    pause(0.5);
                    correctAngle = correctAngle - 90;
                end
            end
            %{
            if touch == 1
                turned = true;
                brick.StopAllMotors();
                brick.MoveMotor('AD', 50);
                pause(0.75);
                %correctAngle = correctAngle + 90;
                if distance >= 90 
                    correctAngle = correctAngle + 90;
                else
                    correctAngle = correctAngle - 90;
                end
                brick.StopAllMotors();
            end
            if turned
                turned = false;
                pause(0.5)
                turnReady = true;
            end
            if (65 <= distance && distance <= 85) && turnReady
                turnReady = false;
                pause(0.5);
                correctAngle = correctAngle - 90;
            end
            %}
        end
    end
    InitKeyboard();
    while true && ~stopped
        pause(0.1);
        switch key
            case 'uparrow'
                brick.MoveMotor('AD', -30);
            case 'downarrow'
                brick.MoveMotor('AD', 30);
            case 'leftarrow'
                brick.MoveMotor('A', 30);
                brick.MoveMotor('D', -30);
            case 'rightarrow'
                brick.MoveMotor('A', -30);
                brick.MoveMotor('D', 30);
            case 0
                brick.StopAllMotors();
            case 'q'
                brick.GyroCalibrate(4);
                correctAngle = 0;
                break;
            case 'r'
                brick.MoveMotor('C', 3);
                pause(0.3);
            case 'f'
                brick.MoveMotor('C', -3);
                pause(0.3);
        end
    end
    CloseKeyboard();
end