require 'rails_helper'

describe "Contact.rb model code >" do
  it "is valid: with a firstname, lastname and email" do
    # contact = Contact.new(
      contact = build(:contact,
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com')
    expect(contact).to be_valid
  end

  it "is invalid: without a firstname" do
    contact = build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid: without a lastname" do
    contact = build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid: without an email address" do
    contact = build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid: with a duplicate email address" do
    create(:contact, email: 'aaron@example.com')
    contact = build(:contact, email: 'aaron@example.com')
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "has a method that returns: a contact's full name as a string" do
    contact = build(:contact, firstname: 'Chad', lastname: 'Thunder')
    expect(contact.name).to eq 'Chad Thunder'
  end

  describe "/ Testing lastname by_letter Scope /" do
    before :each do
      # smith = Contact.create(
      #   firstname: 'John',
      #   lastname: 'Smith',
      #   email: 'jsmith@example.com'
      # )
      # jones = Contact.create(
      #   firstname: 'Tim',
      #   lastname: 'Jones',
      #   email: 'tjones@example.com'
      # )
      # johnson = Contact.create(
      #   firstname: 'John',
      #   lastname: 'Johnson',
      #   email: 'jjohnson@example.com'
      # )
      @smith = create(:contact,
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@example.com'
      )
      @jones = create(:contact,
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example.com'
      )
      @johnson = create(:contact,
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com'
      )
    end

    # it "has a scope that returns: a sorted array of results that match" do
    #   smith = Contact.create(
    #     firstname: 'John',
    #     lastname: 'Smith',
    #     email: 'jsmith@example.com'
    #   )
    #   jones = Contact.create(
    #     firstname: 'Tim',
    #     lastname: 'Jones',
    #     email: 'tjones@example.com'
    #   )
    #   johnson = Contact.create(
    #     firstname: 'John',
    #     lastname: 'Johnson',
    #     email: 'jjohnson@example.com'
    #   )
    #   expect(Contact.by_letter("J")).to eq [johnson, jones]
    #   expect(Contact.by_letter("J")).to eq [@johnson, @jones]
    # end

    # it "has a scope that omits: results that do not match" do
    #   smith = Contact.create(
    #     firstname: 'John',
    #     lastname: 'Smith',
    #     email: 'jsmith@example.com'
    #   )
    #   jones = Contact.create(
    #     firstname: 'Tim',
    #     lastname: 'Jones',
    #     email: 'tjones@example.com'
    #   )
    #   johnson = Contact.create(
    #     firstname: 'John',
    #     lastname: 'Johnson',
    #     email: 'jjohnson@example.com'
    #   )
    #   expect(Contact.by_letter("J")).to_not include @smith
    # end

    context "With: matching letters >" do
      it "returns: a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context "With: non-matching letters >" do
      it "omits: results that do not match" do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end
  end

  it "Has: a valid factory" do
    expect(build(:contact)).to be_valid
  end

  it "Has: three phone numbers" do
    expect(create(:contact).phones.count).to eq 3
  end
end
