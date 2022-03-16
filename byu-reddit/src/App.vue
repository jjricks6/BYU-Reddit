<template>
  <div id="app">
    <v-app-bar
    hide-on-scroll
    >
    <v-app-bar-nav-icon @click="goHome()">
      <v-icon large>mdi-alpha-y-circle-outline</v-icon>
    </v-app-bar-nav-icon>

      <v-toolbar-title>BYU REDDIT</v-toolbar-title>

      <v-spacer></v-spacer>

      <!-- Search -->
      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

      <!-- Profile -->
      <v-btn v-if="isLoggedIn" icon @click="profilePage()">
        <v-avatar>
          <img :src="'https://byu-reddit-media.s3.us-west-2.amazonaws.com/' + this.$store.state.user.profilepicture"/>
        </v-avatar>
      </v-btn>
      <div v-else>
        <v-btn @click="loginPage()">
          Login
        </v-btn>
        <v-btn @click="registerPage()">
          Register
        </v-btn>
      </div>

      <!-- Options -->
      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn>
    </v-app-bar>
    <v-container>
      <router-view></router-view>
    </v-container>
  </div>
</template>

<script>
export default {
  computed: {
    isLoggedIn : function(){ return this.$store.state.user != undefined }
  },
  methods:{
    loginPage(){
      this.$router.push('/login');
    },
    profilePage(){
      this.$router.push('/profile');
    },
    goHome(){
      this.$router.push('/')
    },
    async logout (){
        await this.$store.dispatch('LogOut')
        this.$router.push('/login')
      }
  },
  name: "App",
  components: {},
  data() {
    return {
      profile_picture: "f12020.jpg"
    }
  }
};
</script>

<style>
</style>
