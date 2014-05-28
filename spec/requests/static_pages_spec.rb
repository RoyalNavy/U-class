require 'spec_helper'

describe "Static pages" do

  describe "Home" do
    # This description is just a string, and it can be anything you want

    it "should have the content 'U-Class' " do
      # Again, just strings to remind the developer what to expect if it doesnt run correctly  
      visit '/static_pages/home'
      # URL to home
      expect(page).to have_content( 'U-Class' )
    end
    it "should have the title 'U-Class'" do
      visit '/static_pages/home'
      expect(page).to have_title("U-Class | Home")
    end
  end
  
  describe "Contact" do
    # This description is just a string, and it can be anything you want

    it "should have the content 'Contact' " do
      visit '/static_pages/contact'
      # URL to contact
      expect(page).to have_content( 'Contact'  )
    end
    
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title("U-Class | Contact")
    end
  end
  
    describe "About" do
    # This description is just a string, and it can be anything you want

    it "should have the content 'About Us' " do
      visit '/static_pages/about'
      # URL to about
      expect(page).to have_content( 'About Us'  )
    end
  
    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("U-Class | About Us")
    end
  end
  
  
end