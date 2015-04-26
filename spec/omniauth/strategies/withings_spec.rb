require 'spec_helper'

describe OmniAuth::Strategies::Withings do
  let(:omniauth_withings) {
    OmniAuth::Strategies::Withings.new([200, {}, ['Dummy App']], options)
  }
  let(:options) { {} }

  describe 'options' do
    subject { omniauth_withings.options }

    it { expect(subject.name).to eq('withings') }
    it { expect(subject.client_options.site).to eq('https://oauth.withings.com') }
    it { expect(subject.client_options.request_token_path).to eq('/account/request_token') }
    it { expect(subject.client_options.access_token_path).to eq('/account/access_token') }
    it { expect(subject.client_options.authorize_path).to eq('/account/authorize') }
  end

  describe 'info' do
    let(:raw_info) {
      {
        'body' => {
          'users' => [{
            'id'        => 1,
            'firstname' => 'flada',
            'lastname'  => 'auxv',
            'shortname' => 'FLA',
            'gender'    => 0,
            'birthdate' => 589993200
          }]
        }
      }
    }

    before do
      allow(omniauth_withings).to receive(:raw_info) { raw_info }
    end

    subject { omniauth_withings.info }

    its([:name])       { should eq('flada auxv') }
    its([:first_name]) { should eq('flada') }
    its([:last_name])  { should eq('auxv') }
  end

  describe 'skip_info option' do
    context 'when skip_info option is enabled' do
      let(:options) { {skip_info: true} }

      before do
        allow(omniauth_withings).to receive(:raw_info).and_return({foo: 'bar'})
      end

      subject { omniauth_withings.extra[:raw_info] }

      it { should eq(nil) }
    end
  end
end
