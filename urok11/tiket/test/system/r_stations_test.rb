require "application_system_test_case"

class RStationsTest < ApplicationSystemTestCase
  setup do
    @r_station = r_stations(:one)
  end

  test "visiting the index" do
    visit r_stations_url
    assert_selector "h1", text: "R Stations"
  end

  test "creating a R station" do
    visit r_stations_url
    click_on "New R Station"

    fill_in "Title", with: @r_station.title
    click_on "Create R station"

    assert_text "R station was successfully created"
    click_on "Back"
  end

  test "updating a R station" do
    visit r_stations_url
    click_on "Edit", match: :first

    fill_in "Title", with: @r_station.title
    click_on "Update R station"

    assert_text "R station was successfully updated"
    click_on "Back"
  end

  test "destroying a R station" do
    visit r_stations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "R station was successfully destroyed"
  end
end
