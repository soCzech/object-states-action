function prec_per_vid = evaluate_solution(Z_pr, clips, Z_gt, has_annot)

%  Input:
% - Z_pr    : N x K containing 0/1 predictions
% - clips   : n tab containing length of the different clips
% - Z_annot : N x K containing GT annotations

% Output:
% - prec_per_vid : n tab containig precision individually for each clip.

% get number of labels
[~, K]  = size(Z_pr);

Z_PR    = mat2cell(Z_pr, clips, K);   % prediction
Z_GT    = mat2cell(Z_gt, clips, K);   % annotation (ground truth)

% loop over videos for the score per videos

prec_per_vid    = zeros(sum(has_annot), K);
i = 1;
for j = 1:length(Z_PR)
    Z_annot   = Z_GT{j}; % the annotation
    Z_predict = Z_PR{j}; % the prediction

    TPpFP = sum(Z_predict);
    TP    = diag(Z_predict' * Z_annot)';
    if has_annot(j) == 1
       prec_per_vid(i, :)   = TP ./ TPpFP;
       i = i + 1;
    end
end

end
