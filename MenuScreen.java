// Assuming the current structure of MenuScreen.java includes methods for rendering the title. Here is the updated code:

import com.badlogic.gdx.scenes.scene2d.ui.Label;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.utils.viewport.Viewport;

public class MenuScreen extends BaseScreen {
    private Label titleLabel;

    public MenuScreen(YourGameClass game, Viewport viewport) {
        super(game, viewport);
        createTitleLabel();
    }

    private void createTitleLabel() {
        titleLabel = new Label("K-pop monster hunter", new Label.LabelStyle(yourFont, yourColor));
        titleLabel.setFontScale(0.5f); // Adjust the scale as necessary
        titleLabel.setPosition((viewport.getWorldWidth() - titleLabel.getWidth()) / 2, viewport.getWorldHeight() - titleLabel.getHeight() - 20);
        stage.addActor(titleLabel);
    }

    @Override
    public void render(float delta) {
        super.render(delta);
        // Other rendering code
    }
}