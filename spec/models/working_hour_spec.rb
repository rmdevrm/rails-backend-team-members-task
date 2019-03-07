# frozen_string_literal: true

require 'rails_helper'
RSpec.describe WorkingHour, type: :model do
  it { should belong_to(:user) }

  context 'Class methods' do
    context 'time_in_minutes' do
      it 'should return time in minutes' do
        expect(WorkingHour.time_in_minutes('10:00')).to be(600)
      end
    end

    context 'time_in_minutes_hour' do
      it 'should return time in string ' do
        expect(WorkingHour.time_in_minutes_hour(600)).to eq('10:0')
      end
    end
  end
end
