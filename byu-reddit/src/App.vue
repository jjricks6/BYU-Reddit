<template>
  <div id="app">
    <v-app-bar
    hide-on-scroll
    >
    <v-app-bar-nav-icon><v-icon large>mdi-alpha-y-circle-outline</v-icon></v-app-bar-nav-icon>

      <v-toolbar-title>BYU REDDIT</v-toolbar-title>

      <v-spacer></v-spacer>

      <!-- Search -->
      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

      <!-- Profile -->
      <v-btn 
        icon
        >
        <v-avatar>
          <img :src="'https://byu-reddit-media.s3.us-west-2.amazonaws.com/' + profile_picture"/>
        </v-avatar>
      </v-btn>

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
