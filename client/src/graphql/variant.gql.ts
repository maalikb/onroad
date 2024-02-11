import { graphql } from '@/gql';

export const VARIANTS = graphql(/* GraphQL */ `
  query variants(
    $distinct_on: [variants_select_column!]
    $limit: Int
    $offset: Int
    $order_by: [variants_order_by!]
    $where: variants_bool_exp
  ) {
    variants(
      distinct_on: $distinct_on
      limit: $limit
      offset: $offset
      order_by: $order_by
      where: $where
    ) {
      id
      name
      slug
      manufacturer_link
      vehicle {
        id
        name
      }
    }
  }
`);

export const VARIANT_COLORS = graphql(/* GraphQL */ `
  query variant_colors(
    $distinct_on: [variant_colors_select_column!]
    $limit: Int
    $offset: Int
    $order_by: [variant_colors_order_by!]
    $where: variant_colors_bool_exp
  ) {
    variant_colors(
      distinct_on: $distinct_on
      limit: $limit
      offset: $offset
      order_by: $order_by
      where: $where
    ) {
      id
      name
      hex_code
    }
  }
`);

export const VARIANTS_LIST = graphql(/* GraphQL */ `
  query variantsList(
    $distinct_on: [variants_select_column!]
    $limit: Int
    $offset: Int
    $order_by: [variants_order_by!]
    $where: variants_bool_exp
    $contributions_where: contributions_bool_exp
  ) {
    variants(
      distinct_on: $distinct_on
      limit: $limit
      offset: $offset
      order_by: $order_by
      where: $where
    ) {
      id
      name
      slug
      manufacturer_link
      colors {
        id
        attachments {
          id
          attachment {
            id
            url
          }
        }
      }
      vehicle {
        id
        type {
          id
          name
        }
      }
      short_description
      contributions_aggregate(
        order_by: { created_at: desc, upvotes: desc }
        limit: 5
        where: $contributions_where
      ) {
        aggregate {
          avg {
            total
          }
        }
      }
    }
    variants_aggregate(distinct_on: $distinct_on, order_by: $order_by, where: $where) {
      aggregate {
        count
      }
    }
  }
`);

export const VARIANT_DETAIL = graphql(/* GraphQL */ `
  query VariantDetail($slug: String, $contributions_where: contributions_bool_exp) {
    variants(where: { slug: { _eq: $slug } }, limit: 1) {
      id
      name
      launch_date
      transmission
      fuel_type
      description
      specifications
      vehicle {
        id
        type {
          id
          name
        }
      }
      colors {
        id
        name
        attachments {
          id
          attachment {
            id
            url
          }
        }
      }
      contributions(
        order_by: { created_at: desc, upvotes: desc }
        limit: 1
        where: $contributions_where
      ) {
        id
        total
        upvotes
        downvotes
        items(order_by: { price_item: { serial_no: asc_nulls_last } }) {
          id
          price_item {
            id
            name
            type
            category
          }
        }
      }
    }
  }
`);

export const VARIANT_CONTRIBUTIONS = graphql(/* GraphQL */ `
  query VariantContributions($where: contributions_bool_exp) {
    contributions(order_by: { created_at: desc, upvotes: desc }, where: $where) {
      id
      total
      upvotes
      downvotes
      items(order_by: { price_item: { serial_no: asc_nulls_last } }) {
        id
        price_item {
          id
          name
          type
          category
        }
      }
    }
  }
`);
