%% ECEF -> Geodetic: "simple" closed-form vs iterative
% This script compares the "simple" algorithm (Bowring-style closed form)
% with an iterative solution for converting ECEF coordinates to geodetic
% latitude (lambda), longitude (L), and altitude (h).
%
% Units:
%   - Input ECEF is in km (per your slide)
%   - a, b are in km
%   - Output h is in km (also printed in meters)
%   - Angles are printed in degrees

clear; clc;

fprintf('============================================================\n');
fprintf('ECEF -> Geodetic comparison: SIMPLE vs ITERATIVE\n');
fprintf('============================================================\n\n');

%% -------------------------
% 1) Inputs from the slide
% -------------------------
xE = -910.64;     % km
yE =  764.118;    % km
zE =  7463.198;   % km

fprintf('[INPUT] ECEF position (km):\n');
fprintf('  xE = %.6f km\n', xE);
fprintf('  yE = %.6f km\n', yE);
fprintf('  zE = %.6f km\n\n', zE);

% Ellipsoid (WGS-84-ish) values given on slide (km)
a = 6378.137;  % semi-major axis, km
b = 6356.752;  % semi-minor axis, km

fprintf('[ELLIPSOID] a = %.6f km, b = %.6f km\n\n', a, b);

% Eccentricities
e2  = (a^2 - b^2) / a^2;   % first eccentricity squared
ep2 = (a^2 - b^2) / b^2;   % second eccentricity squared

fprintf('[ELLIPSOID] e^2  = %.12f\n', e2);
fprintf('[ELLIPSOID] e''^2 = %.12f\n\n', ep2);

% Distance from Z-axis
rho = hypot(xE, yE);

fprintf('[GEOMETRY] rho = sqrt(xE^2 + yE^2) = %.12f km\n\n', rho);

% Longitude (use atan2 for correct quadrant)
L = atan2(yE, xE); % rad

fprintf('[LONGITUDE] L = atan2(yE, xE)\n');
fprintf('  L = %.12f rad = %.12f deg\n\n', L, rad2deg(L));

%% ---------------------------------------------------
% 2) SIMPLE algorithm (Bowring-style closed-form)
% ---------------------------------------------------
fprintf('------------------------------------------------------------\n');
fprintf('[SIMPLE] Closed-form algorithm\n');
fprintf('------------------------------------------------------------\n');

% From your slide:
% theta = atan( zE * a / (rho * b) )
theta = atan2(zE * a, rho * b); % use atan2 to be safe

fprintf('Compute auxiliary angle theta:\n');
fprintf('  theta = atan2(zE*a, rho*b)\n');
fprintf('  theta = %.12f rad = %.12f deg\n\n', theta, rad2deg(theta));

% lambda = atan( (zE + e''^2 * b * sin^3(theta)) / (rho - e^2 * a * cos^3(theta)) )
sinT = sin(theta);
cosT = cos(theta);

lambda_simple = atan2( zE + ep2*b*(sinT^3), ...
                       rho - e2 *a*(cosT^3) );

fprintf('Compute geodetic latitude lambda (simple):\n');
fprintf('  lambda = atan2(zE + e''^2*b*sin^3(theta), rho - e^2*a*cos^3(theta))\n');
fprintf('  lambda_simple = %.12f rad = %.12f deg\n\n', lambda_simple, rad2deg(lambda_simple));

% Radius of curvature in the prime vertical (often called N)
N_simple = a / sqrt(1 - e2*(sin(lambda_simple)^2));

fprintf('Compute N (prime vertical radius of curvature):\n');
fprintf('  N = a / sqrt(1 - e^2*sin^2(lambda))\n');
fprintf('  N_simple = %.12f km\n\n', N_simple);

% Altitude. Use a robust formula that avoids division by small cos(lambda):
% h = rho/cos(lambda) - N  is fine unless near poles, but we can include a pole-safe branch:
if abs(cos(lambda_simple)) > 1e-12
    h_simple = rho / cos(lambda_simple) - N_simple;
    fprintf('Compute altitude h (simple) using rho/cos(lambda) - N:\n');
else
    % Near poles: use z/sin(lambda) - N*(1 - e^2)
    h_simple = zE / sin(lambda_simple) - N_simple*(1 - e2);
    fprintf('Near-pole branch used for altitude (simple): z/sin(lambda) - N*(1-e^2)\n');
end

fprintf('  h_simple = %.12f km (%.6f m)\n\n', h_simple, h_simple*1000);

%% ---------------------------------------------------
% 3) ITERATIVE algorithm
% ---------------------------------------------------
fprintf('------------------------------------------------------------\n');
fprintf('[ITERATIVE] Iterative algorithm (latitude + altitude)\n');
fprintf('------------------------------------------------------------\n');

