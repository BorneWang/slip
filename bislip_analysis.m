%%
params = [body_mass body_inertia foot_mass leg_stiffness leg_damping gravity]';

dY = [];
body = [];
leg_a = [];
leg_b = [];
t = Y.Time;

for i = 1:length(t)
    [dY_i, body_i, leg_a_i, leg_b_i] = bislip_dynamics(Y.Data(i, :)', u.Data(i, :)', params, ground_data);
    dY = [dY; dY_i'];
    body = [body; body_i];
    leg_a = [leg_a; leg_a_i];
    leg_b = [leg_b; leg_b_i];
end

gcb = [body.ground_contact_data];
gcla = [leg_a.ground_contact_data];
gclb = [leg_b.ground_contact_data];

%%
plot(t, [gclb.ground_slip])

%%
tic;
vis = BiSLIPGraphics();
t = Y.Time;

while toc < t(end)
    tt = toc;
    i = find(t <= tt, 1, 'last');
    vis.setState(Y.Data(i, 1:2), Y.Data(i, 3), Y.Data(i, 7:8), Y.Data(i, 11:12));
    drawnow;
end
