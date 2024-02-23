import { graphql } from '@/gql';

export const CURRENT_USER = graphql(/* GraphQL */ `
  query currentUser {
    users {
      id
      email
      username
      first_name
      last_name
      avatar
      has_contributed
      email_verified
      google_id
      passkeys {
        id
        credential_id
        created_at
        updated_at
        description
      }
      tokens {
        id
        client
        expires_at
        created_at
      }
      city {
        id
        name
        state {
          id
          name
        }
      }
    }
  }
`);

export const MEMBERSHIP_TYPE = graphql(/* GraphQL */ `
  query membershipTypeByEmail($email: String!) {
    membershipTypeByEmail(email: $email) {
      message
      data {
        type
        passkeys
      }
    }
  }
`);

export const LOGIN = graphql(/* GraphQL */ `
  mutation login($email: String!, $password: String!) {
    login(email: $email, password: $password) {
      code
      data {
        accessToken
        refreshToken
      }
      message
    }
  }
`);

export const LOGIN_WITH_MAGIC_LINK = graphql(/* GraphQL */ `
  mutation loginWithMagicLink($email: String!) {
    loginWithMagicLink(email: $email) {
      code
      data
      message
    }
  }
`);
export const REGISTER = graphql(/* GraphQL */ `
  mutation register($input: RegisterInput!) {
    register(input: $input) {
      data {
        user {
          id
          email
        }
        tokens {
          accessToken
          refreshToken
        }
      }
      success
      message
      errors
    }
  }
`);

export const SEND_EMAIL_OTP = graphql(/* GraphQL */ `
  mutation sendEmailOtp($email: String!) {
    sendEmailOtp(email: $email) {
      code
      data
      message
    }
  }
`);

export const VERIFY_EMAIL_OTP = graphql(/* GraphQL */ `
  mutation verifyOtp($input: OtpInput!) {
    verifyOtp(input: $input) {
      code
      message
      data
    }
  }
`);

export const AUTH_CODE_EXCHANGE = graphql(/* GraphQL */ `
  mutation authCodeExchange($code: String!, $type: String!) {
    authCodeExchange(code: $code, type: $type) {
      code
      message
      success
      data {
        accessToken
        refreshToken
      }
    }
  }
`);

export const FORGOT_PASSWORD = graphql(/* GraphQL */ `
  mutation forgotPassword($identity: String!) {
    forgotPassword(identity: $identity) {
      code
      data
      success
      message
    }
  }
`);

export const FORGOT_PASSWORD_CONFIRM = graphql(/* GraphQL */ `
  mutation forgotPasswordConfirm($input: ForgotPasswordConfirmInput!) {
    forgotPasswordConfirm(input: $input) {
      data {
        accessToken
        refreshToken
      }
      success
      code
      message
    }
  }
`);

export const REGISTER_PASSKEY = graphql(/* GraphQL */ `
  mutation passkeyRegisterOptions($name: String!) {
    passkeyRegisterOptions(name: $name) {
      data
      code
      message
      success
    }
  }
`);

export const VERIFY_PASSKEY_REGISTERATION = graphql(/* GraphQL */ `
  mutation passkeyRegisterVerify($credential: String!) {
    passkeyRegisterVerify(credential: $credential) {
      data {
        passKey {
          id
          credentialId
          userId
        }
        tokens {
          accessToken
          refreshToken
        }
      }
      code
      message
      success
    }
  }
`);

export const PASSKEY_AUTH_OPTIONS = graphql(/* GraphQL */ `
  mutation passkeyAuthOptions {
    passkeyAuthOptions {
      code
      data
      message
    }
  }
`);

export const PASSKEY_AUTH_OPTIONS_VERIFY = graphql(/* GraphQL */ `
  mutation passkeyAuthOptionsVerify($credential: String!, $credentialId: String!) {
    passkeyAuthOptionsVerify(credential: $credential, credentialId: $credentialId) {
      code
      message
      data {
        accessToken
        refreshToken
      }
    }
  }
`);

export const DELETE_USER_TOKENS = graphql(/* GraphQL */ `
  mutation delete_user_tokens($where: user_tokens_bool_exp!) {
    delete_user_tokens(where: $where) {
      returning {
        id
        client
      }
      affected_rows
    }
  }
`);

export const DELETE_USER_PASSKEYS = graphql(/* GraphQL */ `
  mutation delete_user_passkeys($where: user_passkeys_bool_exp!) {
    delete_user_passkeys(where: $where) {
      returning {
        id
        credential_id
      }
      affected_rows
    }
  }
`);

export const CITIES = graphql(/* GraphQL */ `
  query cities(
    $distinct_on: [cities_select_column!]
    $limit: Int
    $offset: Int
    $order_by: [cities_order_by!]
    $where: cities_bool_exp
  ) {
    cities(
      distinct_on: $distinct_on
      limit: $limit
      offset: $offset
      order_by: $order_by
      where: $where
    ) {
      id
      name
      state {
        id
        name
      }
    }
  }
`);
