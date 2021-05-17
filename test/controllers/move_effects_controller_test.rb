require 'test_helper'

class MoveEffectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @move_effect = move_effects(:one)
  end

  test "should get index" do
    get move_effects_url
    assert_response :success
  end

  test "should get new" do
    get new_move_effect_url
    assert_response :success
  end

  test "should create move_effect" do
    assert_difference('MoveEffect.count') do
      post move_effects_url, params: { move_effect: { desc: @move_effect.desc, image_url: @move_effect.image_url, name: @move_effect.name } }
    end

    assert_redirected_to move_effect_url(MoveEffect.last)
  end

  test "should show move_effect" do
    get move_effect_url(@move_effect)
    assert_response :success
  end

  test "should get edit" do
    get edit_move_effect_url(@move_effect)
    assert_response :success
  end

  test "should update move_effect" do
    patch move_effect_url(@move_effect), params: { move_effect: { desc: @move_effect.desc, image_url: @move_effect.image_url, name: @move_effect.name } }
    assert_redirected_to move_effect_url(@move_effect)
  end

  test "should destroy move_effect" do
    assert_difference('MoveEffect.count', -1) do
      delete move_effect_url(@move_effect)
    end

    assert_redirected_to move_effects_url
  end
end
