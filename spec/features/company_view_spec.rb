require 'rails_helper'

describe 'the company view', type: :feature do

  let(:company) { Company.create(name: 'jumpstartlab') }

  before(:each) do
    company.phone_numbers.create(number: "555-1234")
    company.phone_numbers.create(number: "555-5678")
    visit company_path(company)
  end

  it 'shows the phone numbers' do
    company.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it 'has a link to add another' do
    expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Person'))
  end

  xit 'adds a new phone number' do
    page.click_link('Add phone number')
    page.fill_in('Number', with: '555-8888')
    page.click_button('Create Phone number')
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content('555-8888')
  end

  it 'has links to edit phone numbers' do
    company.phone_numbers.each do |phone|
      expect(page).to have_link('edit', href: edit_phone_number_path(phone))
    end
  end

  it 'edits a phone number' do
    phone = company.phone_numbers.first
    old_number = phone.number

    first(:link, 'edit').click
    page.fill_in('Number', with: '555-9191')
    page.click_button('Update Phone number')
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content('555-9191')
    expect(page).to_not have_content(old_number)
  end

  it 'has a button to delete phone_number' do
    company.phone_numbers.each do |phone|
    expect(page).to have_link('delete', href: phone_number_path(phone))
    end
  end
end

describe 'the email view', type: :feature do
  let(:company) { Company.create(name: 'jumpstartlab') }

  before(:each) do
    company.email_addresses.create(address: "john@gmail.com")
    company.email_addresses.create(address: "bro@gmail.com")
    visit company_path(company)
  end

  it 'has emails displayed' do
    expect(page).to have_selector('li', text: 'john@gmail.com')
  end

  it 'has a link to add new email address ' do
    expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: company.id, contact_type: 'Person' ))
  end

  xit "new_email_address" do
    page.click_link('Add email address')
    page.fill_in('Address', with: 'john@gmail.com')
    page.click_button('Create Email address')
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content('john@gmail.com')
  end

  it 'has links to edit email addresses ' do
    company.phone_numbers.each do |address|
      expect(page).to have_link('edit', href: edit_email_address_path(address))
    end
  end

  it 'edits an email addres' do
    email = company.email_addresses.first
    old_email = email.address

    first(:link, 'edit').click
    page.fill_in('Address', with: 'joshuajhun@gmail.com')
    page.click_button('Update Email address')
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content('joshuajhun@gmail.com')
    expect(page).to_not have_content(old_email)
  end

  it 'has a button to delete email' do
    company.email_addresses.each do |email|
    expect(page).to have_link('delete', href: email_address_path(email))
    end
  end


end
