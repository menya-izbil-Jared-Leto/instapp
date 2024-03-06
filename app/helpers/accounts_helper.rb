module AccountsHelper

    def profile_picture(account, css_class = "")
        image_path = account.image.present? ? account.image : "default1.png"
        image_tag(image_path, class: css_class)
    end

    def can_edit_profile profile_id
        account_signed_in? && current_account.id == profile_id
    end
end
