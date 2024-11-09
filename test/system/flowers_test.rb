require "application_system_test_case"

class FlowersTest < ApplicationSystemTestCase
  setup do
    @flower = flowers(:one)
  end

  test "visiting the index" do
    visit flowers_url
    assert_selector "h1", text: "Flowers"
  end

  test "should create flower" do
    visit flowers_url
    click_on "New flower"

    fill_in "Description", with: @flower.description
    fill_in "Imageurl", with: @flower.imageUrl
    fill_in "Name", with: @flower.name
    fill_in "Price", with: @flower.price
    fill_in "Stock", with: @flower.stock
    click_on "Create Flower"

    assert_text "Flower was successfully created"
    click_on "Back"
  end

  test "should update Flower" do
    visit flower_url(@flower)
    click_on "Edit this flower", match: :first

    fill_in "Description", with: @flower.description
    fill_in "Imageurl", with: @flower.imageUrl
    fill_in "Name", with: @flower.name
    fill_in "Price", with: @flower.price
    fill_in "Stock", with: @flower.stock
    click_on "Update Flower"

    assert_text "Flower was successfully updated"
    click_on "Back"
  end

  test "should destroy Flower" do
    visit flower_url(@flower)
    click_on "Destroy this flower", match: :first

    assert_text "Flower was successfully destroyed"
  end
end
