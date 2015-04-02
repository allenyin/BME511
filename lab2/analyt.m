
% ===== Elementary example: potential inside an isotropic, homogeneous circle
%
%clear
alpha = 0.28; R = 9; sig = 4.5; js = 80;
nterms = 109;	% highest term to include in the sum
nr = 100; nphi = 500;	% discretization in rad and circumf directions

% precompute coefficients
k = 1:2:nterms;	%       k - indices for 1, 3...
Ak = (-4*js)/(pi*sig) * sin(alpha*k) ./ (k.*k.*R.^(k-1));

% ===== potential, field, current dens. as a function of radius
dr = R/nr;
rad = 0:dr:R;
phi = 0;
for n = 1:length(rad)
  r = rad(n);
  aux = r.^k .* cos(k*phi);
  Vr(n) = Ak * aux' ; 		% potential
  aux = k .* r.^(k-1) .* cos(k*phi);
  Erad(n) = - Ak * aux' ;	% e-field in radial direction
  aux = k .* r.^(k-1) .* sin(k*phi);
  Ephi(n) = Ak * aux' ;		% e-field in angular direction
  Emag(n) = sqrt(Erad(n)*Erad(n) + Ephi(n)*Ephi(n));	% magnitude
  Jrad(n) = sig * Erad(n);	% curr dens in radial direction
  Jphi(n) = sig * Ephi(n);	% curr dens in angular direction
  Jmag(n) = sig * Emag(n);		% magnitude
  end

% plots of analytical solution along the radius
subplot(3,2,1)
plot(rad,Vr); grid on; ylabel('potential (mV)');
axis([0 R -inf inf]); title('Along the radius');
hold on;
plot(a(:,1), a(:,2), 'r');

subplot(3,2,3);
plot(rad,Emag); grid on; ylabel('|E| (mV/cm)')
axis([0 R -inf inf]);
hold on;
plot(c(:,1), c(:,2), 'r');

subplot(3,2,5);
plot(rad,Jphi); grid on; ylabel('Jphi (uA/cm2)')
axis([0 R -inf inf]);
xlabel('distance (cm)'); 
hold on;
plot(e(:,1), e(:,2), 'r');

% ===== potential, field, current dens. as a function of circumference
r = R;
dphi = 0.5*pi/nphi;
phivec = 0:dphi:0.5*pi;
for n = 1:length(phivec)
  phi = phivec(n);
  aux = r.^k .* cos(k*phi);
  Vc(n) = Ak * aux' ;		% potential
  aux = k .* r.^(k-1) .* cos(k*phi);
  Erad(n) = - Ak * aux' ;	% e-field in radial direction
  aux = k .* r.^(k-1) .* sin(k*phi);
  Ephi(n) = Ak * aux' ;		% e-field in angular direction
  Emag(n) = sqrt(Erad(n)*Erad(n) + Ephi(n)*Ephi(n));	% magnitude
  Jrad(n) = sig * Erad(n);	% current dens in radial direction
  Jphi(n) = sig * Ephi(n);	% current dens in radial direction
  Jmag(n) = sig * Emag(n);	% magnitude
  end

% plots of analytical solution along the circumference
subplot(3,2,2)
plot(phivec,Vc); grid on; ylabel('potential (mV)');
axis([0 0.5*pi -inf inf]); title('Along the circumference')
hold on;
plot(flipud(b(:,1))/9, b(:,2), 'r');

subplot(3,2,4)
plot(phivec,Emag); grid on; ylabel('|E| (mV/cm)')
axis([0 0.5*pi -inf inf]);
hold on;
plot(flipud(d(:,1))/9, d(:,2), 'r');

subplot(3,2,6)
plot(phivec,Jrad); grid on; ylabel('Jr (mV/cm)')
axis([0 0.5*pi -inf inf]);
xlabel('angle (rad)');
hold on;
plot(flipud(f(:,1))/9, f(:,2), 'r');

return
