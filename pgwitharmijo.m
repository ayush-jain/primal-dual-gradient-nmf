function [H,W,grad,iter] = pgwitharmijo(V,Winit,Hinit,tol,maxiter)
%     V -non-negative given matrix (n x m)
%     W - initial matrix factor (n x r)
%     H - initial matrix factor (r x m)

W=Winit;
H = Hinit; WtW = W'*W;
beta=0.1; sigma=0.01;
for iter=1:maxiter,
    grad = W'*W*H - W'*V;
    alpha=1;
    for inner_iter=1:20,
        Hn = max(H - alpha*grad, 0);
        d = Hn-H;
        gradd=sum(sum(grad.*d));
        dQd = sum(sum((WtW*d).*d));
        suff_decr = (1-sigma)*gradd + 0.5*dQd < 0;
        if suff_decr,
            H = Hn; break;
        else
            alpha = alpha * beta;
        end
    end

    gradW=W*H*H'-V*H';
    alpha=1;
    for inner_iter=1:20,
        Wn = max(W - alpha*gradW, 0);
        d = Wn-W;
        gradd=sum(sum(gradW.*d));
        dQd = sum(sum(((H*H')*d')'.*d));
        suff_decr = (1-sigma)*gradd + 0.5*dQd < 0;
        if suff_decr,
            W = Wn; break;
        else
            alpha = alpha * beta;
        end
    end
    %disp(iter);
end
