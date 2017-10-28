import React from 'react'

class Character extends React.Component {
  constructor(props) {
    super(props);

    this.handleClick = this.handleClick.bind(this);
  }

  handleClick() {
    this.props.updateDisplay(this.props.character);
  }

  render() {
    return <div className={`supported-by-${this.props.character.numSupportsInTeam}`}
                onClick={this.handleClick}>
        {this.props.character.name}
      </div>;
  }
}

// You will need this on the bottom of each component file
// to make it available through ES6 'import' statements.

export default Character
