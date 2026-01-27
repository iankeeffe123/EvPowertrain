%% Variable Def
g = 9.81;
Af = 2.5;
Cd = .376;
Mv = 4000/2.205;
Aft = 5.5;
Cdt = 1;
Mt = 1500/2.205;
Rw = .33;
pa = 1.204;
grade = 0; 
acceleration = 0;
Vkph = [30 60 90 120];
Vmps = Vkph/3.6;

function TotalForce = TotalForce(pa, Cd, Af, Vmps, Vkph, Mv, acceleration, g, grade);
    AeroDrag = (1/2)*pa*Cd*Af*(Vmps .* Vmps);

    Frr = (.015+.006*(Vkph/100).^2.5)*Mv*g;

    InclineForce = Mv * g * sin(atan(grade/100));
    
    InertialForce = 1.05 * Mv * acceleration;

    TotalForce = AeroDrag + Frr + InclineForce + InertialForce;
end

%% part 1 
Vmps = V;
Vkph = Vmps * 3.6;
Acceleration = [diff(Vmps); 0];
Dist = trapz(t, Vmps);
disp("Total Distance Travelled (km) = ");
disp(Dist / 1000);
disp("Average Speed (m/s) = ")
disp(mean(Vmps));
disp("Top Speed (m/s) = ")
disp(max(Vmps));


disp("Average Positive Power (kW) = ");
PowerKW = zeros(length(Vmps));
PosPowerKW = zeros(0);
NegPowerKW = zeros(0);
for ii = 1:length(Vmps)-1
    Force = TotalForce(pa, Cd, Af, Vmps(ii), Vkph(ii), Mv, Acceleration(ii), g, grade);
    PowerKW(ii) = Force * Vmps(ii+1) / 1000;
    if PowerKW(ii) > 0
        PosPowerKW = [PosPowerKW, PowerKW(ii)];
    end
    if PowerKW(ii) < 0 
        NegPowerKW = [NegPowerKW, PowerKW(ii)];
    end
end
AvgPosPower = mean(PosPowerKW);
disp(AvgPosPower);
MaxPosPower = max(PosPowerKW);
disp("Max Positive Power (kW) = ")
disp(MaxPosPower);

MaxNegPower = min(NegPowerKW);
disp("Max Neg Power (kW) = ")
disp(MaxNegPower);


PosEnergyReq = sum(PosPowerKW * (length(PosPowerKW) / 3600)) / 1000;
disp("Positive Energy Requirement (kWh) = ")
disp(PosEnergyReq);

NegEnergyReq = sum(NegPowerKW * (length(NegPowerKW) / 3600)) / 1000;
PERPR = PosEnergyReq + NegEnergyReq;
disp("Positive Energy Requirement with Perfect Regen (kWh) = ")
disp(PERPR);






%%HP = PowerKW * 1.36;
%%disp("Part 1 (HP) = ");
%% disp(HP);
%%T = 1000 * PowerKW ./ (Vmps / Rw);
%%disp("Part 1 (N*m) = ");
%%disp(T);


