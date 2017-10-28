import React from 'react'
import Character from './Character'

class App extends React.Component {
  constructor(props) {
    super(props);

    props.characters.forEach((character) => {
      character.picked = false;
      character.numSupportsInTeam = 0;
    });
    this.state = { characters: props.characters };

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

      return { characters: characters };
    });
  }

  render() {
    return <div>
      <div className="team">
        <div className="team-heading">Team</div>
        {this.state.characters.map((character) => !character.picked ? false :
          <Character key={character.id} character={character} updateDisplay={this.updateDisplay} />
        )}
      </div>
      <div className="unpicked">
        <div className="unpicked-heading">Unpicked</div>
        {this.state.characters.map((character) => character.picked ? false :
          <Character key={character.id} character={character} updateDisplay={this.updateDisplay} />
        )}
      </div>
    </div>;
  }
}

// You will need this on the bottom of each component file
// to make it available through ES6 'import' statements.

export default App
