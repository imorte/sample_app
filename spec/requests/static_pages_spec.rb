require 'rails_helper'
require 'spec_helper'
def full_title(page_title)
  base_title = "BASE"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

describe ApplicationHelper do
  describe 'full_title' do
    it 'should include the page titie' do
      expect(full_title('foo')).to match(/foo/)
    end
    it 'should include the base title' do
      expect(full_title('foo')).to match(/^BASE/)
    end
    it 'should not include a bar for the home page' do
      expect(full_title('')).not_to match(/\|/)
    end
  end
end

describe "Static pages" do
  let(:base_title) {"BASE"}
  subject {page}

  shared_examples_for 'all static pages' do
    it {should have_selector('h1', text: heading)}
    it {should have_title(full_title(page_title))}
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end

  describe "Home page" do
    before {visit root_path}
    let(:heading) {'sample app'}
    let(:page_title) {''}
  end

  describe "Help page" do
    before {visit help_path}
    let(:heading) {'Help'}
    let(:page_title) {'Help'}
  end

  describe "About page" do
    before {visit about_path}
    let(:heading) {'About Us'}
    let(:page_title) {'About'}
  end

  describe "Contact page" do
    before {visit contact_path}
    let(:heading) {'Contact'}
    let(:page_title) {'Contact'}
  end
end