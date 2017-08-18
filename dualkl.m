function [W, H, objective] = dualkl(V, W, H, N, D)


%     V -non-negative given matrix (n x m)
%     W - initial matrix factor (n x r)
%     H - initial matrix factor (r x m)

objective  = zeros(1,N/D);

phi   = -V./(W*H);
phi   = bsxfun(@times, phi, 1./max(bsxfun(@times, -W'*phi, 1./sum(W,1)')));
Wb  = W;
Wo  = W;
Hb  = H;
Ho  = H;
[n m] = size(V);
r     = size(H,1);

for i = 1:N/D,
   
sigma = sqrt(n/r) * sum(W(:)) ./ sum(V,1)  / norm(W);
tau   = sqrt(r/n) * sum(V,1)  ./ sum(W(:)) / norm(W);


for j = 1:D,

    phi  = phi + bsxfun(@times, Wb*H, sigma);
    phi  = (phi - sqrt(phi.^2 + bsxfun(@times, V, 4*sigma)))/2;
    W    = max(W - bsxfun(@times, (phi + 1)*H', tau), 0);
    Wb = 2*W - Wo;
    Wo = W;

end
%--------------------------%

for j = 1:D,

    phi  = phi + bsxfun(@times, W*Hb, sigma);
    phi  = (phi - sqrt(phi.^2 + bsxfun(@times, V, 4*sigma)))/2;
    H    = max(H - bsxfun(@times, W'*(phi + 1), tau), 0);
    Hb = 2*H - Ho;
    Ho = H;

end

sigma = sqrt(m/r) * sum(H(:)) ./ sum(V,2)  / norm(H);
tau   = sqrt(r/m) * sum(V,2)  ./ sum(H(:)) / norm(H);

objective(i)  = sum(sum(-V.*(log((W*H+eps)./(V+eps))+1)+W*H));
        
end

objective  = repmat(objective, D,1);
objective  = objective(:)';
end