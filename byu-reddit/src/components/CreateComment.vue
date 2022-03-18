<!-- eslint-disable -->

<template>
  <v-card elevation="0" min-width="300">
    <v-container>
      <v-row>
        <v-col cols="1">
        </v-col>
        <v-col cols="10">
          <v-text-field
          label="Add your comment..."
          v-model="comment"
          >
          </v-text-field> 
        </v-col>
        <v-col cols="1">
          <v-btn icon @click="addComment(comment, postid)">
            <v-icon>
              mdi-send
            </v-icon>
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-card>
</template>

<script>
import Api from "../api";
export default {
  methods:{
    addComment(comment, postid) {
      Api.addComment(comment, postid, this.$store.state.user.userid)
    }
  },
  props: {
    postid: Number

  },

  data() {
    return {
      comment: ""
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

