<demo-modal>
  <h1 class="ui header">
    Modal
    <div class="sub header">A modal displays content that temporarily blocks interactions with the main view of a site</div>
  </h1>

  <!-- =================================================================================== -->
  <!--                                                                               Types -->
  <!-- =================================================================================== -->
  <h2 class="ui dividing header">Types<a class="anchor" id="types"></a></h2>

  <!-- ====================================================== -->
  <!--                                               Standard -->
  <!--                                               ======== -->
  <h3 class="ui header">Modal</h3>
  <p>A standard modal</p>
  <section>
    <div class="ui segment secondary top attached example">
      Example
      <i class="icon code" onclick="{ toggleExample }"></i>
    </div>
    <div class="ui segment bottom attached">
      <su-modal modal="{ modal }" class="large" ref="modal">
        <div class="ui medium image">
          <img src="./images/avatar2/large/rachel.png" />
        </div>
        <div class="description">
          <div class="ui header">Default Profile Image</div>
          <p>We've found the following <a href="https://www.gravatar.com" target="_blank">gravatar</a> image associated with
            your e-mail address.</p>
          <p>Is it okay to use this photo?</p>
        </div>
      </su-modal>
      <button class="ui button" onclick="{ showModal }">Show modal</button>
    </div>
    <div class="ui segment bottom attached inverted transition hidden">
      <pre><code class="prettyprint">
      <su-modal modal="{ modal }" class="large" ref="modal">
        <div class="ui medium image">
          <img src="./images/avatar2/large/rachel.png" />
        </div>
        <div class="description">
          <div class="ui header">Default Profile Image</div>
          <p>We've found the following <a href="https://www.gravatar.com" target="_blank">gravatar</a> image associated with your
            e-mail address.</p>
          <p>Is it okay to use this photo?</p>
        </div>
      </su-modal>
      <button class="ui button" onclick="{ showModal }">Show modal</button>

      <script>
        this.modal = {
          header: 'Select a Photo',
          buttons: [{
            text: 'Ok',
            type: 'primary',
            icon: 'checkmark'
          }, {
            text: 'Cancel'
          }]
        }

        this.showModal = () => {
          this.refs.modal.show()
        }
      </script>
    </code></pre>
    </div>
  </section>

  <!-- ====================================================== -->
  <!--                                                  Basic -->
  <!--                                                  ===== -->
  <h3 class="ui header">Basic</h3>
  <p>A modal can reduce its complexity</p>
  <section>
    <div class="ui segment secondary top attached example">
      Example
      <i class="icon code" onclick="{ toggleExample }"></i>
    </div>
    <div class="ui segment bottom attached">
      <su-modal modal="{ modal_basic }" class="basic" ref="modal_basic">
        Your inbox is getting full, would you like us to enable automatic archiving of old messages?
      </su-modal>
      <button class="ui button" onclick="{ showModalBasic }">Show modal</button>
    </div>
    <div class="ui segment bottom attached inverted transition hidden">
      <pre><code class="prettyprint">
      <su-modal modal="{ modal }" class="basic" ref="modal_basic">
        Your inbox is getting full, would you like us to enable automatic archiving of old messages?
      </su-modal>
      <button class="ui button" onclick="{ showModalBasic }">Show modal</button>

      <script>
        this.modal = {
          header: {
            text: 'Archive Old Messages',
            icon: 'archive'
          },
          buttons: [{
            text: 'No'
          }, {
            text: 'Yes',
            type: 'green',
            icon: 'checkmark'
          }]
        }

        this.showModalBasic = () => {
          this.refs.modal_basic.show()
        }
      </script>
    </code></pre>
    </div>
  </section>

  <script>
    this.toggleExample = event => {
      global.toggleExample(event.target)
    }

    this.modal = {
      header: 'Select a Photo',
      buttons: [{
        text: 'Ok',
        type: 'primary',
        icon: 'checkmark'
      }, {
        text: 'Cancel'
      }]
    }

    this.showModal = () => {
      this.refs.modal.show()
    }

    this.modal_basic = {
      header: {
        text: 'Archive Old Messages',
        icon: 'archive'
      },
      buttons: [{
        text: 'No'
      }, {
        text: 'Yes',
        type: 'green',
        icon: 'checkmark'
      }]
    }

    this.showModalBasic = () => {
      this.refs.modal_basic.show()
    }

    this.on('mount', () => {
      PR.prettyPrint(false)
    })
  </script>
</demo-modal>