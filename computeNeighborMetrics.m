%Compute embedding metrics
% This script processes the output from the morpheme vector pipeline:
% 1) extract the predicted neighbours 
% 2) saves as an excel file
% 3) evaluates neighbors using the func_emb_metrics function
files = dir('morphoEmbVec*.mat');
fileName = files(1).name % CHOOSE WHICH ONE YOU WANT TO EVLUATE
load(fileName)
n = length(predictedNeighborsAll);
expectedForms = cell(n, 1);
neighborsTop10 = cell(n, 10);  

for i = 1:n
    expectedForms{i} = predictedNeighborsAll{i}.testPlural;
    theseNeighbors = predictedNeighborsAll{i}.neighbors;
    for j = 1:min(10, length(theseNeighbors))
        neighborsTop10{i, j} = theseNeighbors{j};
    end
end

neighborHeaders = arrayfun(@(x) sprintf('Neighbor_%d', x), 1:10, 'UniformOutput', false);

T = cell2table([expectedForms neighborsTop10], ...
    'VariableNames', ['Expected' neighborHeaders]);
%% save as excel
baseName = erase(fileName, {'morphoEmbVec', '.mat'});
tableName = ['predNeighbors' baseName '.xlsx']
writetable(T, tableName);
%% Call the metrics function
[t1_tr, t10_tr, rank_tr] = func_emb_metrics(tableName);
%[t1_en, t10_en, rank_en] = func_emb_metrics(tableName);
fprintf('Turkish Top-1: %.2f%%, Top-10: %.2f%%, Mean Rank: %.2f\n', t1_tr*100, t10_tr*100, rank_tr);
%fprintf('English Top-1: %.2f%%, Top-10: %.2f%%, Mean Rank: %.2f\n', t1_en*100, t10_en*100, rank_en);
