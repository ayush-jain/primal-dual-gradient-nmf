function [H,W,grad,iter] = pgwithlin(V,Winit,Hinit,tol,maxiter)
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
        if inner_iter==1,
            decr_alpha = ~suff_decr; Hp = H;
        end
        if decr_alpha, 
            if suff_decr,
                H = Hn; break;
            else
                alpha = alpha * beta;
            end
        else
            if ~suff_decr | Hp == Hn,
                H = Hp; break;
            else
                alpha = alpha/beta; Hp = Hn;
            end
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
        if inner_iter==1,
            decr_alpha = ~suff_decr; Wp = W;
        end
        if decr_alpha, 
            if suff_decr,
                W = Wn; break;
            else
                alpha = alpha * beta;
            end
        else
            if ~suff_decr | Wp == Wn,
                W = Wp; break;
            else
                alpha = alpha/beta; Wp = Wn;
            end
        end
    end
    %disp(iter);
end
