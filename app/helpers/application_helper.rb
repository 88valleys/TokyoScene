module ApplicationHelper
  def genre_image_url(genre)
    images = {
      "Alternative Rock" => asset_path("genres/alternative-rock.jpg"),
      "Funk" => asset_path("genres/funk.jpeg"),
      "Indie Rock" => asset_path("genres/indie-rock.jpg"),
      "K-pop" => asset_path("genres/kpop.jpg"),
      "Pop Rock" => asset_path("genres/pop-rock.jpg"),
      "Funk Soul" => asset_path("genres/soul-funk.jpg"),
      "Soul" => asset_path("genres/soul.jpg"),

    # Add more genres and their corresponding image paths here
    }
    images[genre] || asset_path("genres/default.jpg") # Default image if genre not found
  end

  def artist_image_url(artist)
    images = {
      "His & Her Circumstances" => asset_path("artists/hhc.jpg"),
      "Radiohead" => asset_path("artists/radiohead.jpg"),
      "Fleetwood Mac" => asset_path("artists/fleetwood-mac.jpg"),
    # Add more artists and their corresponding image paths here
    }
    images[artist] || asset_path("artists/default.jpg") # Default image if artist not found
  end

  # This method creates a card div for a genre
  def artist_card_div(artist)
    image_url = artist_image_url(artist)
    content_tag(:div, class: "card-category d-inline", style: artist_card_style(image_url)) do
      yield if block_given?
    end
  end

  private

  def artist_card_style(image_url)
    "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url(#{image_url}); background-size: cover; background-position: center; padding: 20px; position: relative; margin-right: 10px; display: flex; align-items: center; justify-content: center; text-align: center; height: 100px;"
  end
end
