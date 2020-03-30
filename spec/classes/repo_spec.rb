# frozen_string_literal: true

require 'spec_helper'

describe 'kapacitor::repo' do
  on_supported_os.each do
    context 'with all defaults' do
      let :params do
        {
          key_resource: '',
          resource: '',
        }
      end

      it { is_expected.to compile }
    end
  end
end
