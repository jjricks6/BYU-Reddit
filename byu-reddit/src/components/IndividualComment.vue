<!-- eslint-disable -->

<template>
  <v-card elevation="0" min-width="300">
    <v-container>
        <div>
            hello why doesnt this work
        </div>    
    </v-container>
  </v-card>
</template>

<script>
import Api from "../api";
export default {
  computed: {
    isLoggedIn : function(){
      return this.$store.state.user.username != undefined }
  },
  methods:{
    goToPost(community, id) {
    
    }
  },
  props: {
    Comment: String
  },

  data() {
    return {
      
    }
  }
}
</script>

<style>
.buttons {
  justify-content: flex-end;
}

.title {
  justify-content: flex-start;
}

.missing-data {
  font-weight: lighter;
  font-size: 24px;
  color: #CCCCCC;
}

.time {
  color: #a0a0a0
}

@media only screen and (max-width: 600px) {
  .buttons {
    justify-content: center;
  }
  .title {
    justify-content: center;
    text-align: center;
  }

}
</style>

