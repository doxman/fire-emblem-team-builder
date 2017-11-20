import React from 'react'
import Character from './Character'

class App extends React.Component {
  constructor(props) {
    super(props);

    props.characters.forEach((character) => {
      character.picked = false;
      character.numSupportsInTeam = 0;
    });
    this.state = {
      characters: props.characters,
      warnings: ["Probably not enough characters to get through the game",
                 "Team might not have enough early-game units to survive"]
    };

    this.updateDisplay = this.updateDisplay.bind(this);
  }

  updateDisplay(characterClicked) {
    this.setState((prevState, props) => {
      let characters = [].concat(prevState.characters); // Copy
      characters
        .find((character) => character.id == characterClicked.id)
        .picked = !characterClicked.picked; // Update status for the clicked character

      characters
        .forEach((character) => {
          if (!character.picked) {
            character.numSupportsInTeam = character.partners
              .filter((partner) => characters
                .filter((a) => a.picked)
                .find((a) => a.id == partner.id) != null)
              .length;
          } else {
            character.numSupportsInTeam = 0;
          }
        });

      characters.sort((a,b) => b.rating - a.rating ||
                               b.numSupportsInTeam - a.numSupportsInTeam ||
                               a.recruitment_chapter - b.recruitment_chapter ||
                               a.id - b.id);

      // Determine the new warnings to show, if any
      let warnings = [];
      const pickedCharacters = characters.filter((character) => character.picked);
      if (pickedCharacters.length < props.game.min_team_size) {
        warnings.push("Probably not enough characters to get through the game");
      } else if (pickedCharacters.length > props.game.max_team_size) {
        warnings.push("Probably too many characters to keep up without grinding");
      }
      if (pickedCharacters.filter((character) => character.recruitment_chapter <= props.game.num_chapters / 2)
                          .length < props.game.min_team_size * (2/3)) {
        warnings.push("Team might not have enough early-game units to survive");
      }

      return { characters: characters, warnings: warnings };
    });
  }

  render() {
    return <div>
      <div className="team">
        <div className="team-heading">Team</div>
        {this.state.characters.map((character) => character.picked &&
          <Character key={character.id} character={character} updateDisplay={this.updateDisplay} />
        )}
      </div>
      <div className="unpicked">
        <div className="unpicked-heading">Unpicked</div>
        {this.state.characters.map((character) => !character.picked &&
          <Character key={character.id} character={character} updateDisplay={this.updateDisplay} />
        )}
      </div>
      {this.state.warnings.length > 0 &&
        <div className="problems">
          <h2>Potential problems</h2>
          <ul>
            {this.state.warnings.map((warning, idx) =>
              <li key={idx}>{warning}</li>
            )}
          </ul>
        </div>
      }
    </div>;
  }
}

// You will need this on the bottom of each component file
// to make it available through ES6 'import' statements.

export default App
