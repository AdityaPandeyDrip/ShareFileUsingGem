class ActiveStorageBlob < ApplicationRecord
  searchkick word_middle: [:filename]
end
