# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'with default parameters ' do
  pp = <<-PUPPETCODE
  class { 'kapacitor': }
PUPPETCODE

  before(:all) do
    run_shell('/opt/puppetlabs/puppet/bin/gem install toml-rb')
    run_shell('/opt/puppetlabs/bin/puppet resource package lsb-release ensure=present')
  end

  it 'applies idempotently' do
    idempotent_apply(pp)
  end
end
