require "spec_helper"

RSpec.describe "Signing with GPGME" do
  include_context "example emails"

  specify "a non-multipart text-only message" do
    mail = simple_mail

    EnMail.protect :sign, mail
    mail.deliver
    common_message_expectations(mail)
    pgp_signed_part_expectations(mail)
    decrypted_part_expectations_for_simple_mail(mail.parts[0])
  end

  specify "a non-multipart HTML message" do
    mail = simple_html_mail

    EnMail.protect :sign, mail
    mail.deliver
    common_message_expectations(mail)
    pgp_signed_part_expectations(mail)
    decrypted_part_expectations_for_simple_html_mail(mail.parts[0])
  end

  specify "a multipart text+HTML message" do
    mail = text_html_mail

    EnMail.protect :sign, mail
    mail.deliver
    common_message_expectations(mail)
    pgp_signed_part_expectations(mail)
    decrypted_part_expectations_for_text_html_mail(mail.parts[0])
  end

  specify "a multipart message with binary attachments" do
    mail = text_jpeg_mail

    EnMail.protect :sign, mail
    mail.deliver
    common_message_expectations(mail)
    pgp_signed_part_expectations(mail)
    decrypted_part_expectations_for_text_jpeg_mail(mail.parts[0])
  end

  specify "forcing different signer key" do
    mail = simple_mail
    signer = "whatever@example.test"

    EnMail.protect :sign, mail, signer: signer
    mail.deliver
    common_message_expectations(mail)
    pgp_signed_part_expectations(mail, expected_signer: signer)
    decrypted_part_expectations_for_simple_mail(mail.parts[0])
  end

  def pgp_signed_part_expectations(message_or_part, expected_signer: mail_from)
    expect(message_or_part.mime_type).to eq("multipart/signed")
    expect(message_or_part.content_type_parameters).to include(
      "micalg" => "pgp-sha1",
      "protocol" => "application/pgp-signature",
    )
    expect(message_or_part.parts.size).to eq(2)
    expect(message_or_part.parts[1].mime_type).
      to eq("application/pgp-signature")
    expect(message_or_part.parts[1].content_type_parameters).to be_empty

    expect(message_or_part.parts[1].body.decoded).
      to be_a_valid_pgp_signature_of(message_or_part.parts[0].encoded).
      signed_by(expected_signer)
  end
end