<template>
  <div id="app">
    <v-app-bar>
    <v-app-bar-nav-icon @click="goHome()">
      <v-icon large>mdi-alpha-y-circle-outline</v-icon>
    </v-app-bar-nav-icon>

      <v-app-bar-title>BYU REDDIT</v-app-bar-title>

      <v-spacer></v-spacer>

      <!-- Search -->
      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

      <!-- Profile -->
      <div v-if="isLoggedIn">
        <v-btn plain @click="logout()">
          Logout
        </v-btn>
        <v-btn icon @click="profilePage()">
          <v-avatar>
            <img :src="'https://byu-reddit-media.s3.us-west-2.amazonaws.com/' + this.$store.state.user.profilepicture"/>
          </v-avatar>
        </v-btn>
      </div>
      <div v-else>
        <v-btn plain @click="loginPage()">
          Login
        </v-btn>
        <v-btn plain @click="registerPage()">
          Register
        </v-btn>
      </div>

      <!-- Options -->
      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn>
      <template v-slot:extension>
         <v-tabs grow>
          <v-tab @click="goHome()">
            Explore
          </v-tab>
          <v-tab @click="goFeed()">
            My Feed
          </v-tab>
      </v-tabs>
      </template>
    </v-app-bar>
    <v-container>
      <router-view></router-view>
    </v-container>
  </div>
</template>

<script>
export default {
  computed: {
    isLoggedIn : function(){
      return this.$store.state.user.username != undefined }
  },
  methods:{
    loginPage(){
      this.$router.push('/login');
    },
    registerPage(){
      this.$router.push('/register');
    },
    profilePage(){
      this.$router.push(`/u/${this.$store.state.user.username}`);
    },
    goHome(){
      this.$router.push('/')
    },
    goFeed(){
      this.$router.push('/feed')
    },
    async logout (){
        this.$store.commit('logout')
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
