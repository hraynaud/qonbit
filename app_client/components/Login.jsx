import React from 'react';

export default React.createClass({

  getInitialState: function() {
    return { errors: [] };
  },

  handleLogin: function(){
    this.submit(LOGIN_PATH)
  },

  handleRegister: function(){
    this.submit(REGISTRATION_PATH)
  },

  submit: function(path) {
    let email = this.email.value;
    let password = this.password.value;
    let credentials = JSON.stringify({email:email, password:password});

    this.props.writeToAPI('post', path, credentials, function(response) {
      if (!!response.jwt) {
        this.props.setToken(response.jwt)
        location = '/';
      }
    }.bind(this));
  },

  render: function() {
    return (
      <div>
       <p>
         Login to your account with your email and password or through Twitter
       </p>
        <section onSubmit={this.handleSubmit}>
        <div className="card--login__field">
        <label name="email">Email</label>
        <input ref={text => this.email = text} type="text" name="email" /> 
        </div>
        <div className="card--login__field">
        <label name="password">Password</label>
        <input ref={pwd => this.password = pwd} type="password" name="password" />
        </div>
        <button ref={btn => this.login_btn = btn}  onClick={this.handleLogin}>Login</button>
        <button ref={btn => this.register_btn = btn} onClick={this.handleRegister}>Register</button>
        </section>

        <p>
          <a href={this.props.origin + '/twitter/request_token'}>Twitter Login</a>
        </p>
      </div>


    );
  }
});
