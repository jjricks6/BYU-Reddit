<!-- eslint-disable -->

<template>
  <v-card
    class="mx-auto"
    max-width="434"
    tile
  >
    <v-img
      height="100%"
      src="https://cdn.vuetifyjs.com/images/cards/server-room.jpg"
    >
      <v-row
        align="end"
        class="fill-height"
      >
        <v-col
          align-self="start"
          class="pa-0"
          cols="12"
        >
          <v-avatar
            class="profile"
            color="grey"
            size="164"
          >
            <img :src="'https://byu-reddit-media.s3.us-west-2.amazonaws.com/' + user.profilepicture" />
          </v-avatar>
        </v-col>
        <v-col class="py-0">
          <v-list-item
            color="rgba(0, 0, 0, .4)"
            dark
          >
            <v-list-item-content>
              <v-list-item-title class="text-h6">
                {{user.username}}
              </v-list-item-title>
              <v-list-item-subtitle>{{user.bio}}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>
    </v-img>
  <v-btn
      v-if="isSameUser"
      @click="edit = true"
      class="mx-2"
      fab
      dark
      large
      color="cyan"
    >
      <v-icon dark>
        mdi-pencil
      </v-icon>
      
    </v-btn>
    <!--<v-btn
      v-if="isSameUser"
      large
      dark
      red
      id = "delete" @click="deleteUser()"
    >
        Delete Profile
      
    </v-btn>-->
    <v-card elevation="0" min-width="300" v-if="edit">
    <v-container>
      <v-row>
        <v-col cols="1">
        </v-col>
        <v-col cols="10">
          <v-text-field
          label="New Bio"
          v-model="newBio"
          >
          </v-text-field> 
        </v-col>
        <v-col cols="1">
          <v-btn icon @click="changeBio(user.userid, newBio)">
            <v-icon>
              mdi-send
            </v-icon>
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-card>
  </v-card>
</template>

<script>
import Api from "../api";
//import Post from "../components/Post.vue"

export default {
  methods:{
    changeBio(userid, newBio) {
      Api.changeBio(userid, newBio)
    }
  },
    deleteUser() {
      Api.deleteUser(this.$store.state.user.userid).then(() => {
        this.$router.push(`/Login`);
        });
    },
  
  computed:{
    isSameUser : function(){
      return this.$store.state.user.username == this.user.username }, 
    isAdmin : function(){
      return this.$store.state.user.role == "admin" }
  },

  components:{
//    Post
  },
  name: "ProfilePage",
  data: function () {
    return {
      loading: false,
      user: [],
      edit: false,
      newBio: "",
      //filter_items: ["Top", "Popular"]
    };
  },
  created: function () {
    this.loading = true;
    Api.getProfile(this.$route.params.username).then((res) => {
      this.user = res.data[0];
      this.newBio = this.user.bio;
    });
  },
};
</script>

<style scoped>

  #delete {
    background-color: red;
  }

</style>