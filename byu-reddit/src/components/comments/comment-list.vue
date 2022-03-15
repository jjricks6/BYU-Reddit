<template>
  <v-layout row wrap align-end>
    <comment-form
      :showSaveButton="commentableId !== null"
      :value="getComment('tmp')"
      @input="editComment($event)"
      class="flex xs12"
      v-bind="{commentableId, commentableType}"
      v-if="!isReadOnly"
    />

    <v-flex xs12>
      <v-container fluid grid-list-lg class="px-0">
        <v-layout row wrap tag="ul">
          <comment-details
            :activeReply.sync="activeReply"
            :key="[$options.name, comment.id].join('_')"
            :newCommentMap.sync="value_"
            @input="editComment($event)"
            class="flex xs12"
            showReplies
            v-bind="{comment, isReadOnly}"
            v-for="comment in comments"
          />
        </v-layout>
      </v-container>
    </v-flex>
  </v-layout>
</template>
<script>
// Components
import commentDetails from "./comment-details.vue";
import commentForm from "./comment-form.vue";

// Mixins
import { validationMixin } from "vuelidate";
import hasComments from "./mixins/hasComments";

// Models
import Comment from "../../store/models/Comment";

export default {
  name: "comment-list",

  props: {
    /**
     * Whether to disable comment actions
     */
    isReadOnly: Boolean,

    /**
     * The current list of new comments
     */
    value: Array
  },

  data() {
    return {
      /**
       * The ID of the comment to which the user is currently replying
       */
      activeReply: null
    };
  },

  components: {
    commentDetails,
    commentForm
  },

  mixins: [hasComments, validationMixin],

  computed: {
    /**
     * All existing comments for the related entity
     * @returns {Array<Comment>}
     */
    comments() {
      return Comment.query()
        .withAllRecursive()
        .where("commentable_id", this.commentableId)
        .where("commentable_type", this.commentableType)
        .hasNot("parent_id") // Exclude children, as they will be populated as relationships within their parent
        .orderBy("modified_date", "asc")
        .get()
        .reverse();
    },

    newCommentsWithValues() {
      // Return only comments with values
      return Array.from(this.value_.values()).filter(comment =>
        Boolean(comment.comment)
      );
    },

    /**
     * Whether the form has any unsaved comments
     * @returns {boolean}
     */
    dirty() {
      return this.newCommentsWithValues.length > 0;
    },

    /**
     * Prevent mutating state by using a instance of `value`, and emit any changes.
     * @returns {Array}
     * @see this.value
     */
    value_: {
      get() {
        if (this.value) return this.value;

        return [];
      },

      set(value) {
        console.log(this.$options.name, "value_/set", value);
        this.$emit("input", value);
      }
    }
  },

  methods: {
    /**
     * Replace the Map on edit, since any updates to Maps are not inherently reactive
     */
    editComment(comment) {
      let valueClone = JSON.parse(JSON.stringify(this.value_));
      let index = valueClone.findIndex(v => v.id === comment.id);

      if (index === -1) {
        valueClone.push(comment);
      } else {
        this.$set(valueClone, index, comment);
      }

      this.value_ = valueClone;
    },

    getComment(id) {
      return this.value_.find(comment => comment.id === id);
    }
  },

  mounted() {
    this.$emit("update:dirty", this.dirty);
  },

  watch: {
    dirty(newVal, oldVal) {
      this.$emit("update:dirty", newVal);
    }
  }
};
</script>
