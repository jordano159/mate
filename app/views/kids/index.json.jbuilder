# frozen_string_literal: true

json.array! @kids, partial: 'kids/kid', as: :kid
