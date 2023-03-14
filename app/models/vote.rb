class Vote < ApplicationRecord
    belongs_to :user
    belongs_to :article

    validate do
        unless user && user.votable_for?(article)
            errors.add(:base, :invalid)
        end
    end
end
