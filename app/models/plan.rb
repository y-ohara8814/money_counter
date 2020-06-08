class Plan < ApplicationRecord
    belongs_to :group, optional: true

end
