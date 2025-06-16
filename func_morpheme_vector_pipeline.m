function [accuracy, sums] = func_morpheme_vector_pipeline(filename, myRs, emb)
% This function evaluates a morpheme transformation (like plural suffix) 
% using static word embeddings.
% INPUT:
%   - filename: path to a .csv or .txt file with 2 columns (stem, affixed)
%   - myRs: a scaling factor (e.g., for regularization or dimension reduction)
%   - emb: a preloaded word embedding object (in MATLAB emb = fastTextWordEmbedding automatically...
% uploads wiki-news-300d-1M.vec.zip. Any other embeddings can be uploaded...
% with emb = readWordEmbedding(filename))
% OUTPUT:
%   - accuracy: proportion of correct top-1 predictions
%   - sums: total number of correct predictions

numSamples = 100;  % Number of random train/test splits
myAcc = zeros(numSamples, 1);  % Stores 1 for correct, 0 for incorrect
myRanks = zeros(numSamples, 1);  % Stores the rank of the correct word
predictedNeighborsAll = cell(numSamples, 1);  % Stores neighbors for analysis
sampleSize = 32;  % Number of words per sample (1 test + 31 training)

% Read word pairs from file
wordList = readtable(filename, 'TextType', 'string');  % Expects 2 columns: [stem, affixed]

% Loop through samples
for s = 1:numSamples
    idx = randperm(size(wordList, 1), sampleSize);  % Randomly pick 32 rows
    testIdx = idx(1);  % First word pair is for testing
    trainIdx = idx(2:end);  % Remaining 31 pairs for training

    % Training words: stems and their inflected forms
    stemTrain = wordList(trainIdx, 1);
    pluralTrain = wordList(trainIdx, 2);

    % Get embedding vectors
    embStem = word2vec(emb, stemTrain, "IgnoreCase", true);
    embPlural = word2vec(emb, pluralTrain, "IgnoreCase", true);
    
    % Compute average transformation vector and apply transformation matrix
    pluralVector = mean(embPlural - embStem) * myRs;

    % Test word
    testStem = wordList(testIdx, 1);
    testPlural = wordList(testIdx, 2);

    % Apply plural vector to test stem
    testStemVec = word2vec(emb, testStem, "IgnoreCase", true);
    predictedVec = testStemVec + pluralVector;

    % Predict nearest word from embedding space
    predictedWord = vec2word(emb, predictedVec);  % Top-1 prediction
    neighbors = vec2word(emb, predictedVec, 10);  % Top-10 nearest neighbors

    % Store neighbors and correct form
    predictedNeighborsAll{s} = struct( ...
        'testPlural', testPlural, ...
        'neighbors', neighbors ...
    );

    % Check if the correct inflected form is in the top-10
    [found, rank] = ismember(lower(testPlural), neighbors);
    if ~found
        rank = 11;  % If not found in top-10
    end
    myRanks(s) = rank;
    myAcc(s) = (rank == 1);  % Top-1 accuracy
end

% Calculate overall accuracy and correct prediction count
accuracy = sum(myAcc) / numSamples;
% Save outputs to file
structName = sprintf('Rs_%.1f', myRs); % Is useful if different Rs' are used
structName = strrep(structName, '.', '_');

[a b c]=fileparts(filename);

x = datetime('now'); % Is useful if it is repeated
myDate = datestr(x, 'mmdd');

save(['morphoEmbVec' structName '_' b '_' myDate '.mat'], 'myAcc', 'myRanks', 'predictedNeighborsAll', 'accuracy');

end
