require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'password_reset' do
    let(:user_email) {'lucas@email.com'}
    let(:reset_link) { '/testlink' }
    let(:mail) { described_class.password_reset(:user_email, :reset_link).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Data Capture App Password Reset Link')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq(["user_email"])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['datacaptureseltapp@gmail.com'])
    end
  end
end
