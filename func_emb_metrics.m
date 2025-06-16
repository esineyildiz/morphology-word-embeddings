function [top1Acc, top10Acc, meanRank] = func_emb_metrics(xlsxFile)
% FUNC_EMB_METRICS calculates Top-1, Top-10, and Mean Rank from prediction results.
%
% Input:
%   xlsxFile - Excel file containing 'Expected' column and 10 nearest neighbors
%
% Output:
%   top1     - proportion of correct words ranked at position 1
%   top10    - proportion of correct words ranked in top 10
%   meanRank - average rank of correct words

    T = readtable(xlsxFile); 

    expected = T.Expected;
    myNeighbors = T{:, 2:end};  % all columns after the first

    n = height(T);
    top1Count = 0;
    top10Count = 0;
    ranks = zeros(n, 1);

    for i = 1:n
        currentExpected = expected{i};
        currentNeighbors = myNeighbors(i, :);

        % Remove empty entries
        nonEmpty = ~cellfun(@isempty, currentNeighbors);
        currentNeighbors = currentNeighbors(nonEmpty);

        % Find rank of expected form
        matchIdx = find(strcmpi(currentExpected, currentNeighbors));

        if ~isempty(matchIdx)
            if matchIdx(1) == 1
                top1Count = top1Count + 1;
            end
            top10Count = top10Count + 1;
            ranks(i) = matchIdx(1);
        else
            ranks(i) = NaN;  % mark as not found
        end
    end

    % Compute metrics
    top1Acc = top1Count / n;
    top10Acc = top10Count / n;
    meanRank = mean(ranks(~isnan(ranks)));

end
