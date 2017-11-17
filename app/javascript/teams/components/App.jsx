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
      warning: "Not enough characters picked"
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

      characters.sort((a,b) => {
        if (a.numSupportsInTeam == b.numSupportsInTeam) {
          return a.id - b.id;
        }
        return b.numSupportsInTeam - a.numSupportsInTeam;
      });

      // Determine the new warning to show, if any
      let warning = "";
      const pickedCharacters = characters.filter((character) => character.picked);
      if (pickedCharacters.length < props.game.min_team_size) {
        warning = "Not enough characters picked";
      } else if (pickedCharacters.length > props.game.max_team_size) {
        warning = "Too many characters picked";
      } else if (pickedCharacters.reduce((total, character) => total + character.recruitment_chapter, 1) /
                 pickedCharacters.length > props.game.num_chapters / 2) {
        warning = "Not enough early-game units on team";
      }

      return { characters: characters, warning: warning };
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
      {this.state.warning != "" &&
        <div className="warning">
          <h2>Warnings</h2>
          <p>{this.state.warning}</p>
        </div>
      }
    </div>;
  }
}

// You will need this on the bottom of each component file
// to make it available through ES6 'import' statements.

export default App
