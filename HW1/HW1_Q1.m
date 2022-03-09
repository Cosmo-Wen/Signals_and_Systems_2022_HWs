n = 0: 200;
z1 = exp((1/20)*2*pi*1i*n);         % fundemental frequency of 20
z2 = exp((1/30)*2*pi*1i*n);         % fundemental frequency of 30
z3 = exp((1/60)*2*pi*1i*n);         % fundemental frequency of 60
figure();
stem(n, real(z1), 'o');
hold on;
stem(n, real(z2), 'x');
stem(n, real(z3), '*');
hold off;
figure();
stem(n, real(z1 + z2 + z3), 'h');   % fundemental frequency of N

% N should be gcd(20, 30, 60), or the first place where z1, z2, z3 intersects