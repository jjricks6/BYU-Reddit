<!-- eslint-disable -->

<template>
<v-app>
  <v-card elevation="10" min-width="1000">
    <v-container>
    <v-row>
      <v-col center-allign justify cols='1'>
        <v-avatar size='60'>
          <img :src="'https://byu-reddit-media.s3.us-west-2.amazonaws.com/'+ community_picture"/>
        </v-avatar>
      </v-col>
      <v-col cols=10>
        <v-row dense>
          <v-col>
            <v-card-title>
              <v-text-field
                label="Post Title"
                v-model="title"
              ></v-text-field>
            </v-card-title>
            <v-card-subtitle>{{ community }} </v-card-subtitle>
          </v-col>
        </v-row>
      </v-col>
      <v-col cols='1'>
      </v-col>
    </v-row>
    <v-row>
      <v-container>
        <v-row>
          <v-col cols="1">
          </v-col>
          <v-col cols="10">
            <v-select data-app
              v-model="picture"
              :items="items"
              label="Picture"
            ></v-select>
          </v-col>
        </v-row>
        <v-row>
        </v-row>
        <v-row>
          <v-col cols="10">
          </v-col>
          <v-col cols="2">
            <v-btn @click="createPost(title, picture, communityid)">
              Submit
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-row>
    </v-container>
  </v-card>
</v-app>
</template>

<script>
import Api from "../api";

export default {
  methods:{
    createPost(title, picture, communityid){
      Api.createPost(title, picture, communityid, this.$store.state.user.userid).then(() => {
        this.$router.push(`/c/${this.community}/`);
      });
      
    }
  },
  props: {
    community: String,
    community_picture: String,
    communityid: Number
  },

  data() {
    return {
      title: "",
      picture: null,
      items: ['BYU_Logo.png', 'Databases.png', 'Default.png', 'Dope.png', 'f12020.jpg', 'post1.jpg', 'rum.png']
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