% Common textbook iteration:
% Initialize lambda0 = atan2(zE, rho) (or use the simple solution as a very good initial guess)
lambda = atan2(zE, rho);  % rad
h = 0.0;                  % km
maxIter = 50;
tol = 1e-14;              % rad tolerance (very tight)

fprintf('Initialization:\n');
fprintf('  lambda0 = atan2(zE, rho) = %.12f deg\n', rad2deg(lambda));
fprintf('  h0 = %.6f km\n\n', h);

for k = 1:maxIter
    % N at current latitude
    N = a / sqrt(1 - e2*(sin(lambda)^2));

    % Update altitude using rho
    if abs(cos(lambda)) > 1e-12
        h_new = rho / cos(lambda) - N;
    else
        h_new = zE / sin(lambda) - N*(1 - e2);
    end

    % Update latitude using current N and h:
    % lambda_new = atan2(zE, rho*(1 - e^2*N/(N+h)))
    % Equivalent common form:
    % lambda_new = atan2(zE, rho*(1 - e^2*N/(N+h_new)))
    denom = rho * (1 - e2 * N / (N + h_new));
    lambda_new = atan2(zE, denom);

    dLam = abs(lambda_new - lambda);
    dh   = abs(h_new - h);

    fprintf('Iter %2d: lambda = %.12f deg, h = %.9f km, |dLam|=%.3e rad, |dh|=%.3e km\n', ...
            k, rad2deg(lambda_new), h_new, dLam, dh);

    % Convergence check
    lambda = lambda_new;
    h = h_new;

    if dLam < tol && dh < 1e-12
        fprintf('  -> Converged at iteration %d\n\n', k);
        break;
    end
end

lambda_iter = lambda;
h_iter = h;

fprintf('\n[ITERATIVE RESULT]\n');
fprintf('  lambda_iter = %.12f deg\n', rad2deg(lambda_iter));
fprintf('  L           = %.12f deg\n', rad2deg(L));
fprintf('  h_iter      = %.12f km (%.6f m)\n\n', h_iter, h_iter*1000);

%% ---------------------------------------------------
% 4) Report errors: SIMPLE vs ITERATIVE
% ---------------------------------------------------
fprintf('------------------------------------------------------------\n');
fprintf('[ERROR] SIMPLE minus ITERATIVE\n');
fprintf('------------------------------------------------------------\n');

dLambda_deg = rad2deg(lambda_simple - lambda_iter);
dL_deg      = 0.0; % longitude is identical here since we compute once with atan2
dh_km       = h_simple - h_iter;

fprintf('Delta latitude (deg)   = %.12e deg\n', dLambda_deg);
fprintf('Delta latitude (arcsec)= %.12e arcsec\n', dLambda_deg * 3600);
fprintf('Delta longitude (deg)  = %.12e deg\n', dL_deg);
fprintf('Delta altitude         = %.12e km = %.6f m\n\n', dh_km, dh_km*1000);

%% ---------------------------------------------------
% 5) Optional: reconstruct ECEF from geodetic to sanity check
% ---------------------------------------------------
fprintf('------------------------------------------------------------\n');
fprintf('[CHECK] Reconstruct ECEF from geodetic (optional sanity check)\n');
fprintf('------------------------------------------------------------\n');

% Helper function for ECEF reconstruction (using iterative solution)
Nchk = a / sqrt(1 - e2*(sin(lambda_iter)^2));

x_chk = (Nchk + h_iter) * cos(lambda_iter) * cos(L);
y_chk = (Nchk + h_iter) * cos(lambda_iter) * sin(L);
z_chk = (Nchk*(1 - e2) + h_iter) * sin(lambda_iter);

fprintf('Reconstructed ECEF from (lambda_iter, L, h_iter):\n');
fprintf('  x_chk = %.6f km\n', x_chk);
fprintf('  y_chk = %.6f km\n', y_chk);
fprintf('  z_chk = %.6f km\n\n', z_chk);

res = [x_chk - xE; y_chk - yE; z_chk - zE];
fprintf('ECEF residual (chk - input):\n');
fprintf('  dx = %.6e km (%.6f m)\n', res(1), res(1)*1000);
fprintf('  dy = %.6e km (%.6f m)\n', res(2), res(2)*1000);
fprintf('  dz = %.6e km (%.6f m)\n', res(3), res(3)*1000);
fprintf('  norm = %.6e km (%.6f m)\n', norm(res), norm(res)*1000);

fprintf('\nDone.\n');