# frozen_string_literal: true

class ListMovie < ApplicationRecord
  belongs_to :list
  belongs_to :movie
end
