require 'rails_helper'

describe "Contact.rb model code >" do
  it "is valid: with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com')
    expect(contact).to be_valid
  end

  it "is invalid: without a firstname" do
    contact = Contact.new(firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid: without a lastname" do
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid: without an email address" do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid: with a duplicate email address" do
    Contact.create(
      firstname: 'Joe', lastname: 'Shmoe', email: 'joe@sample.com'
    )
    contact = Contact.new(
      firstname: 'Billy', lastname: 'Beta', email: 'joe@sample.com'
    )
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "has a method that returns: a contact's full name as a string" do
    contact = Contact.new(
      firstname: 'Chad', lastname: 'Thunder', email: 'chad@thunder.com'
    )
    expect(contact.name).to eq 'Chad Thunder'
  end

  it "has a scope that returns: a sorted array of results that match" do
    smith = Contact.create(
      firstname: 'John',
      lastname: 'Smith',
      email: 'jsmith@example.com'
    )
    jones = Contact.create(
      firstname: 'Tim',
      lastname: 'Jones',
      email: 'tjones@example.com'
    )
    johnson = Contact.create(
      firstname: 'John',
      lastname: 'Johnson',
      email: 'jjohnson@example.com'
    )
    expect(Contact.by_letter("J")).to eq [johnson, jones]
  end

  it "has a scope that omits: results that do not match" do
    smith = Contact.create(
      firstname: 'John',
      lastname: 'Smith',
      email: 'jsmith@example.com'
    )
    jones = Contact.create(
      firstname: 'Tim',
      lastname: 'Jones',
      email: 'tjones@example.com'
    )
    johnson = Contact.create(
      firstname: 'John',
      lastname: 'Johnson',
      email: 'jjohnson@example.com'
    )
    expect(Contact.by_letter("J")).to_not include smith
  end

  describe "/ Testing lastname by_letter Scope /" do
    before :each do
      @smith = Contact.create(
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@example.com'
      )
      @jones = Contact.create(
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example.com'
      )
      @johnson = Contact.create(
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com'
      )
    end

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
end
