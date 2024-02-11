/* eslint-disable */
import { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';
export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = { [_ in K]?: never };
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
  /** The `JSON` scalar type represents JSON values as specified by [ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf). */
  JSON: { input: any; output: any; }
  UUID: { input: any; output: any; }
  /** Represents NULL values */
  Void: { input: any; output: any; }
  bigint: { input: any; output: any; }
  bytea: { input: any; output: any; }
  date: { input: any; output: any; }
  jsonb: { input: any; output: any; }
  numeric: { input: any; output: any; }
  smallint: { input: any; output: any; }
  timestamptz: { input: any; output: any; }
  uuid: { input: any; output: any; }
};

export type AuthCodeExchangeResponse = {
  __typename?: 'AuthCodeExchangeResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Tokens>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

/** Boolean expression to compare columns of type "Boolean". All fields are combined with logical 'AND'. */
export type Boolean_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['Boolean']['input']>;
  _gt?: InputMaybe<Scalars['Boolean']['input']>;
  _gte?: InputMaybe<Scalars['Boolean']['input']>;
  _in?: InputMaybe<Array<Scalars['Boolean']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['Boolean']['input']>;
  _lte?: InputMaybe<Scalars['Boolean']['input']>;
  _neq?: InputMaybe<Scalars['Boolean']['input']>;
  _nin?: InputMaybe<Array<Scalars['Boolean']['input']>>;
};

export type ChangePasswordResponse = {
  __typename?: 'ChangePasswordResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Scalars['Void']['output']>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type ForgotPasswordConfirmInput = {
  confirmPassword: Scalars['String']['input'];
  password: Scalars['String']['input'];
  token: Scalars['String']['input'];
  userId: Scalars['UUID']['input'];
};

export type ForgotPasswordConfirmResponse = {
  __typename?: 'ForgotPasswordConfirmResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Tokens>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type ForgotPasswordResponse = {
  __typename?: 'ForgotPasswordResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Scalars['Void']['output']>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

/** Boolean expression to compare columns of type "Int". All fields are combined with logical 'AND'. */
export type Int_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['Int']['input']>;
  _gt?: InputMaybe<Scalars['Int']['input']>;
  _gte?: InputMaybe<Scalars['Int']['input']>;
  _in?: InputMaybe<Array<Scalars['Int']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['Int']['input']>;
  _lte?: InputMaybe<Scalars['Int']['input']>;
  _neq?: InputMaybe<Scalars['Int']['input']>;
  _nin?: InputMaybe<Array<Scalars['Int']['input']>>;
};

export type LoginResponse = {
  __typename?: 'LoginResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Tokens>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type LoginWithMagicLinkResponse = {
  __typename?: 'LoginWithMagicLinkResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Scalars['Void']['output']>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type MembershipTypeByEmailResponse = {
  __typename?: 'MembershipTypeByEmailResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Scalars['String']['output']>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type MyContributionsResponse = {
  __typename?: 'MyContributionsResponse';
  code: Scalars['Int']['output'];
  data: Array<Scalars['UUID']['output']>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

/** UserToken(created_at, updated_at, id, user, token, used, expires_at, type, client, description) */
export type OtpInput = {
  otp: Scalars['String']['input'];
  type: Scalars['String']['input'];
};

export type PassKey = {
  __typename?: 'PassKey';
  credentialId: Scalars['String']['output'];
  id: Scalars['UUID']['output'];
  userId: Scalars['UUID']['output'];
};

export type PasskeyAuthOptionsResponse = {
  __typename?: 'PasskeyAuthOptionsResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Scalars['JSON']['output']>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type PasskeyAuthOptionsVerifyResponse = {
  __typename?: 'PasskeyAuthOptionsVerifyResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Tokens>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type PasskeyRegisterOptions = {
  __typename?: 'PasskeyRegisterOptions';
  code: Scalars['Int']['output'];
  data?: Maybe<Scalars['JSON']['output']>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type PasskeyRegisterVerifyData = {
  __typename?: 'PasskeyRegisterVerifyData';
  passKey: PassKey;
  tokens: Tokens;
};

export type PasskeyRegisterVerifyResponse = {
  __typename?: 'PasskeyRegisterVerifyResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<PasskeyRegisterVerifyData>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type RegisterDataType = {
  __typename?: 'RegisterDataType';
  tokens: Tokens;
  user: UserType;
};

export type RegisterInput = {
  cityId?: InputMaybe<Scalars['UUID']['input']>;
  confirmPassword: Scalars['String']['input'];
  email: Scalars['String']['input'];
  firstName?: InputMaybe<Scalars['String']['input']>;
  lastName?: InputMaybe<Scalars['String']['input']>;
  password: Scalars['String']['input'];
};

export type RegisterResponse = {
  __typename?: 'RegisterResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<RegisterDataType>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

export type SendEmailOtpResponse = {
  __typename?: 'SendEmailOtpResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Scalars['Void']['output']>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

/** Boolean expression to compare columns of type "String". All fields are combined with logical 'AND'. */
export type String_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['String']['input']>;
  _gt?: InputMaybe<Scalars['String']['input']>;
  _gte?: InputMaybe<Scalars['String']['input']>;
  /** does the column match the given case-insensitive pattern */
  _ilike?: InputMaybe<Scalars['String']['input']>;
  _in?: InputMaybe<Array<Scalars['String']['input']>>;
  /** does the column match the given POSIX regular expression, case insensitive */
  _iregex?: InputMaybe<Scalars['String']['input']>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  /** does the column match the given pattern */
  _like?: InputMaybe<Scalars['String']['input']>;
  _lt?: InputMaybe<Scalars['String']['input']>;
  _lte?: InputMaybe<Scalars['String']['input']>;
  _neq?: InputMaybe<Scalars['String']['input']>;
  /** does the column NOT match the given case-insensitive pattern */
  _nilike?: InputMaybe<Scalars['String']['input']>;
  _nin?: InputMaybe<Array<Scalars['String']['input']>>;
  /** does the column NOT match the given POSIX regular expression, case insensitive */
  _niregex?: InputMaybe<Scalars['String']['input']>;
  /** does the column NOT match the given pattern */
  _nlike?: InputMaybe<Scalars['String']['input']>;
  /** does the column NOT match the given POSIX regular expression, case sensitive */
  _nregex?: InputMaybe<Scalars['String']['input']>;
  /** does the column NOT match the given SQL regular expression */
  _nsimilar?: InputMaybe<Scalars['String']['input']>;
  /** does the column match the given POSIX regular expression, case sensitive */
  _regex?: InputMaybe<Scalars['String']['input']>;
  /** does the column match the given SQL regular expression */
  _similar?: InputMaybe<Scalars['String']['input']>;
};

export type Tokens = {
  __typename?: 'Tokens';
  accessToken: Scalars['String']['output'];
  refreshToken: Scalars['UUID']['output'];
};

export type UserType = {
  __typename?: 'UserType';
  city?: Maybe<Scalars['UUID']['output']>;
  email: Scalars['String']['output'];
  firstName?: Maybe<Scalars['String']['output']>;
  id: Scalars['UUID']['output'];
  lastName?: Maybe<Scalars['String']['output']>;
  username: Scalars['String']['output'];
};

export type VerifyOtpResponse = {
  __typename?: 'VerifyOtpResponse';
  code: Scalars['Int']['output'];
  data?: Maybe<Scalars['Void']['output']>;
  errors?: Maybe<Scalars['JSON']['output']>;
  message: Scalars['String']['output'];
  success: Scalars['Boolean']['output'];
};

/** columns and relationships of "attachments" */
export type Attachments = {
  __typename?: 'attachments';
  created_at: Scalars['timestamptz']['output'];
  created_by_id: Scalars['uuid']['output'];
  etag?: Maybe<Scalars['String']['output']>;
  id: Scalars['uuid']['output'];
  key?: Maybe<Scalars['String']['output']>;
  mime_type: Scalars['String']['output'];
  size?: Maybe<Scalars['Int']['output']>;
  updated_at: Scalars['timestamptz']['output'];
  url: Scalars['String']['output'];
};

/** aggregated selection of "attachments" */
export type Attachments_Aggregate = {
  __typename?: 'attachments_aggregate';
  aggregate?: Maybe<Attachments_Aggregate_Fields>;
  nodes: Array<Attachments>;
};

/** aggregate fields of "attachments" */
export type Attachments_Aggregate_Fields = {
  __typename?: 'attachments_aggregate_fields';
  avg?: Maybe<Attachments_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Attachments_Max_Fields>;
  min?: Maybe<Attachments_Min_Fields>;
  stddev?: Maybe<Attachments_Stddev_Fields>;
  stddev_pop?: Maybe<Attachments_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Attachments_Stddev_Samp_Fields>;
  sum?: Maybe<Attachments_Sum_Fields>;
  var_pop?: Maybe<Attachments_Var_Pop_Fields>;
  var_samp?: Maybe<Attachments_Var_Samp_Fields>;
  variance?: Maybe<Attachments_Variance_Fields>;
};


/** aggregate fields of "attachments" */
export type Attachments_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Attachments_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** aggregate avg on columns */
export type Attachments_Avg_Fields = {
  __typename?: 'attachments_avg_fields';
  size?: Maybe<Scalars['Float']['output']>;
};

/** Boolean expression to filter rows from the table "attachments". All fields are combined with a logical 'AND'. */
export type Attachments_Bool_Exp = {
  _and?: InputMaybe<Array<Attachments_Bool_Exp>>;
  _not?: InputMaybe<Attachments_Bool_Exp>;
  _or?: InputMaybe<Array<Attachments_Bool_Exp>>;
  created_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  created_by_id?: InputMaybe<Uuid_Comparison_Exp>;
  etag?: InputMaybe<String_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  key?: InputMaybe<String_Comparison_Exp>;
  mime_type?: InputMaybe<String_Comparison_Exp>;
  size?: InputMaybe<Int_Comparison_Exp>;
  updated_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  url?: InputMaybe<String_Comparison_Exp>;
};

/** unique or primary key constraints on table "attachments" */
export enum Attachments_Constraint {
  /** unique or primary key constraint on columns "id" */
  AttachmentsPkey = 'attachments_pkey'
}

/** input type for incrementing numeric columns in table "attachments" */
export type Attachments_Inc_Input = {
  size?: InputMaybe<Scalars['Int']['input']>;
};

/** input type for inserting data into table "attachments" */
export type Attachments_Insert_Input = {
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  created_by_id?: InputMaybe<Scalars['uuid']['input']>;
  etag?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  key?: InputMaybe<Scalars['String']['input']>;
  mime_type?: InputMaybe<Scalars['String']['input']>;
  size?: InputMaybe<Scalars['Int']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  url?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate max on columns */
export type Attachments_Max_Fields = {
  __typename?: 'attachments_max_fields';
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  created_by_id?: Maybe<Scalars['uuid']['output']>;
  etag?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  key?: Maybe<Scalars['String']['output']>;
  mime_type?: Maybe<Scalars['String']['output']>;
  size?: Maybe<Scalars['Int']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  url?: Maybe<Scalars['String']['output']>;
};

/** aggregate min on columns */
export type Attachments_Min_Fields = {
  __typename?: 'attachments_min_fields';
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  created_by_id?: Maybe<Scalars['uuid']['output']>;
  etag?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  key?: Maybe<Scalars['String']['output']>;
  mime_type?: Maybe<Scalars['String']['output']>;
  size?: Maybe<Scalars['Int']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  url?: Maybe<Scalars['String']['output']>;
};

/** response of any mutation on the table "attachments" */
export type Attachments_Mutation_Response = {
  __typename?: 'attachments_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Attachments>;
};

/** input type for inserting object relation for remote table "attachments" */
export type Attachments_Obj_Rel_Insert_Input = {
  data: Attachments_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Attachments_On_Conflict>;
};

/** on_conflict condition type for table "attachments" */
export type Attachments_On_Conflict = {
  constraint: Attachments_Constraint;
  update_columns?: Array<Attachments_Update_Column>;
  where?: InputMaybe<Attachments_Bool_Exp>;
};

/** Ordering options when selecting data from "attachments". */
export type Attachments_Order_By = {
  created_at?: InputMaybe<Order_By>;
  created_by_id?: InputMaybe<Order_By>;
  etag?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  key?: InputMaybe<Order_By>;
  mime_type?: InputMaybe<Order_By>;
  size?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  url?: InputMaybe<Order_By>;
};

/** primary key columns input for table: attachments */
export type Attachments_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "attachments" */
export enum Attachments_Select_Column {
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  CreatedById = 'created_by_id',
  /** column name */
  Etag = 'etag',
  /** column name */
  Id = 'id',
  /** column name */
  Key = 'key',
  /** column name */
  MimeType = 'mime_type',
  /** column name */
  Size = 'size',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Url = 'url'
}

/** input type for updating data in table "attachments" */
export type Attachments_Set_Input = {
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  created_by_id?: InputMaybe<Scalars['uuid']['input']>;
  etag?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  key?: InputMaybe<Scalars['String']['input']>;
  mime_type?: InputMaybe<Scalars['String']['input']>;
  size?: InputMaybe<Scalars['Int']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  url?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate stddev on columns */
export type Attachments_Stddev_Fields = {
  __typename?: 'attachments_stddev_fields';
  size?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_pop on columns */
export type Attachments_Stddev_Pop_Fields = {
  __typename?: 'attachments_stddev_pop_fields';
  size?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_samp on columns */
export type Attachments_Stddev_Samp_Fields = {
  __typename?: 'attachments_stddev_samp_fields';
  size?: Maybe<Scalars['Float']['output']>;
};

/** Streaming cursor of the table "attachments" */
export type Attachments_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Attachments_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Attachments_Stream_Cursor_Value_Input = {
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  created_by_id?: InputMaybe<Scalars['uuid']['input']>;
  etag?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  key?: InputMaybe<Scalars['String']['input']>;
  mime_type?: InputMaybe<Scalars['String']['input']>;
  size?: InputMaybe<Scalars['Int']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  url?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate sum on columns */
export type Attachments_Sum_Fields = {
  __typename?: 'attachments_sum_fields';
  size?: Maybe<Scalars['Int']['output']>;
};

/** update columns of table "attachments" */
export enum Attachments_Update_Column {
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  CreatedById = 'created_by_id',
  /** column name */
  Etag = 'etag',
  /** column name */
  Id = 'id',
  /** column name */
  Key = 'key',
  /** column name */
  MimeType = 'mime_type',
  /** column name */
  Size = 'size',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Url = 'url'
}

export type Attachments_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Attachments_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Attachments_Set_Input>;
  /** filter the rows which have to be updated */
  where: Attachments_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Attachments_Var_Pop_Fields = {
  __typename?: 'attachments_var_pop_fields';
  size?: Maybe<Scalars['Float']['output']>;
};

/** aggregate var_samp on columns */
export type Attachments_Var_Samp_Fields = {
  __typename?: 'attachments_var_samp_fields';
  size?: Maybe<Scalars['Float']['output']>;
};

/** aggregate variance on columns */
export type Attachments_Variance_Fields = {
  __typename?: 'attachments_variance_fields';
  size?: Maybe<Scalars['Float']['output']>;
};

/** columns and relationships of "auth_group" */
export type Auth_Group = {
  __typename?: 'auth_group';
  id: Scalars['Int']['output'];
  name: Scalars['String']['output'];
};

/** aggregated selection of "auth_group" */
export type Auth_Group_Aggregate = {
  __typename?: 'auth_group_aggregate';
  aggregate?: Maybe<Auth_Group_Aggregate_Fields>;
  nodes: Array<Auth_Group>;
};

/** aggregate fields of "auth_group" */
export type Auth_Group_Aggregate_Fields = {
  __typename?: 'auth_group_aggregate_fields';
  avg?: Maybe<Auth_Group_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Auth_Group_Max_Fields>;
  min?: Maybe<Auth_Group_Min_Fields>;
  stddev?: Maybe<Auth_Group_Stddev_Fields>;
  stddev_pop?: Maybe<Auth_Group_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Auth_Group_Stddev_Samp_Fields>;
  sum?: Maybe<Auth_Group_Sum_Fields>;
  var_pop?: Maybe<Auth_Group_Var_Pop_Fields>;
  var_samp?: Maybe<Auth_Group_Var_Samp_Fields>;
  variance?: Maybe<Auth_Group_Variance_Fields>;
};


/** aggregate fields of "auth_group" */
export type Auth_Group_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Auth_Group_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** aggregate avg on columns */
export type Auth_Group_Avg_Fields = {
  __typename?: 'auth_group_avg_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** Boolean expression to filter rows from the table "auth_group". All fields are combined with a logical 'AND'. */
export type Auth_Group_Bool_Exp = {
  _and?: InputMaybe<Array<Auth_Group_Bool_Exp>>;
  _not?: InputMaybe<Auth_Group_Bool_Exp>;
  _or?: InputMaybe<Array<Auth_Group_Bool_Exp>>;
  id?: InputMaybe<Int_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
};

/** unique or primary key constraints on table "auth_group" */
export enum Auth_Group_Constraint {
  /** unique or primary key constraint on columns "name" */
  AuthGroupNameKey = 'auth_group_name_key',
  /** unique or primary key constraint on columns "id" */
  AuthGroupPkey = 'auth_group_pkey'
}

/** input type for incrementing numeric columns in table "auth_group" */
export type Auth_Group_Inc_Input = {
  id?: InputMaybe<Scalars['Int']['input']>;
};

/** input type for inserting data into table "auth_group" */
export type Auth_Group_Insert_Input = {
  id?: InputMaybe<Scalars['Int']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate max on columns */
export type Auth_Group_Max_Fields = {
  __typename?: 'auth_group_max_fields';
  id?: Maybe<Scalars['Int']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** aggregate min on columns */
export type Auth_Group_Min_Fields = {
  __typename?: 'auth_group_min_fields';
  id?: Maybe<Scalars['Int']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** response of any mutation on the table "auth_group" */
export type Auth_Group_Mutation_Response = {
  __typename?: 'auth_group_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Auth_Group>;
};

/** on_conflict condition type for table "auth_group" */
export type Auth_Group_On_Conflict = {
  constraint: Auth_Group_Constraint;
  update_columns?: Array<Auth_Group_Update_Column>;
  where?: InputMaybe<Auth_Group_Bool_Exp>;
};

/** Ordering options when selecting data from "auth_group". */
export type Auth_Group_Order_By = {
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
};

/** columns and relationships of "auth_group_permissions" */
export type Auth_Group_Permissions = {
  __typename?: 'auth_group_permissions';
  group_id: Scalars['Int']['output'];
  id: Scalars['bigint']['output'];
  permission_id: Scalars['Int']['output'];
};

/** aggregated selection of "auth_group_permissions" */
export type Auth_Group_Permissions_Aggregate = {
  __typename?: 'auth_group_permissions_aggregate';
  aggregate?: Maybe<Auth_Group_Permissions_Aggregate_Fields>;
  nodes: Array<Auth_Group_Permissions>;
};

/** aggregate fields of "auth_group_permissions" */
export type Auth_Group_Permissions_Aggregate_Fields = {
  __typename?: 'auth_group_permissions_aggregate_fields';
  avg?: Maybe<Auth_Group_Permissions_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Auth_Group_Permissions_Max_Fields>;
  min?: Maybe<Auth_Group_Permissions_Min_Fields>;
  stddev?: Maybe<Auth_Group_Permissions_Stddev_Fields>;
  stddev_pop?: Maybe<Auth_Group_Permissions_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Auth_Group_Permissions_Stddev_Samp_Fields>;
  sum?: Maybe<Auth_Group_Permissions_Sum_Fields>;
  var_pop?: Maybe<Auth_Group_Permissions_Var_Pop_Fields>;
  var_samp?: Maybe<Auth_Group_Permissions_Var_Samp_Fields>;
  variance?: Maybe<Auth_Group_Permissions_Variance_Fields>;
};


/** aggregate fields of "auth_group_permissions" */
export type Auth_Group_Permissions_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Auth_Group_Permissions_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** aggregate avg on columns */
export type Auth_Group_Permissions_Avg_Fields = {
  __typename?: 'auth_group_permissions_avg_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** Boolean expression to filter rows from the table "auth_group_permissions". All fields are combined with a logical 'AND'. */
export type Auth_Group_Permissions_Bool_Exp = {
  _and?: InputMaybe<Array<Auth_Group_Permissions_Bool_Exp>>;
  _not?: InputMaybe<Auth_Group_Permissions_Bool_Exp>;
  _or?: InputMaybe<Array<Auth_Group_Permissions_Bool_Exp>>;
  group_id?: InputMaybe<Int_Comparison_Exp>;
  id?: InputMaybe<Bigint_Comparison_Exp>;
  permission_id?: InputMaybe<Int_Comparison_Exp>;
};

/** unique or primary key constraints on table "auth_group_permissions" */
export enum Auth_Group_Permissions_Constraint {
  /** unique or primary key constraint on columns "permission_id", "group_id" */
  AuthGroupPermissionsGroupIdPermissionId_0cd325b0Uniq = 'auth_group_permissions_group_id_permission_id_0cd325b0_uniq',
  /** unique or primary key constraint on columns "id" */
  AuthGroupPermissionsPkey = 'auth_group_permissions_pkey'
}

/** input type for incrementing numeric columns in table "auth_group_permissions" */
export type Auth_Group_Permissions_Inc_Input = {
  group_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  permission_id?: InputMaybe<Scalars['Int']['input']>;
};

/** input type for inserting data into table "auth_group_permissions" */
export type Auth_Group_Permissions_Insert_Input = {
  group_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  permission_id?: InputMaybe<Scalars['Int']['input']>;
};

/** aggregate max on columns */
export type Auth_Group_Permissions_Max_Fields = {
  __typename?: 'auth_group_permissions_max_fields';
  group_id?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
  permission_id?: Maybe<Scalars['Int']['output']>;
};

/** aggregate min on columns */
export type Auth_Group_Permissions_Min_Fields = {
  __typename?: 'auth_group_permissions_min_fields';
  group_id?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
  permission_id?: Maybe<Scalars['Int']['output']>;
};

/** response of any mutation on the table "auth_group_permissions" */
export type Auth_Group_Permissions_Mutation_Response = {
  __typename?: 'auth_group_permissions_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Auth_Group_Permissions>;
};

/** on_conflict condition type for table "auth_group_permissions" */
export type Auth_Group_Permissions_On_Conflict = {
  constraint: Auth_Group_Permissions_Constraint;
  update_columns?: Array<Auth_Group_Permissions_Update_Column>;
  where?: InputMaybe<Auth_Group_Permissions_Bool_Exp>;
};

/** Ordering options when selecting data from "auth_group_permissions". */
export type Auth_Group_Permissions_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: auth_group_permissions */
export type Auth_Group_Permissions_Pk_Columns_Input = {
  id: Scalars['bigint']['input'];
};

/** select columns of table "auth_group_permissions" */
export enum Auth_Group_Permissions_Select_Column {
  /** column name */
  GroupId = 'group_id',
  /** column name */
  Id = 'id',
  /** column name */
  PermissionId = 'permission_id'
}

/** input type for updating data in table "auth_group_permissions" */
export type Auth_Group_Permissions_Set_Input = {
  group_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  permission_id?: InputMaybe<Scalars['Int']['input']>;
};

/** aggregate stddev on columns */
export type Auth_Group_Permissions_Stddev_Fields = {
  __typename?: 'auth_group_permissions_stddev_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_pop on columns */
export type Auth_Group_Permissions_Stddev_Pop_Fields = {
  __typename?: 'auth_group_permissions_stddev_pop_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_samp on columns */
export type Auth_Group_Permissions_Stddev_Samp_Fields = {
  __typename?: 'auth_group_permissions_stddev_samp_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** Streaming cursor of the table "auth_group_permissions" */
export type Auth_Group_Permissions_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Auth_Group_Permissions_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Auth_Group_Permissions_Stream_Cursor_Value_Input = {
  group_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  permission_id?: InputMaybe<Scalars['Int']['input']>;
};

/** aggregate sum on columns */
export type Auth_Group_Permissions_Sum_Fields = {
  __typename?: 'auth_group_permissions_sum_fields';
  group_id?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
  permission_id?: Maybe<Scalars['Int']['output']>;
};

/** update columns of table "auth_group_permissions" */
export enum Auth_Group_Permissions_Update_Column {
  /** column name */
  GroupId = 'group_id',
  /** column name */
  Id = 'id',
  /** column name */
  PermissionId = 'permission_id'
}

export type Auth_Group_Permissions_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Auth_Group_Permissions_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Auth_Group_Permissions_Set_Input>;
  /** filter the rows which have to be updated */
  where: Auth_Group_Permissions_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Auth_Group_Permissions_Var_Pop_Fields = {
  __typename?: 'auth_group_permissions_var_pop_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate var_samp on columns */
export type Auth_Group_Permissions_Var_Samp_Fields = {
  __typename?: 'auth_group_permissions_var_samp_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate variance on columns */
export type Auth_Group_Permissions_Variance_Fields = {
  __typename?: 'auth_group_permissions_variance_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** primary key columns input for table: auth_group */
export type Auth_Group_Pk_Columns_Input = {
  id: Scalars['Int']['input'];
};

/** select columns of table "auth_group" */
export enum Auth_Group_Select_Column {
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

/** input type for updating data in table "auth_group" */
export type Auth_Group_Set_Input = {
  id?: InputMaybe<Scalars['Int']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate stddev on columns */
export type Auth_Group_Stddev_Fields = {
  __typename?: 'auth_group_stddev_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_pop on columns */
export type Auth_Group_Stddev_Pop_Fields = {
  __typename?: 'auth_group_stddev_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_samp on columns */
export type Auth_Group_Stddev_Samp_Fields = {
  __typename?: 'auth_group_stddev_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** Streaming cursor of the table "auth_group" */
export type Auth_Group_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Auth_Group_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Auth_Group_Stream_Cursor_Value_Input = {
  id?: InputMaybe<Scalars['Int']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate sum on columns */
export type Auth_Group_Sum_Fields = {
  __typename?: 'auth_group_sum_fields';
  id?: Maybe<Scalars['Int']['output']>;
};

/** update columns of table "auth_group" */
export enum Auth_Group_Update_Column {
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

export type Auth_Group_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Auth_Group_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Auth_Group_Set_Input>;
  /** filter the rows which have to be updated */
  where: Auth_Group_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Auth_Group_Var_Pop_Fields = {
  __typename?: 'auth_group_var_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate var_samp on columns */
export type Auth_Group_Var_Samp_Fields = {
  __typename?: 'auth_group_var_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate variance on columns */
export type Auth_Group_Variance_Fields = {
  __typename?: 'auth_group_variance_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** columns and relationships of "auth_permission" */
export type Auth_Permission = {
  __typename?: 'auth_permission';
  codename: Scalars['String']['output'];
  content_type_id: Scalars['Int']['output'];
  id: Scalars['Int']['output'];
  name: Scalars['String']['output'];
};

/** aggregated selection of "auth_permission" */
export type Auth_Permission_Aggregate = {
  __typename?: 'auth_permission_aggregate';
  aggregate?: Maybe<Auth_Permission_Aggregate_Fields>;
  nodes: Array<Auth_Permission>;
};

/** aggregate fields of "auth_permission" */
export type Auth_Permission_Aggregate_Fields = {
  __typename?: 'auth_permission_aggregate_fields';
  avg?: Maybe<Auth_Permission_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Auth_Permission_Max_Fields>;
  min?: Maybe<Auth_Permission_Min_Fields>;
  stddev?: Maybe<Auth_Permission_Stddev_Fields>;
  stddev_pop?: Maybe<Auth_Permission_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Auth_Permission_Stddev_Samp_Fields>;
  sum?: Maybe<Auth_Permission_Sum_Fields>;
  var_pop?: Maybe<Auth_Permission_Var_Pop_Fields>;
  var_samp?: Maybe<Auth_Permission_Var_Samp_Fields>;
  variance?: Maybe<Auth_Permission_Variance_Fields>;
};


/** aggregate fields of "auth_permission" */
export type Auth_Permission_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Auth_Permission_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** aggregate avg on columns */
export type Auth_Permission_Avg_Fields = {
  __typename?: 'auth_permission_avg_fields';
  content_type_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** Boolean expression to filter rows from the table "auth_permission". All fields are combined with a logical 'AND'. */
export type Auth_Permission_Bool_Exp = {
  _and?: InputMaybe<Array<Auth_Permission_Bool_Exp>>;
  _not?: InputMaybe<Auth_Permission_Bool_Exp>;
  _or?: InputMaybe<Array<Auth_Permission_Bool_Exp>>;
  codename?: InputMaybe<String_Comparison_Exp>;
  content_type_id?: InputMaybe<Int_Comparison_Exp>;
  id?: InputMaybe<Int_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
};

/** unique or primary key constraints on table "auth_permission" */
export enum Auth_Permission_Constraint {
  /** unique or primary key constraint on columns "codename", "content_type_id" */
  AuthPermissionContentTypeIdCodename_01ab375aUniq = 'auth_permission_content_type_id_codename_01ab375a_uniq',
  /** unique or primary key constraint on columns "id" */
  AuthPermissionPkey = 'auth_permission_pkey'
}

/** input type for incrementing numeric columns in table "auth_permission" */
export type Auth_Permission_Inc_Input = {
  content_type_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['Int']['input']>;
};

/** input type for inserting data into table "auth_permission" */
export type Auth_Permission_Insert_Input = {
  codename?: InputMaybe<Scalars['String']['input']>;
  content_type_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['Int']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate max on columns */
export type Auth_Permission_Max_Fields = {
  __typename?: 'auth_permission_max_fields';
  codename?: Maybe<Scalars['String']['output']>;
  content_type_id?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['Int']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** aggregate min on columns */
export type Auth_Permission_Min_Fields = {
  __typename?: 'auth_permission_min_fields';
  codename?: Maybe<Scalars['String']['output']>;
  content_type_id?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['Int']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** response of any mutation on the table "auth_permission" */
export type Auth_Permission_Mutation_Response = {
  __typename?: 'auth_permission_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Auth_Permission>;
};

/** on_conflict condition type for table "auth_permission" */
export type Auth_Permission_On_Conflict = {
  constraint: Auth_Permission_Constraint;
  update_columns?: Array<Auth_Permission_Update_Column>;
  where?: InputMaybe<Auth_Permission_Bool_Exp>;
};

/** Ordering options when selecting data from "auth_permission". */
export type Auth_Permission_Order_By = {
  codename?: InputMaybe<Order_By>;
  content_type_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
};

/** primary key columns input for table: auth_permission */
export type Auth_Permission_Pk_Columns_Input = {
  id: Scalars['Int']['input'];
};

/** select columns of table "auth_permission" */
export enum Auth_Permission_Select_Column {
  /** column name */
  Codename = 'codename',
  /** column name */
  ContentTypeId = 'content_type_id',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

/** input type for updating data in table "auth_permission" */
export type Auth_Permission_Set_Input = {
  codename?: InputMaybe<Scalars['String']['input']>;
  content_type_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['Int']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate stddev on columns */
export type Auth_Permission_Stddev_Fields = {
  __typename?: 'auth_permission_stddev_fields';
  content_type_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_pop on columns */
export type Auth_Permission_Stddev_Pop_Fields = {
  __typename?: 'auth_permission_stddev_pop_fields';
  content_type_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_samp on columns */
export type Auth_Permission_Stddev_Samp_Fields = {
  __typename?: 'auth_permission_stddev_samp_fields';
  content_type_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** Streaming cursor of the table "auth_permission" */
export type Auth_Permission_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Auth_Permission_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Auth_Permission_Stream_Cursor_Value_Input = {
  codename?: InputMaybe<Scalars['String']['input']>;
  content_type_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['Int']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate sum on columns */
export type Auth_Permission_Sum_Fields = {
  __typename?: 'auth_permission_sum_fields';
  content_type_id?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['Int']['output']>;
};

/** update columns of table "auth_permission" */
export enum Auth_Permission_Update_Column {
  /** column name */
  Codename = 'codename',
  /** column name */
  ContentTypeId = 'content_type_id',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

export type Auth_Permission_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Auth_Permission_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Auth_Permission_Set_Input>;
  /** filter the rows which have to be updated */
  where: Auth_Permission_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Auth_Permission_Var_Pop_Fields = {
  __typename?: 'auth_permission_var_pop_fields';
  content_type_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate var_samp on columns */
export type Auth_Permission_Var_Samp_Fields = {
  __typename?: 'auth_permission_var_samp_fields';
  content_type_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** aggregate variance on columns */
export type Auth_Permission_Variance_Fields = {
  __typename?: 'auth_permission_variance_fields';
  content_type_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** Boolean expression to compare columns of type "bigint". All fields are combined with logical 'AND'. */
export type Bigint_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['bigint']['input']>;
  _gt?: InputMaybe<Scalars['bigint']['input']>;
  _gte?: InputMaybe<Scalars['bigint']['input']>;
  _in?: InputMaybe<Array<Scalars['bigint']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['bigint']['input']>;
  _lte?: InputMaybe<Scalars['bigint']['input']>;
  _neq?: InputMaybe<Scalars['bigint']['input']>;
  _nin?: InputMaybe<Array<Scalars['bigint']['input']>>;
};

/** Boolean expression to compare columns of type "bytea". All fields are combined with logical 'AND'. */
export type Bytea_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['bytea']['input']>;
  _gt?: InputMaybe<Scalars['bytea']['input']>;
  _gte?: InputMaybe<Scalars['bytea']['input']>;
  _in?: InputMaybe<Array<Scalars['bytea']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['bytea']['input']>;
  _lte?: InputMaybe<Scalars['bytea']['input']>;
  _neq?: InputMaybe<Scalars['bytea']['input']>;
  _nin?: InputMaybe<Array<Scalars['bytea']['input']>>;
};

/** columns and relationships of "cities" */
export type Cities = {
  __typename?: 'cities';
  code?: Maybe<Scalars['String']['output']>;
  /** An array relationship */
  contributions: Array<Contributions>;
  /** An aggregate relationship */
  contributions_aggregate: Contributions_Aggregate;
  id: Scalars['uuid']['output'];
  name: Scalars['String']['output'];
  /** An object relationship */
  state: States;
  state_id: Scalars['uuid']['output'];
};


/** columns and relationships of "cities" */
export type CitiesContributionsArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


/** columns and relationships of "cities" */
export type CitiesContributions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};

/** aggregated selection of "cities" */
export type Cities_Aggregate = {
  __typename?: 'cities_aggregate';
  aggregate?: Maybe<Cities_Aggregate_Fields>;
  nodes: Array<Cities>;
};

export type Cities_Aggregate_Bool_Exp = {
  count?: InputMaybe<Cities_Aggregate_Bool_Exp_Count>;
};

export type Cities_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Cities_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Cities_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "cities" */
export type Cities_Aggregate_Fields = {
  __typename?: 'cities_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<Cities_Max_Fields>;
  min?: Maybe<Cities_Min_Fields>;
};


/** aggregate fields of "cities" */
export type Cities_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Cities_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "cities" */
export type Cities_Aggregate_Order_By = {
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Cities_Max_Order_By>;
  min?: InputMaybe<Cities_Min_Order_By>;
};

/** input type for inserting array relation for remote table "cities" */
export type Cities_Arr_Rel_Insert_Input = {
  data: Array<Cities_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Cities_On_Conflict>;
};

/** Boolean expression to filter rows from the table "cities". All fields are combined with a logical 'AND'. */
export type Cities_Bool_Exp = {
  _and?: InputMaybe<Array<Cities_Bool_Exp>>;
  _not?: InputMaybe<Cities_Bool_Exp>;
  _or?: InputMaybe<Array<Cities_Bool_Exp>>;
  code?: InputMaybe<String_Comparison_Exp>;
  contributions?: InputMaybe<Contributions_Bool_Exp>;
  contributions_aggregate?: InputMaybe<Contributions_Aggregate_Bool_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
  state?: InputMaybe<States_Bool_Exp>;
  state_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "cities" */
export enum Cities_Constraint {
  /** unique or primary key constraint on columns "id" */
  CitiesPkey = 'cities_pkey'
}

/** input type for inserting data into table "cities" */
export type Cities_Insert_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  contributions?: InputMaybe<Contributions_Arr_Rel_Insert_Input>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  state?: InputMaybe<States_Obj_Rel_Insert_Input>;
  state_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Cities_Max_Fields = {
  __typename?: 'cities_max_fields';
  code?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  state_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "cities" */
export type Cities_Max_Order_By = {
  code?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  state_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Cities_Min_Fields = {
  __typename?: 'cities_min_fields';
  code?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  state_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "cities" */
export type Cities_Min_Order_By = {
  code?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  state_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "cities" */
export type Cities_Mutation_Response = {
  __typename?: 'cities_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Cities>;
};

/** input type for inserting object relation for remote table "cities" */
export type Cities_Obj_Rel_Insert_Input = {
  data: Cities_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Cities_On_Conflict>;
};

/** on_conflict condition type for table "cities" */
export type Cities_On_Conflict = {
  constraint: Cities_Constraint;
  update_columns?: Array<Cities_Update_Column>;
  where?: InputMaybe<Cities_Bool_Exp>;
};

/** Ordering options when selecting data from "cities". */
export type Cities_Order_By = {
  code?: InputMaybe<Order_By>;
  contributions_aggregate?: InputMaybe<Contributions_Aggregate_Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  state?: InputMaybe<States_Order_By>;
  state_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: cities */
export type Cities_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "cities" */
export enum Cities_Select_Column {
  /** column name */
  Code = 'code',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name',
  /** column name */
  StateId = 'state_id'
}

/** input type for updating data in table "cities" */
export type Cities_Set_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  state_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** Streaming cursor of the table "cities" */
export type Cities_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Cities_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Cities_Stream_Cursor_Value_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  state_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** update columns of table "cities" */
export enum Cities_Update_Column {
  /** column name */
  Code = 'code',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name',
  /** column name */
  StateId = 'state_id'
}

export type Cities_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Cities_Set_Input>;
  /** filter the rows which have to be updated */
  where: Cities_Bool_Exp;
};

/** columns and relationships of "contribution_price_items" */
export type Contribution_Price_Items = {
  __typename?: 'contribution_price_items';
  /** An object relationship */
  contribution: Contributions;
  contribution_id: Scalars['uuid']['output'];
  created_at: Scalars['timestamptz']['output'];
  id: Scalars['uuid']['output'];
  /** An object relationship */
  price_item: Price_Items;
  price_item_id: Scalars['uuid']['output'];
  serial_no: Scalars['smallint']['output'];
  updated_at: Scalars['timestamptz']['output'];
  value: Scalars['numeric']['output'];
};

/** aggregated selection of "contribution_price_items" */
export type Contribution_Price_Items_Aggregate = {
  __typename?: 'contribution_price_items_aggregate';
  aggregate?: Maybe<Contribution_Price_Items_Aggregate_Fields>;
  nodes: Array<Contribution_Price_Items>;
};

export type Contribution_Price_Items_Aggregate_Bool_Exp = {
  count?: InputMaybe<Contribution_Price_Items_Aggregate_Bool_Exp_Count>;
};

export type Contribution_Price_Items_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Contribution_Price_Items_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "contribution_price_items" */
export type Contribution_Price_Items_Aggregate_Fields = {
  __typename?: 'contribution_price_items_aggregate_fields';
  avg?: Maybe<Contribution_Price_Items_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Contribution_Price_Items_Max_Fields>;
  min?: Maybe<Contribution_Price_Items_Min_Fields>;
  stddev?: Maybe<Contribution_Price_Items_Stddev_Fields>;
  stddev_pop?: Maybe<Contribution_Price_Items_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Contribution_Price_Items_Stddev_Samp_Fields>;
  sum?: Maybe<Contribution_Price_Items_Sum_Fields>;
  var_pop?: Maybe<Contribution_Price_Items_Var_Pop_Fields>;
  var_samp?: Maybe<Contribution_Price_Items_Var_Samp_Fields>;
  variance?: Maybe<Contribution_Price_Items_Variance_Fields>;
};


/** aggregate fields of "contribution_price_items" */
export type Contribution_Price_Items_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Contribution_Price_Items_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "contribution_price_items" */
export type Contribution_Price_Items_Aggregate_Order_By = {
  avg?: InputMaybe<Contribution_Price_Items_Avg_Order_By>;
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Contribution_Price_Items_Max_Order_By>;
  min?: InputMaybe<Contribution_Price_Items_Min_Order_By>;
  stddev?: InputMaybe<Contribution_Price_Items_Stddev_Order_By>;
  stddev_pop?: InputMaybe<Contribution_Price_Items_Stddev_Pop_Order_By>;
  stddev_samp?: InputMaybe<Contribution_Price_Items_Stddev_Samp_Order_By>;
  sum?: InputMaybe<Contribution_Price_Items_Sum_Order_By>;
  var_pop?: InputMaybe<Contribution_Price_Items_Var_Pop_Order_By>;
  var_samp?: InputMaybe<Contribution_Price_Items_Var_Samp_Order_By>;
  variance?: InputMaybe<Contribution_Price_Items_Variance_Order_By>;
};

/** input type for inserting array relation for remote table "contribution_price_items" */
export type Contribution_Price_Items_Arr_Rel_Insert_Input = {
  data: Array<Contribution_Price_Items_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Contribution_Price_Items_On_Conflict>;
};

/** aggregate avg on columns */
export type Contribution_Price_Items_Avg_Fields = {
  __typename?: 'contribution_price_items_avg_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
  value?: Maybe<Scalars['Float']['output']>;
};

/** order by avg() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Avg_Order_By = {
  serial_no?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** Boolean expression to filter rows from the table "contribution_price_items". All fields are combined with a logical 'AND'. */
export type Contribution_Price_Items_Bool_Exp = {
  _and?: InputMaybe<Array<Contribution_Price_Items_Bool_Exp>>;
  _not?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
  _or?: InputMaybe<Array<Contribution_Price_Items_Bool_Exp>>;
  contribution?: InputMaybe<Contributions_Bool_Exp>;
  contribution_id?: InputMaybe<Uuid_Comparison_Exp>;
  created_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  price_item?: InputMaybe<Price_Items_Bool_Exp>;
  price_item_id?: InputMaybe<Uuid_Comparison_Exp>;
  serial_no?: InputMaybe<Smallint_Comparison_Exp>;
  updated_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  value?: InputMaybe<Numeric_Comparison_Exp>;
};

/** unique or primary key constraints on table "contribution_price_items" */
export enum Contribution_Price_Items_Constraint {
  /** unique or primary key constraint on columns "price_item_id", "contribution_id" */
  ContributionPriceItemUnique = 'contribution_price_item_unique',
  /** unique or primary key constraint on columns "id" */
  ContributionPriceItemsPkey = 'contribution_price_items_pkey',
  /** unique or primary key constraint on columns "serial_no", "contribution_id" */
  ContributionSerialNoUnique = 'contribution_serial_no_unique'
}

/** input type for incrementing numeric columns in table "contribution_price_items" */
export type Contribution_Price_Items_Inc_Input = {
  serial_no?: InputMaybe<Scalars['smallint']['input']>;
  value?: InputMaybe<Scalars['numeric']['input']>;
};

/** input type for inserting data into table "contribution_price_items" */
export type Contribution_Price_Items_Insert_Input = {
  contribution?: InputMaybe<Contributions_Obj_Rel_Insert_Input>;
  contribution_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  price_item?: InputMaybe<Price_Items_Obj_Rel_Insert_Input>;
  price_item_id?: InputMaybe<Scalars['uuid']['input']>;
  serial_no?: InputMaybe<Scalars['smallint']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  value?: InputMaybe<Scalars['numeric']['input']>;
};

/** aggregate max on columns */
export type Contribution_Price_Items_Max_Fields = {
  __typename?: 'contribution_price_items_max_fields';
  contribution_id?: Maybe<Scalars['uuid']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  price_item_id?: Maybe<Scalars['uuid']['output']>;
  serial_no?: Maybe<Scalars['smallint']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  value?: Maybe<Scalars['numeric']['output']>;
};

/** order by max() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Max_Order_By = {
  contribution_id?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  price_item_id?: InputMaybe<Order_By>;
  serial_no?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Contribution_Price_Items_Min_Fields = {
  __typename?: 'contribution_price_items_min_fields';
  contribution_id?: Maybe<Scalars['uuid']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  price_item_id?: Maybe<Scalars['uuid']['output']>;
  serial_no?: Maybe<Scalars['smallint']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  value?: Maybe<Scalars['numeric']['output']>;
};

/** order by min() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Min_Order_By = {
  contribution_id?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  price_item_id?: InputMaybe<Order_By>;
  serial_no?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "contribution_price_items" */
export type Contribution_Price_Items_Mutation_Response = {
  __typename?: 'contribution_price_items_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Contribution_Price_Items>;
};

/** on_conflict condition type for table "contribution_price_items" */
export type Contribution_Price_Items_On_Conflict = {
  constraint: Contribution_Price_Items_Constraint;
  update_columns?: Array<Contribution_Price_Items_Update_Column>;
  where?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
};

/** Ordering options when selecting data from "contribution_price_items". */
export type Contribution_Price_Items_Order_By = {
  contribution?: InputMaybe<Contributions_Order_By>;
  contribution_id?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  price_item?: InputMaybe<Price_Items_Order_By>;
  price_item_id?: InputMaybe<Order_By>;
  serial_no?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** primary key columns input for table: contribution_price_items */
export type Contribution_Price_Items_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "contribution_price_items" */
export enum Contribution_Price_Items_Select_Column {
  /** column name */
  ContributionId = 'contribution_id',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  Id = 'id',
  /** column name */
  PriceItemId = 'price_item_id',
  /** column name */
  SerialNo = 'serial_no',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Value = 'value'
}

/** input type for updating data in table "contribution_price_items" */
export type Contribution_Price_Items_Set_Input = {
  contribution_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  price_item_id?: InputMaybe<Scalars['uuid']['input']>;
  serial_no?: InputMaybe<Scalars['smallint']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  value?: InputMaybe<Scalars['numeric']['input']>;
};

/** aggregate stddev on columns */
export type Contribution_Price_Items_Stddev_Fields = {
  __typename?: 'contribution_price_items_stddev_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
  value?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Stddev_Order_By = {
  serial_no?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** aggregate stddev_pop on columns */
export type Contribution_Price_Items_Stddev_Pop_Fields = {
  __typename?: 'contribution_price_items_stddev_pop_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
  value?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_pop() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Stddev_Pop_Order_By = {
  serial_no?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** aggregate stddev_samp on columns */
export type Contribution_Price_Items_Stddev_Samp_Fields = {
  __typename?: 'contribution_price_items_stddev_samp_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
  value?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_samp() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Stddev_Samp_Order_By = {
  serial_no?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** Streaming cursor of the table "contribution_price_items" */
export type Contribution_Price_Items_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Contribution_Price_Items_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Contribution_Price_Items_Stream_Cursor_Value_Input = {
  contribution_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  price_item_id?: InputMaybe<Scalars['uuid']['input']>;
  serial_no?: InputMaybe<Scalars['smallint']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  value?: InputMaybe<Scalars['numeric']['input']>;
};

/** aggregate sum on columns */
export type Contribution_Price_Items_Sum_Fields = {
  __typename?: 'contribution_price_items_sum_fields';
  serial_no?: Maybe<Scalars['smallint']['output']>;
  value?: Maybe<Scalars['numeric']['output']>;
};

/** order by sum() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Sum_Order_By = {
  serial_no?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** update columns of table "contribution_price_items" */
export enum Contribution_Price_Items_Update_Column {
  /** column name */
  ContributionId = 'contribution_id',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  Id = 'id',
  /** column name */
  PriceItemId = 'price_item_id',
  /** column name */
  SerialNo = 'serial_no',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Value = 'value'
}

export type Contribution_Price_Items_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Contribution_Price_Items_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Contribution_Price_Items_Set_Input>;
  /** filter the rows which have to be updated */
  where: Contribution_Price_Items_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Contribution_Price_Items_Var_Pop_Fields = {
  __typename?: 'contribution_price_items_var_pop_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
  value?: Maybe<Scalars['Float']['output']>;
};

/** order by var_pop() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Var_Pop_Order_By = {
  serial_no?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** aggregate var_samp on columns */
export type Contribution_Price_Items_Var_Samp_Fields = {
  __typename?: 'contribution_price_items_var_samp_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
  value?: Maybe<Scalars['Float']['output']>;
};

/** order by var_samp() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Var_Samp_Order_By = {
  serial_no?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** aggregate variance on columns */
export type Contribution_Price_Items_Variance_Fields = {
  __typename?: 'contribution_price_items_variance_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
  value?: Maybe<Scalars['Float']['output']>;
};

/** order by variance() on columns of table "contribution_price_items" */
export type Contribution_Price_Items_Variance_Order_By = {
  serial_no?: InputMaybe<Order_By>;
  value?: InputMaybe<Order_By>;
};

/** columns and relationships of "contributions" */
export type Contributions = {
  __typename?: 'contributions';
  /** An array relationship */
  attachments: Array<Contributions_Attachments>;
  /** An aggregate relationship */
  attachments_aggregate: Contributions_Attachments_Aggregate;
  /** An object relationship */
  city: Cities;
  city_id: Scalars['uuid']['output'];
  color_id?: Maybe<Scalars['uuid']['output']>;
  created_at: Scalars['timestamptz']['output'];
  dealership_name: Scalars['String']['output'];
  downvotes: Scalars['Int']['output'];
  id: Scalars['uuid']['output'];
  /** An array relationship */
  items: Array<Contribution_Price_Items>;
  /** An aggregate relationship */
  items_aggregate: Contribution_Price_Items_Aggregate;
  quoted_on: Scalars['date']['output'];
  remark?: Maybe<Scalars['String']['output']>;
  status: Scalars['String']['output'];
  total: Scalars['numeric']['output'];
  updated_at: Scalars['timestamptz']['output'];
  upvotes: Scalars['Int']['output'];
  /** An object relationship */
  user: Users;
  user_id: Scalars['uuid']['output'];
  /** An object relationship */
  variant: Variants;
  /** An object relationship */
  variant_color?: Maybe<Variant_Colors>;
  variant_id: Scalars['uuid']['output'];
};


/** columns and relationships of "contributions" */
export type ContributionsAttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Attachments_Order_By>>;
  where?: InputMaybe<Contributions_Attachments_Bool_Exp>;
};


/** columns and relationships of "contributions" */
export type ContributionsAttachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Attachments_Order_By>>;
  where?: InputMaybe<Contributions_Attachments_Bool_Exp>;
};


/** columns and relationships of "contributions" */
export type ContributionsItemsArgs = {
  distinct_on?: InputMaybe<Array<Contribution_Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contribution_Price_Items_Order_By>>;
  where?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
};


/** columns and relationships of "contributions" */
export type ContributionsItems_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contribution_Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contribution_Price_Items_Order_By>>;
  where?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
};

/** aggregated selection of "contributions" */
export type Contributions_Aggregate = {
  __typename?: 'contributions_aggregate';
  aggregate?: Maybe<Contributions_Aggregate_Fields>;
  nodes: Array<Contributions>;
};

export type Contributions_Aggregate_Bool_Exp = {
  count?: InputMaybe<Contributions_Aggregate_Bool_Exp_Count>;
};

export type Contributions_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Contributions_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Contributions_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "contributions" */
export type Contributions_Aggregate_Fields = {
  __typename?: 'contributions_aggregate_fields';
  avg?: Maybe<Contributions_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Contributions_Max_Fields>;
  min?: Maybe<Contributions_Min_Fields>;
  stddev?: Maybe<Contributions_Stddev_Fields>;
  stddev_pop?: Maybe<Contributions_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Contributions_Stddev_Samp_Fields>;
  sum?: Maybe<Contributions_Sum_Fields>;
  var_pop?: Maybe<Contributions_Var_Pop_Fields>;
  var_samp?: Maybe<Contributions_Var_Samp_Fields>;
  variance?: Maybe<Contributions_Variance_Fields>;
};


/** aggregate fields of "contributions" */
export type Contributions_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Contributions_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "contributions" */
export type Contributions_Aggregate_Order_By = {
  avg?: InputMaybe<Contributions_Avg_Order_By>;
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Contributions_Max_Order_By>;
  min?: InputMaybe<Contributions_Min_Order_By>;
  stddev?: InputMaybe<Contributions_Stddev_Order_By>;
  stddev_pop?: InputMaybe<Contributions_Stddev_Pop_Order_By>;
  stddev_samp?: InputMaybe<Contributions_Stddev_Samp_Order_By>;
  sum?: InputMaybe<Contributions_Sum_Order_By>;
  var_pop?: InputMaybe<Contributions_Var_Pop_Order_By>;
  var_samp?: InputMaybe<Contributions_Var_Samp_Order_By>;
  variance?: InputMaybe<Contributions_Variance_Order_By>;
};

/** input type for inserting array relation for remote table "contributions" */
export type Contributions_Arr_Rel_Insert_Input = {
  data: Array<Contributions_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Contributions_On_Conflict>;
};

/** columns and relationships of "contributions_attachments" */
export type Contributions_Attachments = {
  __typename?: 'contributions_attachments';
  /** An object relationship */
  attachment: Attachments;
  attachment_id: Scalars['uuid']['output'];
  /** An object relationship */
  contribution: Contributions;
  contribution_id: Scalars['uuid']['output'];
  id: Scalars['bigint']['output'];
};

/** aggregated selection of "contributions_attachments" */
export type Contributions_Attachments_Aggregate = {
  __typename?: 'contributions_attachments_aggregate';
  aggregate?: Maybe<Contributions_Attachments_Aggregate_Fields>;
  nodes: Array<Contributions_Attachments>;
};

export type Contributions_Attachments_Aggregate_Bool_Exp = {
  count?: InputMaybe<Contributions_Attachments_Aggregate_Bool_Exp_Count>;
};

export type Contributions_Attachments_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Contributions_Attachments_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Contributions_Attachments_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "contributions_attachments" */
export type Contributions_Attachments_Aggregate_Fields = {
  __typename?: 'contributions_attachments_aggregate_fields';
  avg?: Maybe<Contributions_Attachments_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Contributions_Attachments_Max_Fields>;
  min?: Maybe<Contributions_Attachments_Min_Fields>;
  stddev?: Maybe<Contributions_Attachments_Stddev_Fields>;
  stddev_pop?: Maybe<Contributions_Attachments_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Contributions_Attachments_Stddev_Samp_Fields>;
  sum?: Maybe<Contributions_Attachments_Sum_Fields>;
  var_pop?: Maybe<Contributions_Attachments_Var_Pop_Fields>;
  var_samp?: Maybe<Contributions_Attachments_Var_Samp_Fields>;
  variance?: Maybe<Contributions_Attachments_Variance_Fields>;
};


/** aggregate fields of "contributions_attachments" */
export type Contributions_Attachments_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Contributions_Attachments_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "contributions_attachments" */
export type Contributions_Attachments_Aggregate_Order_By = {
  avg?: InputMaybe<Contributions_Attachments_Avg_Order_By>;
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Contributions_Attachments_Max_Order_By>;
  min?: InputMaybe<Contributions_Attachments_Min_Order_By>;
  stddev?: InputMaybe<Contributions_Attachments_Stddev_Order_By>;
  stddev_pop?: InputMaybe<Contributions_Attachments_Stddev_Pop_Order_By>;
  stddev_samp?: InputMaybe<Contributions_Attachments_Stddev_Samp_Order_By>;
  sum?: InputMaybe<Contributions_Attachments_Sum_Order_By>;
  var_pop?: InputMaybe<Contributions_Attachments_Var_Pop_Order_By>;
  var_samp?: InputMaybe<Contributions_Attachments_Var_Samp_Order_By>;
  variance?: InputMaybe<Contributions_Attachments_Variance_Order_By>;
};

/** input type for inserting array relation for remote table "contributions_attachments" */
export type Contributions_Attachments_Arr_Rel_Insert_Input = {
  data: Array<Contributions_Attachments_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Contributions_Attachments_On_Conflict>;
};

/** aggregate avg on columns */
export type Contributions_Attachments_Avg_Fields = {
  __typename?: 'contributions_attachments_avg_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by avg() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Avg_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** Boolean expression to filter rows from the table "contributions_attachments". All fields are combined with a logical 'AND'. */
export type Contributions_Attachments_Bool_Exp = {
  _and?: InputMaybe<Array<Contributions_Attachments_Bool_Exp>>;
  _not?: InputMaybe<Contributions_Attachments_Bool_Exp>;
  _or?: InputMaybe<Array<Contributions_Attachments_Bool_Exp>>;
  attachment?: InputMaybe<Attachments_Bool_Exp>;
  attachment_id?: InputMaybe<Uuid_Comparison_Exp>;
  contribution?: InputMaybe<Contributions_Bool_Exp>;
  contribution_id?: InputMaybe<Uuid_Comparison_Exp>;
  id?: InputMaybe<Bigint_Comparison_Exp>;
};

/** unique or primary key constraints on table "contributions_attachments" */
export enum Contributions_Attachments_Constraint {
  /** unique or primary key constraint on columns "attachment_id", "contribution_id" */
  ContributionsAttachmentContributionIdAttachme_1b924f0aUniq = 'contributions_attachment_contribution_id_attachme_1b924f0a_uniq',
  /** unique or primary key constraint on columns "id" */
  ContributionsAttachmentsPkey = 'contributions_attachments_pkey'
}

/** input type for incrementing numeric columns in table "contributions_attachments" */
export type Contributions_Attachments_Inc_Input = {
  id?: InputMaybe<Scalars['bigint']['input']>;
};

/** input type for inserting data into table "contributions_attachments" */
export type Contributions_Attachments_Insert_Input = {
  attachment?: InputMaybe<Attachments_Obj_Rel_Insert_Input>;
  attachment_id?: InputMaybe<Scalars['uuid']['input']>;
  contribution?: InputMaybe<Contributions_Obj_Rel_Insert_Input>;
  contribution_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
};

/** aggregate max on columns */
export type Contributions_Attachments_Max_Fields = {
  __typename?: 'contributions_attachments_max_fields';
  attachment_id?: Maybe<Scalars['uuid']['output']>;
  contribution_id?: Maybe<Scalars['uuid']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
};

/** order by max() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Max_Order_By = {
  attachment_id?: InputMaybe<Order_By>;
  contribution_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Contributions_Attachments_Min_Fields = {
  __typename?: 'contributions_attachments_min_fields';
  attachment_id?: Maybe<Scalars['uuid']['output']>;
  contribution_id?: Maybe<Scalars['uuid']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
};

/** order by min() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Min_Order_By = {
  attachment_id?: InputMaybe<Order_By>;
  contribution_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "contributions_attachments" */
export type Contributions_Attachments_Mutation_Response = {
  __typename?: 'contributions_attachments_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Contributions_Attachments>;
};

/** on_conflict condition type for table "contributions_attachments" */
export type Contributions_Attachments_On_Conflict = {
  constraint: Contributions_Attachments_Constraint;
  update_columns?: Array<Contributions_Attachments_Update_Column>;
  where?: InputMaybe<Contributions_Attachments_Bool_Exp>;
};

/** Ordering options when selecting data from "contributions_attachments". */
export type Contributions_Attachments_Order_By = {
  attachment?: InputMaybe<Attachments_Order_By>;
  attachment_id?: InputMaybe<Order_By>;
  contribution?: InputMaybe<Contributions_Order_By>;
  contribution_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: contributions_attachments */
export type Contributions_Attachments_Pk_Columns_Input = {
  id: Scalars['bigint']['input'];
};

/** select columns of table "contributions_attachments" */
export enum Contributions_Attachments_Select_Column {
  /** column name */
  AttachmentId = 'attachment_id',
  /** column name */
  ContributionId = 'contribution_id',
  /** column name */
  Id = 'id'
}

/** input type for updating data in table "contributions_attachments" */
export type Contributions_Attachments_Set_Input = {
  attachment_id?: InputMaybe<Scalars['uuid']['input']>;
  contribution_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
};

/** aggregate stddev on columns */
export type Contributions_Attachments_Stddev_Fields = {
  __typename?: 'contributions_attachments_stddev_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Stddev_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate stddev_pop on columns */
export type Contributions_Attachments_Stddev_Pop_Fields = {
  __typename?: 'contributions_attachments_stddev_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_pop() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Stddev_Pop_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate stddev_samp on columns */
export type Contributions_Attachments_Stddev_Samp_Fields = {
  __typename?: 'contributions_attachments_stddev_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_samp() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Stddev_Samp_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** Streaming cursor of the table "contributions_attachments" */
export type Contributions_Attachments_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Contributions_Attachments_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Contributions_Attachments_Stream_Cursor_Value_Input = {
  attachment_id?: InputMaybe<Scalars['uuid']['input']>;
  contribution_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
};

/** aggregate sum on columns */
export type Contributions_Attachments_Sum_Fields = {
  __typename?: 'contributions_attachments_sum_fields';
  id?: Maybe<Scalars['bigint']['output']>;
};

/** order by sum() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Sum_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** update columns of table "contributions_attachments" */
export enum Contributions_Attachments_Update_Column {
  /** column name */
  AttachmentId = 'attachment_id',
  /** column name */
  ContributionId = 'contribution_id',
  /** column name */
  Id = 'id'
}

export type Contributions_Attachments_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Contributions_Attachments_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Contributions_Attachments_Set_Input>;
  /** filter the rows which have to be updated */
  where: Contributions_Attachments_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Contributions_Attachments_Var_Pop_Fields = {
  __typename?: 'contributions_attachments_var_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_pop() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Var_Pop_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate var_samp on columns */
export type Contributions_Attachments_Var_Samp_Fields = {
  __typename?: 'contributions_attachments_var_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_samp() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Var_Samp_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate variance on columns */
export type Contributions_Attachments_Variance_Fields = {
  __typename?: 'contributions_attachments_variance_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by variance() on columns of table "contributions_attachments" */
export type Contributions_Attachments_Variance_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate avg on columns */
export type Contributions_Avg_Fields = {
  __typename?: 'contributions_avg_fields';
  downvotes?: Maybe<Scalars['Float']['output']>;
  total?: Maybe<Scalars['Float']['output']>;
  upvotes?: Maybe<Scalars['Float']['output']>;
};

/** order by avg() on columns of table "contributions" */
export type Contributions_Avg_Order_By = {
  downvotes?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
};

/** Boolean expression to filter rows from the table "contributions". All fields are combined with a logical 'AND'. */
export type Contributions_Bool_Exp = {
  _and?: InputMaybe<Array<Contributions_Bool_Exp>>;
  _not?: InputMaybe<Contributions_Bool_Exp>;
  _or?: InputMaybe<Array<Contributions_Bool_Exp>>;
  attachments?: InputMaybe<Contributions_Attachments_Bool_Exp>;
  attachments_aggregate?: InputMaybe<Contributions_Attachments_Aggregate_Bool_Exp>;
  city?: InputMaybe<Cities_Bool_Exp>;
  city_id?: InputMaybe<Uuid_Comparison_Exp>;
  color_id?: InputMaybe<Uuid_Comparison_Exp>;
  created_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  dealership_name?: InputMaybe<String_Comparison_Exp>;
  downvotes?: InputMaybe<Int_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  items?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
  items_aggregate?: InputMaybe<Contribution_Price_Items_Aggregate_Bool_Exp>;
  quoted_on?: InputMaybe<Date_Comparison_Exp>;
  remark?: InputMaybe<String_Comparison_Exp>;
  status?: InputMaybe<String_Comparison_Exp>;
  total?: InputMaybe<Numeric_Comparison_Exp>;
  updated_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  upvotes?: InputMaybe<Int_Comparison_Exp>;
  user?: InputMaybe<Users_Bool_Exp>;
  user_id?: InputMaybe<Uuid_Comparison_Exp>;
  variant?: InputMaybe<Variants_Bool_Exp>;
  variant_color?: InputMaybe<Variant_Colors_Bool_Exp>;
  variant_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "contributions" */
export enum Contributions_Constraint {
  /** unique or primary key constraint on columns "id" */
  ContributionsPkey = 'contributions_pkey'
}

/** input type for incrementing numeric columns in table "contributions" */
export type Contributions_Inc_Input = {
  downvotes?: InputMaybe<Scalars['Int']['input']>;
  total?: InputMaybe<Scalars['numeric']['input']>;
  upvotes?: InputMaybe<Scalars['Int']['input']>;
};

/** input type for inserting data into table "contributions" */
export type Contributions_Insert_Input = {
  attachments?: InputMaybe<Contributions_Attachments_Arr_Rel_Insert_Input>;
  city?: InputMaybe<Cities_Obj_Rel_Insert_Input>;
  city_id?: InputMaybe<Scalars['uuid']['input']>;
  color_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  dealership_name?: InputMaybe<Scalars['String']['input']>;
  downvotes?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  items?: InputMaybe<Contribution_Price_Items_Arr_Rel_Insert_Input>;
  quoted_on?: InputMaybe<Scalars['date']['input']>;
  remark?: InputMaybe<Scalars['String']['input']>;
  status?: InputMaybe<Scalars['String']['input']>;
  total?: InputMaybe<Scalars['numeric']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  upvotes?: InputMaybe<Scalars['Int']['input']>;
  user?: InputMaybe<Users_Obj_Rel_Insert_Input>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
  variant?: InputMaybe<Variants_Obj_Rel_Insert_Input>;
  variant_color?: InputMaybe<Variant_Colors_Obj_Rel_Insert_Input>;
  variant_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Contributions_Max_Fields = {
  __typename?: 'contributions_max_fields';
  city_id?: Maybe<Scalars['uuid']['output']>;
  color_id?: Maybe<Scalars['uuid']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  dealership_name?: Maybe<Scalars['String']['output']>;
  downvotes?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  quoted_on?: Maybe<Scalars['date']['output']>;
  remark?: Maybe<Scalars['String']['output']>;
  status?: Maybe<Scalars['String']['output']>;
  total?: Maybe<Scalars['numeric']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  upvotes?: Maybe<Scalars['Int']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
  variant_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "contributions" */
export type Contributions_Max_Order_By = {
  city_id?: InputMaybe<Order_By>;
  color_id?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  dealership_name?: InputMaybe<Order_By>;
  downvotes?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  quoted_on?: InputMaybe<Order_By>;
  remark?: InputMaybe<Order_By>;
  status?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
  variant_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Contributions_Min_Fields = {
  __typename?: 'contributions_min_fields';
  city_id?: Maybe<Scalars['uuid']['output']>;
  color_id?: Maybe<Scalars['uuid']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  dealership_name?: Maybe<Scalars['String']['output']>;
  downvotes?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  quoted_on?: Maybe<Scalars['date']['output']>;
  remark?: Maybe<Scalars['String']['output']>;
  status?: Maybe<Scalars['String']['output']>;
  total?: Maybe<Scalars['numeric']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  upvotes?: Maybe<Scalars['Int']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
  variant_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "contributions" */
export type Contributions_Min_Order_By = {
  city_id?: InputMaybe<Order_By>;
  color_id?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  dealership_name?: InputMaybe<Order_By>;
  downvotes?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  quoted_on?: InputMaybe<Order_By>;
  remark?: InputMaybe<Order_By>;
  status?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
  variant_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "contributions" */
export type Contributions_Mutation_Response = {
  __typename?: 'contributions_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Contributions>;
};

/** input type for inserting object relation for remote table "contributions" */
export type Contributions_Obj_Rel_Insert_Input = {
  data: Contributions_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Contributions_On_Conflict>;
};

/** on_conflict condition type for table "contributions" */
export type Contributions_On_Conflict = {
  constraint: Contributions_Constraint;
  update_columns?: Array<Contributions_Update_Column>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};

/** Ordering options when selecting data from "contributions". */
export type Contributions_Order_By = {
  attachments_aggregate?: InputMaybe<Contributions_Attachments_Aggregate_Order_By>;
  city?: InputMaybe<Cities_Order_By>;
  city_id?: InputMaybe<Order_By>;
  color_id?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  dealership_name?: InputMaybe<Order_By>;
  downvotes?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  items_aggregate?: InputMaybe<Contribution_Price_Items_Aggregate_Order_By>;
  quoted_on?: InputMaybe<Order_By>;
  remark?: InputMaybe<Order_By>;
  status?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
  user?: InputMaybe<Users_Order_By>;
  user_id?: InputMaybe<Order_By>;
  variant?: InputMaybe<Variants_Order_By>;
  variant_color?: InputMaybe<Variant_Colors_Order_By>;
  variant_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: contributions */
export type Contributions_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "contributions" */
export enum Contributions_Select_Column {
  /** column name */
  CityId = 'city_id',
  /** column name */
  ColorId = 'color_id',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  DealershipName = 'dealership_name',
  /** column name */
  Downvotes = 'downvotes',
  /** column name */
  Id = 'id',
  /** column name */
  QuotedOn = 'quoted_on',
  /** column name */
  Remark = 'remark',
  /** column name */
  Status = 'status',
  /** column name */
  Total = 'total',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Upvotes = 'upvotes',
  /** column name */
  UserId = 'user_id',
  /** column name */
  VariantId = 'variant_id'
}

/** input type for updating data in table "contributions" */
export type Contributions_Set_Input = {
  city_id?: InputMaybe<Scalars['uuid']['input']>;
  color_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  dealership_name?: InputMaybe<Scalars['String']['input']>;
  downvotes?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  quoted_on?: InputMaybe<Scalars['date']['input']>;
  remark?: InputMaybe<Scalars['String']['input']>;
  status?: InputMaybe<Scalars['String']['input']>;
  total?: InputMaybe<Scalars['numeric']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  upvotes?: InputMaybe<Scalars['Int']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
  variant_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate stddev on columns */
export type Contributions_Stddev_Fields = {
  __typename?: 'contributions_stddev_fields';
  downvotes?: Maybe<Scalars['Float']['output']>;
  total?: Maybe<Scalars['Float']['output']>;
  upvotes?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev() on columns of table "contributions" */
export type Contributions_Stddev_Order_By = {
  downvotes?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
};

/** aggregate stddev_pop on columns */
export type Contributions_Stddev_Pop_Fields = {
  __typename?: 'contributions_stddev_pop_fields';
  downvotes?: Maybe<Scalars['Float']['output']>;
  total?: Maybe<Scalars['Float']['output']>;
  upvotes?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_pop() on columns of table "contributions" */
export type Contributions_Stddev_Pop_Order_By = {
  downvotes?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
};

/** aggregate stddev_samp on columns */
export type Contributions_Stddev_Samp_Fields = {
  __typename?: 'contributions_stddev_samp_fields';
  downvotes?: Maybe<Scalars['Float']['output']>;
  total?: Maybe<Scalars['Float']['output']>;
  upvotes?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_samp() on columns of table "contributions" */
export type Contributions_Stddev_Samp_Order_By = {
  downvotes?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
};

/** Streaming cursor of the table "contributions" */
export type Contributions_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Contributions_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Contributions_Stream_Cursor_Value_Input = {
  city_id?: InputMaybe<Scalars['uuid']['input']>;
  color_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  dealership_name?: InputMaybe<Scalars['String']['input']>;
  downvotes?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  quoted_on?: InputMaybe<Scalars['date']['input']>;
  remark?: InputMaybe<Scalars['String']['input']>;
  status?: InputMaybe<Scalars['String']['input']>;
  total?: InputMaybe<Scalars['numeric']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  upvotes?: InputMaybe<Scalars['Int']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
  variant_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate sum on columns */
export type Contributions_Sum_Fields = {
  __typename?: 'contributions_sum_fields';
  downvotes?: Maybe<Scalars['Int']['output']>;
  total?: Maybe<Scalars['numeric']['output']>;
  upvotes?: Maybe<Scalars['Int']['output']>;
};

/** order by sum() on columns of table "contributions" */
export type Contributions_Sum_Order_By = {
  downvotes?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
};

/** update columns of table "contributions" */
export enum Contributions_Update_Column {
  /** column name */
  CityId = 'city_id',
  /** column name */
  ColorId = 'color_id',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  DealershipName = 'dealership_name',
  /** column name */
  Downvotes = 'downvotes',
  /** column name */
  Id = 'id',
  /** column name */
  QuotedOn = 'quoted_on',
  /** column name */
  Remark = 'remark',
  /** column name */
  Status = 'status',
  /** column name */
  Total = 'total',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Upvotes = 'upvotes',
  /** column name */
  UserId = 'user_id',
  /** column name */
  VariantId = 'variant_id'
}

export type Contributions_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Contributions_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Contributions_Set_Input>;
  /** filter the rows which have to be updated */
  where: Contributions_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Contributions_Var_Pop_Fields = {
  __typename?: 'contributions_var_pop_fields';
  downvotes?: Maybe<Scalars['Float']['output']>;
  total?: Maybe<Scalars['Float']['output']>;
  upvotes?: Maybe<Scalars['Float']['output']>;
};

/** order by var_pop() on columns of table "contributions" */
export type Contributions_Var_Pop_Order_By = {
  downvotes?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
};

/** aggregate var_samp on columns */
export type Contributions_Var_Samp_Fields = {
  __typename?: 'contributions_var_samp_fields';
  downvotes?: Maybe<Scalars['Float']['output']>;
  total?: Maybe<Scalars['Float']['output']>;
  upvotes?: Maybe<Scalars['Float']['output']>;
};

/** order by var_samp() on columns of table "contributions" */
export type Contributions_Var_Samp_Order_By = {
  downvotes?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
};

/** aggregate variance on columns */
export type Contributions_Variance_Fields = {
  __typename?: 'contributions_variance_fields';
  downvotes?: Maybe<Scalars['Float']['output']>;
  total?: Maybe<Scalars['Float']['output']>;
  upvotes?: Maybe<Scalars['Float']['output']>;
};

/** order by variance() on columns of table "contributions" */
export type Contributions_Variance_Order_By = {
  downvotes?: InputMaybe<Order_By>;
  total?: InputMaybe<Order_By>;
  upvotes?: InputMaybe<Order_By>;
};

/** columns and relationships of "countries" */
export type Countries = {
  __typename?: 'countries';
  code?: Maybe<Scalars['String']['output']>;
  id: Scalars['uuid']['output'];
  name: Scalars['String']['output'];
  /** An array relationship */
  states: Array<States>;
  /** An aggregate relationship */
  states_aggregate: States_Aggregate;
};


/** columns and relationships of "countries" */
export type CountriesStatesArgs = {
  distinct_on?: InputMaybe<Array<States_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<States_Order_By>>;
  where?: InputMaybe<States_Bool_Exp>;
};


/** columns and relationships of "countries" */
export type CountriesStates_AggregateArgs = {
  distinct_on?: InputMaybe<Array<States_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<States_Order_By>>;
  where?: InputMaybe<States_Bool_Exp>;
};

/** aggregated selection of "countries" */
export type Countries_Aggregate = {
  __typename?: 'countries_aggregate';
  aggregate?: Maybe<Countries_Aggregate_Fields>;
  nodes: Array<Countries>;
};

/** aggregate fields of "countries" */
export type Countries_Aggregate_Fields = {
  __typename?: 'countries_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<Countries_Max_Fields>;
  min?: Maybe<Countries_Min_Fields>;
};


/** aggregate fields of "countries" */
export type Countries_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Countries_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** Boolean expression to filter rows from the table "countries". All fields are combined with a logical 'AND'. */
export type Countries_Bool_Exp = {
  _and?: InputMaybe<Array<Countries_Bool_Exp>>;
  _not?: InputMaybe<Countries_Bool_Exp>;
  _or?: InputMaybe<Array<Countries_Bool_Exp>>;
  code?: InputMaybe<String_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
  states?: InputMaybe<States_Bool_Exp>;
  states_aggregate?: InputMaybe<States_Aggregate_Bool_Exp>;
};

/** unique or primary key constraints on table "countries" */
export enum Countries_Constraint {
  /** unique or primary key constraint on columns "id" */
  CountriesPkey = 'countries_pkey'
}

/** input type for inserting data into table "countries" */
export type Countries_Insert_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  states?: InputMaybe<States_Arr_Rel_Insert_Input>;
};

/** aggregate max on columns */
export type Countries_Max_Fields = {
  __typename?: 'countries_max_fields';
  code?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** aggregate min on columns */
export type Countries_Min_Fields = {
  __typename?: 'countries_min_fields';
  code?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** response of any mutation on the table "countries" */
export type Countries_Mutation_Response = {
  __typename?: 'countries_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Countries>;
};

/** input type for inserting object relation for remote table "countries" */
export type Countries_Obj_Rel_Insert_Input = {
  data: Countries_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Countries_On_Conflict>;
};

/** on_conflict condition type for table "countries" */
export type Countries_On_Conflict = {
  constraint: Countries_Constraint;
  update_columns?: Array<Countries_Update_Column>;
  where?: InputMaybe<Countries_Bool_Exp>;
};

/** Ordering options when selecting data from "countries". */
export type Countries_Order_By = {
  code?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  states_aggregate?: InputMaybe<States_Aggregate_Order_By>;
};

/** primary key columns input for table: countries */
export type Countries_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "countries" */
export enum Countries_Select_Column {
  /** column name */
  Code = 'code',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

/** input type for updating data in table "countries" */
export type Countries_Set_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** Streaming cursor of the table "countries" */
export type Countries_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Countries_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Countries_Stream_Cursor_Value_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** update columns of table "countries" */
export enum Countries_Update_Column {
  /** column name */
  Code = 'code',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

export type Countries_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Countries_Set_Input>;
  /** filter the rows which have to be updated */
  where: Countries_Bool_Exp;
};

/** ordering argument of a cursor */
export enum Cursor_Ordering {
  /** ascending ordering of the cursor */
  Asc = 'ASC',
  /** descending ordering of the cursor */
  Desc = 'DESC'
}

/** Boolean expression to compare columns of type "date". All fields are combined with logical 'AND'. */
export type Date_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['date']['input']>;
  _gt?: InputMaybe<Scalars['date']['input']>;
  _gte?: InputMaybe<Scalars['date']['input']>;
  _in?: InputMaybe<Array<Scalars['date']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['date']['input']>;
  _lte?: InputMaybe<Scalars['date']['input']>;
  _neq?: InputMaybe<Scalars['date']['input']>;
  _nin?: InputMaybe<Array<Scalars['date']['input']>>;
};

export type Jsonb_Cast_Exp = {
  String?: InputMaybe<String_Comparison_Exp>;
};

/** Boolean expression to compare columns of type "jsonb". All fields are combined with logical 'AND'. */
export type Jsonb_Comparison_Exp = {
  _cast?: InputMaybe<Jsonb_Cast_Exp>;
  /** is the column contained in the given json value */
  _contained_in?: InputMaybe<Scalars['jsonb']['input']>;
  /** does the column contain the given json value at the top level */
  _contains?: InputMaybe<Scalars['jsonb']['input']>;
  _eq?: InputMaybe<Scalars['jsonb']['input']>;
  _gt?: InputMaybe<Scalars['jsonb']['input']>;
  _gte?: InputMaybe<Scalars['jsonb']['input']>;
  /** does the string exist as a top-level key in the column */
  _has_key?: InputMaybe<Scalars['String']['input']>;
  /** do all of these strings exist as top-level keys in the column */
  _has_keys_all?: InputMaybe<Array<Scalars['String']['input']>>;
  /** do any of these strings exist as top-level keys in the column */
  _has_keys_any?: InputMaybe<Array<Scalars['String']['input']>>;
  _in?: InputMaybe<Array<Scalars['jsonb']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['jsonb']['input']>;
  _lte?: InputMaybe<Scalars['jsonb']['input']>;
  _neq?: InputMaybe<Scalars['jsonb']['input']>;
  _nin?: InputMaybe<Array<Scalars['jsonb']['input']>>;
};

/** columns and relationships of "makes" */
export type Makes = {
  __typename?: 'makes';
  code: Scalars['String']['output'];
  estb_year?: Maybe<Scalars['smallint']['output']>;
  id: Scalars['uuid']['output'];
  name: Scalars['String']['output'];
  /** An array relationship */
  vehicles: Array<Vehicles>;
  /** An aggregate relationship */
  vehicles_aggregate: Vehicles_Aggregate;
};


/** columns and relationships of "makes" */
export type MakesVehiclesArgs = {
  distinct_on?: InputMaybe<Array<Vehicles_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicles_Order_By>>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};


/** columns and relationships of "makes" */
export type MakesVehicles_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Vehicles_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicles_Order_By>>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};

/** aggregated selection of "makes" */
export type Makes_Aggregate = {
  __typename?: 'makes_aggregate';
  aggregate?: Maybe<Makes_Aggregate_Fields>;
  nodes: Array<Makes>;
};

/** aggregate fields of "makes" */
export type Makes_Aggregate_Fields = {
  __typename?: 'makes_aggregate_fields';
  avg?: Maybe<Makes_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Makes_Max_Fields>;
  min?: Maybe<Makes_Min_Fields>;
  stddev?: Maybe<Makes_Stddev_Fields>;
  stddev_pop?: Maybe<Makes_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Makes_Stddev_Samp_Fields>;
  sum?: Maybe<Makes_Sum_Fields>;
  var_pop?: Maybe<Makes_Var_Pop_Fields>;
  var_samp?: Maybe<Makes_Var_Samp_Fields>;
  variance?: Maybe<Makes_Variance_Fields>;
};


/** aggregate fields of "makes" */
export type Makes_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Makes_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** aggregate avg on columns */
export type Makes_Avg_Fields = {
  __typename?: 'makes_avg_fields';
  estb_year?: Maybe<Scalars['Float']['output']>;
};

/** Boolean expression to filter rows from the table "makes". All fields are combined with a logical 'AND'. */
export type Makes_Bool_Exp = {
  _and?: InputMaybe<Array<Makes_Bool_Exp>>;
  _not?: InputMaybe<Makes_Bool_Exp>;
  _or?: InputMaybe<Array<Makes_Bool_Exp>>;
  code?: InputMaybe<String_Comparison_Exp>;
  estb_year?: InputMaybe<Smallint_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
  vehicles?: InputMaybe<Vehicles_Bool_Exp>;
  vehicles_aggregate?: InputMaybe<Vehicles_Aggregate_Bool_Exp>;
};

/** unique or primary key constraints on table "makes" */
export enum Makes_Constraint {
  /** unique or primary key constraint on columns "code" */
  MakesCode_67a30dd4Uniq = 'makes_code_67a30dd4_uniq',
  /** unique or primary key constraint on columns "id" */
  MakesPkey = 'makes_pkey'
}

/** input type for incrementing numeric columns in table "makes" */
export type Makes_Inc_Input = {
  estb_year?: InputMaybe<Scalars['smallint']['input']>;
};

/** input type for inserting data into table "makes" */
export type Makes_Insert_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  estb_year?: InputMaybe<Scalars['smallint']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  vehicles?: InputMaybe<Vehicles_Arr_Rel_Insert_Input>;
};

/** aggregate max on columns */
export type Makes_Max_Fields = {
  __typename?: 'makes_max_fields';
  code?: Maybe<Scalars['String']['output']>;
  estb_year?: Maybe<Scalars['smallint']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** aggregate min on columns */
export type Makes_Min_Fields = {
  __typename?: 'makes_min_fields';
  code?: Maybe<Scalars['String']['output']>;
  estb_year?: Maybe<Scalars['smallint']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** response of any mutation on the table "makes" */
export type Makes_Mutation_Response = {
  __typename?: 'makes_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Makes>;
};

/** input type for inserting object relation for remote table "makes" */
export type Makes_Obj_Rel_Insert_Input = {
  data: Makes_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Makes_On_Conflict>;
};

/** on_conflict condition type for table "makes" */
export type Makes_On_Conflict = {
  constraint: Makes_Constraint;
  update_columns?: Array<Makes_Update_Column>;
  where?: InputMaybe<Makes_Bool_Exp>;
};

/** Ordering options when selecting data from "makes". */
export type Makes_Order_By = {
  code?: InputMaybe<Order_By>;
  estb_year?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  vehicles_aggregate?: InputMaybe<Vehicles_Aggregate_Order_By>;
};

/** primary key columns input for table: makes */
export type Makes_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "makes" */
export enum Makes_Select_Column {
  /** column name */
  Code = 'code',
  /** column name */
  EstbYear = 'estb_year',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

/** input type for updating data in table "makes" */
export type Makes_Set_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  estb_year?: InputMaybe<Scalars['smallint']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate stddev on columns */
export type Makes_Stddev_Fields = {
  __typename?: 'makes_stddev_fields';
  estb_year?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_pop on columns */
export type Makes_Stddev_Pop_Fields = {
  __typename?: 'makes_stddev_pop_fields';
  estb_year?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_samp on columns */
export type Makes_Stddev_Samp_Fields = {
  __typename?: 'makes_stddev_samp_fields';
  estb_year?: Maybe<Scalars['Float']['output']>;
};

/** Streaming cursor of the table "makes" */
export type Makes_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Makes_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Makes_Stream_Cursor_Value_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  estb_year?: InputMaybe<Scalars['smallint']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate sum on columns */
export type Makes_Sum_Fields = {
  __typename?: 'makes_sum_fields';
  estb_year?: Maybe<Scalars['smallint']['output']>;
};

/** update columns of table "makes" */
export enum Makes_Update_Column {
  /** column name */
  Code = 'code',
  /** column name */
  EstbYear = 'estb_year',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

export type Makes_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Makes_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Makes_Set_Input>;
  /** filter the rows which have to be updated */
  where: Makes_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Makes_Var_Pop_Fields = {
  __typename?: 'makes_var_pop_fields';
  estb_year?: Maybe<Scalars['Float']['output']>;
};

/** aggregate var_samp on columns */
export type Makes_Var_Samp_Fields = {
  __typename?: 'makes_var_samp_fields';
  estb_year?: Maybe<Scalars['Float']['output']>;
};

/** aggregate variance on columns */
export type Makes_Variance_Fields = {
  __typename?: 'makes_variance_fields';
  estb_year?: Maybe<Scalars['Float']['output']>;
};

/** mutation root */
export type Mutation_Root = {
  __typename?: 'mutation_root';
  authCodeExchange: AuthCodeExchangeResponse;
  changePassword: ChangePasswordResponse;
  /** delete data from the table: "attachments" */
  delete_attachments?: Maybe<Attachments_Mutation_Response>;
  /** delete single row from the table: "attachments" */
  delete_attachments_by_pk?: Maybe<Attachments>;
  /** delete data from the table: "auth_group" */
  delete_auth_group?: Maybe<Auth_Group_Mutation_Response>;
  /** delete single row from the table: "auth_group" */
  delete_auth_group_by_pk?: Maybe<Auth_Group>;
  /** delete data from the table: "auth_group_permissions" */
  delete_auth_group_permissions?: Maybe<Auth_Group_Permissions_Mutation_Response>;
  /** delete single row from the table: "auth_group_permissions" */
  delete_auth_group_permissions_by_pk?: Maybe<Auth_Group_Permissions>;
  /** delete data from the table: "auth_permission" */
  delete_auth_permission?: Maybe<Auth_Permission_Mutation_Response>;
  /** delete single row from the table: "auth_permission" */
  delete_auth_permission_by_pk?: Maybe<Auth_Permission>;
  /** delete data from the table: "cities" */
  delete_cities?: Maybe<Cities_Mutation_Response>;
  /** delete single row from the table: "cities" */
  delete_cities_by_pk?: Maybe<Cities>;
  /** delete data from the table: "contribution_price_items" */
  delete_contribution_price_items?: Maybe<Contribution_Price_Items_Mutation_Response>;
  /** delete single row from the table: "contribution_price_items" */
  delete_contribution_price_items_by_pk?: Maybe<Contribution_Price_Items>;
  /** delete data from the table: "contributions" */
  delete_contributions?: Maybe<Contributions_Mutation_Response>;
  /** delete data from the table: "contributions_attachments" */
  delete_contributions_attachments?: Maybe<Contributions_Attachments_Mutation_Response>;
  /** delete single row from the table: "contributions_attachments" */
  delete_contributions_attachments_by_pk?: Maybe<Contributions_Attachments>;
  /** delete single row from the table: "contributions" */
  delete_contributions_by_pk?: Maybe<Contributions>;
  /** delete data from the table: "countries" */
  delete_countries?: Maybe<Countries_Mutation_Response>;
  /** delete single row from the table: "countries" */
  delete_countries_by_pk?: Maybe<Countries>;
  /** delete data from the table: "makes" */
  delete_makes?: Maybe<Makes_Mutation_Response>;
  /** delete single row from the table: "makes" */
  delete_makes_by_pk?: Maybe<Makes>;
  /** delete data from the table: "price_items" */
  delete_price_items?: Maybe<Price_Items_Mutation_Response>;
  /** delete single row from the table: "price_items" */
  delete_price_items_by_pk?: Maybe<Price_Items>;
  /** delete data from the table: "states" */
  delete_states?: Maybe<States_Mutation_Response>;
  /** delete single row from the table: "states" */
  delete_states_by_pk?: Maybe<States>;
  /** delete data from the table: "user_passkeys" */
  delete_user_passkeys?: Maybe<User_Passkeys_Mutation_Response>;
  /** delete single row from the table: "user_passkeys" */
  delete_user_passkeys_by_pk?: Maybe<User_Passkeys>;
  /** delete data from the table: "user_tokens" */
  delete_user_tokens?: Maybe<User_Tokens_Mutation_Response>;
  /** delete single row from the table: "user_tokens" */
  delete_user_tokens_by_pk?: Maybe<User_Tokens>;
  /** delete data from the table: "users" */
  delete_users?: Maybe<Users_Mutation_Response>;
  /** delete single row from the table: "users" */
  delete_users_by_pk?: Maybe<Users>;
  /** delete data from the table: "users_groups" */
  delete_users_groups?: Maybe<Users_Groups_Mutation_Response>;
  /** delete single row from the table: "users_groups" */
  delete_users_groups_by_pk?: Maybe<Users_Groups>;
  /** delete data from the table: "users_user_permissions" */
  delete_users_user_permissions?: Maybe<Users_User_Permissions_Mutation_Response>;
  /** delete single row from the table: "users_user_permissions" */
  delete_users_user_permissions_by_pk?: Maybe<Users_User_Permissions>;
  /** delete data from the table: "variant_colors" */
  delete_variant_colors?: Maybe<Variant_Colors_Mutation_Response>;
  /** delete data from the table: "variant_colors_attachments" */
  delete_variant_colors_attachments?: Maybe<Variant_Colors_Attachments_Mutation_Response>;
  /** delete single row from the table: "variant_colors_attachments" */
  delete_variant_colors_attachments_by_pk?: Maybe<Variant_Colors_Attachments>;
  /** delete single row from the table: "variant_colors" */
  delete_variant_colors_by_pk?: Maybe<Variant_Colors>;
  /** delete data from the table: "variants" */
  delete_variants?: Maybe<Variants_Mutation_Response>;
  /** delete data from the table: "variants_attachments" */
  delete_variants_attachments?: Maybe<Variants_Attachments_Mutation_Response>;
  /** delete single row from the table: "variants_attachments" */
  delete_variants_attachments_by_pk?: Maybe<Variants_Attachments>;
  /** delete single row from the table: "variants" */
  delete_variants_by_pk?: Maybe<Variants>;
  /** delete data from the table: "vehicle_types" */
  delete_vehicle_types?: Maybe<Vehicle_Types_Mutation_Response>;
  /** delete single row from the table: "vehicle_types" */
  delete_vehicle_types_by_pk?: Maybe<Vehicle_Types>;
  /** delete data from the table: "vehicles" */
  delete_vehicles?: Maybe<Vehicles_Mutation_Response>;
  /** delete single row from the table: "vehicles" */
  delete_vehicles_by_pk?: Maybe<Vehicles>;
  /** delete data from the table: "votes" */
  delete_votes?: Maybe<Votes_Mutation_Response>;
  /** delete single row from the table: "votes" */
  delete_votes_by_pk?: Maybe<Votes>;
  forgotPassword: ForgotPasswordResponse;
  forgotPasswordConfirm: ForgotPasswordConfirmResponse;
  /** insert data into the table: "attachments" */
  insert_attachments?: Maybe<Attachments_Mutation_Response>;
  /** insert a single row into the table: "attachments" */
  insert_attachments_one?: Maybe<Attachments>;
  /** insert data into the table: "auth_group" */
  insert_auth_group?: Maybe<Auth_Group_Mutation_Response>;
  /** insert a single row into the table: "auth_group" */
  insert_auth_group_one?: Maybe<Auth_Group>;
  /** insert data into the table: "auth_group_permissions" */
  insert_auth_group_permissions?: Maybe<Auth_Group_Permissions_Mutation_Response>;
  /** insert a single row into the table: "auth_group_permissions" */
  insert_auth_group_permissions_one?: Maybe<Auth_Group_Permissions>;
  /** insert data into the table: "auth_permission" */
  insert_auth_permission?: Maybe<Auth_Permission_Mutation_Response>;
  /** insert a single row into the table: "auth_permission" */
  insert_auth_permission_one?: Maybe<Auth_Permission>;
  /** insert data into the table: "cities" */
  insert_cities?: Maybe<Cities_Mutation_Response>;
  /** insert a single row into the table: "cities" */
  insert_cities_one?: Maybe<Cities>;
  /** insert data into the table: "contribution_price_items" */
  insert_contribution_price_items?: Maybe<Contribution_Price_Items_Mutation_Response>;
  /** insert a single row into the table: "contribution_price_items" */
  insert_contribution_price_items_one?: Maybe<Contribution_Price_Items>;
  /** insert data into the table: "contributions" */
  insert_contributions?: Maybe<Contributions_Mutation_Response>;
  /** insert data into the table: "contributions_attachments" */
  insert_contributions_attachments?: Maybe<Contributions_Attachments_Mutation_Response>;
  /** insert a single row into the table: "contributions_attachments" */
  insert_contributions_attachments_one?: Maybe<Contributions_Attachments>;
  /** insert a single row into the table: "contributions" */
  insert_contributions_one?: Maybe<Contributions>;
  /** insert data into the table: "countries" */
  insert_countries?: Maybe<Countries_Mutation_Response>;
  /** insert a single row into the table: "countries" */
  insert_countries_one?: Maybe<Countries>;
  /** insert data into the table: "makes" */
  insert_makes?: Maybe<Makes_Mutation_Response>;
  /** insert a single row into the table: "makes" */
  insert_makes_one?: Maybe<Makes>;
  /** insert data into the table: "price_items" */
  insert_price_items?: Maybe<Price_Items_Mutation_Response>;
  /** insert a single row into the table: "price_items" */
  insert_price_items_one?: Maybe<Price_Items>;
  /** insert data into the table: "states" */
  insert_states?: Maybe<States_Mutation_Response>;
  /** insert a single row into the table: "states" */
  insert_states_one?: Maybe<States>;
  /** insert data into the table: "user_passkeys" */
  insert_user_passkeys?: Maybe<User_Passkeys_Mutation_Response>;
  /** insert a single row into the table: "user_passkeys" */
  insert_user_passkeys_one?: Maybe<User_Passkeys>;
  /** insert data into the table: "user_tokens" */
  insert_user_tokens?: Maybe<User_Tokens_Mutation_Response>;
  /** insert a single row into the table: "user_tokens" */
  insert_user_tokens_one?: Maybe<User_Tokens>;
  /** insert data into the table: "users" */
  insert_users?: Maybe<Users_Mutation_Response>;
  /** insert data into the table: "users_groups" */
  insert_users_groups?: Maybe<Users_Groups_Mutation_Response>;
  /** insert a single row into the table: "users_groups" */
  insert_users_groups_one?: Maybe<Users_Groups>;
  /** insert a single row into the table: "users" */
  insert_users_one?: Maybe<Users>;
  /** insert data into the table: "users_user_permissions" */
  insert_users_user_permissions?: Maybe<Users_User_Permissions_Mutation_Response>;
  /** insert a single row into the table: "users_user_permissions" */
  insert_users_user_permissions_one?: Maybe<Users_User_Permissions>;
  /** insert data into the table: "variant_colors" */
  insert_variant_colors?: Maybe<Variant_Colors_Mutation_Response>;
  /** insert data into the table: "variant_colors_attachments" */
  insert_variant_colors_attachments?: Maybe<Variant_Colors_Attachments_Mutation_Response>;
  /** insert a single row into the table: "variant_colors_attachments" */
  insert_variant_colors_attachments_one?: Maybe<Variant_Colors_Attachments>;
  /** insert a single row into the table: "variant_colors" */
  insert_variant_colors_one?: Maybe<Variant_Colors>;
  /** insert data into the table: "variants" */
  insert_variants?: Maybe<Variants_Mutation_Response>;
  /** insert data into the table: "variants_attachments" */
  insert_variants_attachments?: Maybe<Variants_Attachments_Mutation_Response>;
  /** insert a single row into the table: "variants_attachments" */
  insert_variants_attachments_one?: Maybe<Variants_Attachments>;
  /** insert a single row into the table: "variants" */
  insert_variants_one?: Maybe<Variants>;
  /** insert data into the table: "vehicle_types" */
  insert_vehicle_types?: Maybe<Vehicle_Types_Mutation_Response>;
  /** insert a single row into the table: "vehicle_types" */
  insert_vehicle_types_one?: Maybe<Vehicle_Types>;
  /** insert data into the table: "vehicles" */
  insert_vehicles?: Maybe<Vehicles_Mutation_Response>;
  /** insert a single row into the table: "vehicles" */
  insert_vehicles_one?: Maybe<Vehicles>;
  /** insert data into the table: "votes" */
  insert_votes?: Maybe<Votes_Mutation_Response>;
  /** insert a single row into the table: "votes" */
  insert_votes_one?: Maybe<Votes>;
  login: LoginResponse;
  loginWithMagicLink: LoginWithMagicLinkResponse;
  passkeyAuthOptions: PasskeyAuthOptionsResponse;
  passkeyAuthOptionsVerify: PasskeyAuthOptionsVerifyResponse;
  passkeyRegisterOptions: PasskeyRegisterOptions;
  passkeyRegisterVerify: PasskeyRegisterVerifyResponse;
  register: RegisterResponse;
  sendEmailOtp: SendEmailOtpResponse;
  /** update data of the table: "attachments" */
  update_attachments?: Maybe<Attachments_Mutation_Response>;
  /** update single row of the table: "attachments" */
  update_attachments_by_pk?: Maybe<Attachments>;
  /** update multiples rows of table: "attachments" */
  update_attachments_many?: Maybe<Array<Maybe<Attachments_Mutation_Response>>>;
  /** update data of the table: "auth_group" */
  update_auth_group?: Maybe<Auth_Group_Mutation_Response>;
  /** update single row of the table: "auth_group" */
  update_auth_group_by_pk?: Maybe<Auth_Group>;
  /** update multiples rows of table: "auth_group" */
  update_auth_group_many?: Maybe<Array<Maybe<Auth_Group_Mutation_Response>>>;
  /** update data of the table: "auth_group_permissions" */
  update_auth_group_permissions?: Maybe<Auth_Group_Permissions_Mutation_Response>;
  /** update single row of the table: "auth_group_permissions" */
  update_auth_group_permissions_by_pk?: Maybe<Auth_Group_Permissions>;
  /** update multiples rows of table: "auth_group_permissions" */
  update_auth_group_permissions_many?: Maybe<Array<Maybe<Auth_Group_Permissions_Mutation_Response>>>;
  /** update data of the table: "auth_permission" */
  update_auth_permission?: Maybe<Auth_Permission_Mutation_Response>;
  /** update single row of the table: "auth_permission" */
  update_auth_permission_by_pk?: Maybe<Auth_Permission>;
  /** update multiples rows of table: "auth_permission" */
  update_auth_permission_many?: Maybe<Array<Maybe<Auth_Permission_Mutation_Response>>>;
  /** update data of the table: "cities" */
  update_cities?: Maybe<Cities_Mutation_Response>;
  /** update single row of the table: "cities" */
  update_cities_by_pk?: Maybe<Cities>;
  /** update multiples rows of table: "cities" */
  update_cities_many?: Maybe<Array<Maybe<Cities_Mutation_Response>>>;
  /** update data of the table: "contribution_price_items" */
  update_contribution_price_items?: Maybe<Contribution_Price_Items_Mutation_Response>;
  /** update single row of the table: "contribution_price_items" */
  update_contribution_price_items_by_pk?: Maybe<Contribution_Price_Items>;
  /** update multiples rows of table: "contribution_price_items" */
  update_contribution_price_items_many?: Maybe<Array<Maybe<Contribution_Price_Items_Mutation_Response>>>;
  /** update data of the table: "contributions" */
  update_contributions?: Maybe<Contributions_Mutation_Response>;
  /** update data of the table: "contributions_attachments" */
  update_contributions_attachments?: Maybe<Contributions_Attachments_Mutation_Response>;
  /** update single row of the table: "contributions_attachments" */
  update_contributions_attachments_by_pk?: Maybe<Contributions_Attachments>;
  /** update multiples rows of table: "contributions_attachments" */
  update_contributions_attachments_many?: Maybe<Array<Maybe<Contributions_Attachments_Mutation_Response>>>;
  /** update single row of the table: "contributions" */
  update_contributions_by_pk?: Maybe<Contributions>;
  /** update multiples rows of table: "contributions" */
  update_contributions_many?: Maybe<Array<Maybe<Contributions_Mutation_Response>>>;
  /** update data of the table: "countries" */
  update_countries?: Maybe<Countries_Mutation_Response>;
  /** update single row of the table: "countries" */
  update_countries_by_pk?: Maybe<Countries>;
  /** update multiples rows of table: "countries" */
  update_countries_many?: Maybe<Array<Maybe<Countries_Mutation_Response>>>;
  /** update data of the table: "makes" */
  update_makes?: Maybe<Makes_Mutation_Response>;
  /** update single row of the table: "makes" */
  update_makes_by_pk?: Maybe<Makes>;
  /** update multiples rows of table: "makes" */
  update_makes_many?: Maybe<Array<Maybe<Makes_Mutation_Response>>>;
  /** update data of the table: "price_items" */
  update_price_items?: Maybe<Price_Items_Mutation_Response>;
  /** update single row of the table: "price_items" */
  update_price_items_by_pk?: Maybe<Price_Items>;
  /** update multiples rows of table: "price_items" */
  update_price_items_many?: Maybe<Array<Maybe<Price_Items_Mutation_Response>>>;
  /** update data of the table: "states" */
  update_states?: Maybe<States_Mutation_Response>;
  /** update single row of the table: "states" */
  update_states_by_pk?: Maybe<States>;
  /** update multiples rows of table: "states" */
  update_states_many?: Maybe<Array<Maybe<States_Mutation_Response>>>;
  /** update data of the table: "user_passkeys" */
  update_user_passkeys?: Maybe<User_Passkeys_Mutation_Response>;
  /** update single row of the table: "user_passkeys" */
  update_user_passkeys_by_pk?: Maybe<User_Passkeys>;
  /** update multiples rows of table: "user_passkeys" */
  update_user_passkeys_many?: Maybe<Array<Maybe<User_Passkeys_Mutation_Response>>>;
  /** update data of the table: "user_tokens" */
  update_user_tokens?: Maybe<User_Tokens_Mutation_Response>;
  /** update single row of the table: "user_tokens" */
  update_user_tokens_by_pk?: Maybe<User_Tokens>;
  /** update multiples rows of table: "user_tokens" */
  update_user_tokens_many?: Maybe<Array<Maybe<User_Tokens_Mutation_Response>>>;
  /** update data of the table: "users" */
  update_users?: Maybe<Users_Mutation_Response>;
  /** update single row of the table: "users" */
  update_users_by_pk?: Maybe<Users>;
  /** update data of the table: "users_groups" */
  update_users_groups?: Maybe<Users_Groups_Mutation_Response>;
  /** update single row of the table: "users_groups" */
  update_users_groups_by_pk?: Maybe<Users_Groups>;
  /** update multiples rows of table: "users_groups" */
  update_users_groups_many?: Maybe<Array<Maybe<Users_Groups_Mutation_Response>>>;
  /** update multiples rows of table: "users" */
  update_users_many?: Maybe<Array<Maybe<Users_Mutation_Response>>>;
  /** update data of the table: "users_user_permissions" */
  update_users_user_permissions?: Maybe<Users_User_Permissions_Mutation_Response>;
  /** update single row of the table: "users_user_permissions" */
  update_users_user_permissions_by_pk?: Maybe<Users_User_Permissions>;
  /** update multiples rows of table: "users_user_permissions" */
  update_users_user_permissions_many?: Maybe<Array<Maybe<Users_User_Permissions_Mutation_Response>>>;
  /** update data of the table: "variant_colors" */
  update_variant_colors?: Maybe<Variant_Colors_Mutation_Response>;
  /** update data of the table: "variant_colors_attachments" */
  update_variant_colors_attachments?: Maybe<Variant_Colors_Attachments_Mutation_Response>;
  /** update single row of the table: "variant_colors_attachments" */
  update_variant_colors_attachments_by_pk?: Maybe<Variant_Colors_Attachments>;
  /** update multiples rows of table: "variant_colors_attachments" */
  update_variant_colors_attachments_many?: Maybe<Array<Maybe<Variant_Colors_Attachments_Mutation_Response>>>;
  /** update single row of the table: "variant_colors" */
  update_variant_colors_by_pk?: Maybe<Variant_Colors>;
  /** update multiples rows of table: "variant_colors" */
  update_variant_colors_many?: Maybe<Array<Maybe<Variant_Colors_Mutation_Response>>>;
  /** update data of the table: "variants" */
  update_variants?: Maybe<Variants_Mutation_Response>;
  /** update data of the table: "variants_attachments" */
  update_variants_attachments?: Maybe<Variants_Attachments_Mutation_Response>;
  /** update single row of the table: "variants_attachments" */
  update_variants_attachments_by_pk?: Maybe<Variants_Attachments>;
  /** update multiples rows of table: "variants_attachments" */
  update_variants_attachments_many?: Maybe<Array<Maybe<Variants_Attachments_Mutation_Response>>>;
  /** update single row of the table: "variants" */
  update_variants_by_pk?: Maybe<Variants>;
  /** update multiples rows of table: "variants" */
  update_variants_many?: Maybe<Array<Maybe<Variants_Mutation_Response>>>;
  /** update data of the table: "vehicle_types" */
  update_vehicle_types?: Maybe<Vehicle_Types_Mutation_Response>;
  /** update single row of the table: "vehicle_types" */
  update_vehicle_types_by_pk?: Maybe<Vehicle_Types>;
  /** update multiples rows of table: "vehicle_types" */
  update_vehicle_types_many?: Maybe<Array<Maybe<Vehicle_Types_Mutation_Response>>>;
  /** update data of the table: "vehicles" */
  update_vehicles?: Maybe<Vehicles_Mutation_Response>;
  /** update single row of the table: "vehicles" */
  update_vehicles_by_pk?: Maybe<Vehicles>;
  /** update multiples rows of table: "vehicles" */
  update_vehicles_many?: Maybe<Array<Maybe<Vehicles_Mutation_Response>>>;
  /** update data of the table: "votes" */
  update_votes?: Maybe<Votes_Mutation_Response>;
  /** update single row of the table: "votes" */
  update_votes_by_pk?: Maybe<Votes>;
  /** update multiples rows of table: "votes" */
  update_votes_many?: Maybe<Array<Maybe<Votes_Mutation_Response>>>;
  verifyOtp: VerifyOtpResponse;
};


/** mutation root */
export type Mutation_RootAuthCodeExchangeArgs = {
  code: Scalars['String']['input'];
  type?: Scalars['String']['input'];
};


/** mutation root */
export type Mutation_RootChangePasswordArgs = {
  confirmPassword: Scalars['String']['input'];
  password: Scalars['String']['input'];
};


/** mutation root */
export type Mutation_RootDelete_AttachmentsArgs = {
  where: Attachments_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Attachments_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Auth_GroupArgs = {
  where: Auth_Group_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Auth_Group_By_PkArgs = {
  id: Scalars['Int']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Auth_Group_PermissionsArgs = {
  where: Auth_Group_Permissions_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Auth_Group_Permissions_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Auth_PermissionArgs = {
  where: Auth_Permission_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Auth_Permission_By_PkArgs = {
  id: Scalars['Int']['input'];
};


/** mutation root */
export type Mutation_RootDelete_CitiesArgs = {
  where: Cities_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Cities_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Contribution_Price_ItemsArgs = {
  where: Contribution_Price_Items_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Contribution_Price_Items_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_ContributionsArgs = {
  where: Contributions_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Contributions_AttachmentsArgs = {
  where: Contributions_Attachments_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Contributions_Attachments_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Contributions_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_CountriesArgs = {
  where: Countries_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Countries_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_MakesArgs = {
  where: Makes_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Makes_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Price_ItemsArgs = {
  where: Price_Items_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Price_Items_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_StatesArgs = {
  where: States_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_States_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_User_PasskeysArgs = {
  where: User_Passkeys_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_User_Passkeys_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_User_TokensArgs = {
  where: User_Tokens_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_User_Tokens_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_UsersArgs = {
  where: Users_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Users_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Users_GroupsArgs = {
  where: Users_Groups_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Users_Groups_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Users_User_PermissionsArgs = {
  where: Users_User_Permissions_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Users_User_Permissions_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Variant_ColorsArgs = {
  where: Variant_Colors_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Variant_Colors_AttachmentsArgs = {
  where: Variant_Colors_Attachments_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Variant_Colors_Attachments_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Variant_Colors_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_VariantsArgs = {
  where: Variants_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Variants_AttachmentsArgs = {
  where: Variants_Attachments_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Variants_Attachments_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Variants_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_Vehicle_TypesArgs = {
  where: Vehicle_Types_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Vehicle_Types_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_VehiclesArgs = {
  where: Vehicles_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Vehicles_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootDelete_VotesArgs = {
  where: Votes_Bool_Exp;
};


/** mutation root */
export type Mutation_RootDelete_Votes_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


/** mutation root */
export type Mutation_RootForgotPasswordArgs = {
  identity: Scalars['String']['input'];
};


/** mutation root */
export type Mutation_RootForgotPasswordConfirmArgs = {
  input: ForgotPasswordConfirmInput;
};


/** mutation root */
export type Mutation_RootInsert_AttachmentsArgs = {
  objects: Array<Attachments_Insert_Input>;
  on_conflict?: InputMaybe<Attachments_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Attachments_OneArgs = {
  object: Attachments_Insert_Input;
  on_conflict?: InputMaybe<Attachments_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Auth_GroupArgs = {
  objects: Array<Auth_Group_Insert_Input>;
  on_conflict?: InputMaybe<Auth_Group_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Auth_Group_OneArgs = {
  object: Auth_Group_Insert_Input;
  on_conflict?: InputMaybe<Auth_Group_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Auth_Group_PermissionsArgs = {
  objects: Array<Auth_Group_Permissions_Insert_Input>;
  on_conflict?: InputMaybe<Auth_Group_Permissions_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Auth_Group_Permissions_OneArgs = {
  object: Auth_Group_Permissions_Insert_Input;
  on_conflict?: InputMaybe<Auth_Group_Permissions_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Auth_PermissionArgs = {
  objects: Array<Auth_Permission_Insert_Input>;
  on_conflict?: InputMaybe<Auth_Permission_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Auth_Permission_OneArgs = {
  object: Auth_Permission_Insert_Input;
  on_conflict?: InputMaybe<Auth_Permission_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_CitiesArgs = {
  objects: Array<Cities_Insert_Input>;
  on_conflict?: InputMaybe<Cities_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Cities_OneArgs = {
  object: Cities_Insert_Input;
  on_conflict?: InputMaybe<Cities_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Contribution_Price_ItemsArgs = {
  objects: Array<Contribution_Price_Items_Insert_Input>;
  on_conflict?: InputMaybe<Contribution_Price_Items_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Contribution_Price_Items_OneArgs = {
  object: Contribution_Price_Items_Insert_Input;
  on_conflict?: InputMaybe<Contribution_Price_Items_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_ContributionsArgs = {
  objects: Array<Contributions_Insert_Input>;
  on_conflict?: InputMaybe<Contributions_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Contributions_AttachmentsArgs = {
  objects: Array<Contributions_Attachments_Insert_Input>;
  on_conflict?: InputMaybe<Contributions_Attachments_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Contributions_Attachments_OneArgs = {
  object: Contributions_Attachments_Insert_Input;
  on_conflict?: InputMaybe<Contributions_Attachments_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Contributions_OneArgs = {
  object: Contributions_Insert_Input;
  on_conflict?: InputMaybe<Contributions_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_CountriesArgs = {
  objects: Array<Countries_Insert_Input>;
  on_conflict?: InputMaybe<Countries_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Countries_OneArgs = {
  object: Countries_Insert_Input;
  on_conflict?: InputMaybe<Countries_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_MakesArgs = {
  objects: Array<Makes_Insert_Input>;
  on_conflict?: InputMaybe<Makes_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Makes_OneArgs = {
  object: Makes_Insert_Input;
  on_conflict?: InputMaybe<Makes_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Price_ItemsArgs = {
  objects: Array<Price_Items_Insert_Input>;
  on_conflict?: InputMaybe<Price_Items_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Price_Items_OneArgs = {
  object: Price_Items_Insert_Input;
  on_conflict?: InputMaybe<Price_Items_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_StatesArgs = {
  objects: Array<States_Insert_Input>;
  on_conflict?: InputMaybe<States_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_States_OneArgs = {
  object: States_Insert_Input;
  on_conflict?: InputMaybe<States_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_User_PasskeysArgs = {
  objects: Array<User_Passkeys_Insert_Input>;
  on_conflict?: InputMaybe<User_Passkeys_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_User_Passkeys_OneArgs = {
  object: User_Passkeys_Insert_Input;
  on_conflict?: InputMaybe<User_Passkeys_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_User_TokensArgs = {
  objects: Array<User_Tokens_Insert_Input>;
  on_conflict?: InputMaybe<User_Tokens_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_User_Tokens_OneArgs = {
  object: User_Tokens_Insert_Input;
  on_conflict?: InputMaybe<User_Tokens_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_UsersArgs = {
  objects: Array<Users_Insert_Input>;
  on_conflict?: InputMaybe<Users_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Users_GroupsArgs = {
  objects: Array<Users_Groups_Insert_Input>;
  on_conflict?: InputMaybe<Users_Groups_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Users_Groups_OneArgs = {
  object: Users_Groups_Insert_Input;
  on_conflict?: InputMaybe<Users_Groups_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Users_OneArgs = {
  object: Users_Insert_Input;
  on_conflict?: InputMaybe<Users_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Users_User_PermissionsArgs = {
  objects: Array<Users_User_Permissions_Insert_Input>;
  on_conflict?: InputMaybe<Users_User_Permissions_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Users_User_Permissions_OneArgs = {
  object: Users_User_Permissions_Insert_Input;
  on_conflict?: InputMaybe<Users_User_Permissions_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Variant_ColorsArgs = {
  objects: Array<Variant_Colors_Insert_Input>;
  on_conflict?: InputMaybe<Variant_Colors_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Variant_Colors_AttachmentsArgs = {
  objects: Array<Variant_Colors_Attachments_Insert_Input>;
  on_conflict?: InputMaybe<Variant_Colors_Attachments_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Variant_Colors_Attachments_OneArgs = {
  object: Variant_Colors_Attachments_Insert_Input;
  on_conflict?: InputMaybe<Variant_Colors_Attachments_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Variant_Colors_OneArgs = {
  object: Variant_Colors_Insert_Input;
  on_conflict?: InputMaybe<Variant_Colors_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_VariantsArgs = {
  objects: Array<Variants_Insert_Input>;
  on_conflict?: InputMaybe<Variants_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Variants_AttachmentsArgs = {
  objects: Array<Variants_Attachments_Insert_Input>;
  on_conflict?: InputMaybe<Variants_Attachments_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Variants_Attachments_OneArgs = {
  object: Variants_Attachments_Insert_Input;
  on_conflict?: InputMaybe<Variants_Attachments_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Variants_OneArgs = {
  object: Variants_Insert_Input;
  on_conflict?: InputMaybe<Variants_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Vehicle_TypesArgs = {
  objects: Array<Vehicle_Types_Insert_Input>;
  on_conflict?: InputMaybe<Vehicle_Types_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Vehicle_Types_OneArgs = {
  object: Vehicle_Types_Insert_Input;
  on_conflict?: InputMaybe<Vehicle_Types_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_VehiclesArgs = {
  objects: Array<Vehicles_Insert_Input>;
  on_conflict?: InputMaybe<Vehicles_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Vehicles_OneArgs = {
  object: Vehicles_Insert_Input;
  on_conflict?: InputMaybe<Vehicles_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_VotesArgs = {
  objects: Array<Votes_Insert_Input>;
  on_conflict?: InputMaybe<Votes_On_Conflict>;
};


/** mutation root */
export type Mutation_RootInsert_Votes_OneArgs = {
  object: Votes_Insert_Input;
  on_conflict?: InputMaybe<Votes_On_Conflict>;
};


/** mutation root */
export type Mutation_RootLoginArgs = {
  email: Scalars['String']['input'];
  password: Scalars['String']['input'];
};


/** mutation root */
export type Mutation_RootLoginWithMagicLinkArgs = {
  email: Scalars['String']['input'];
};


/** mutation root */
export type Mutation_RootPasskeyAuthOptionsVerifyArgs = {
  credential: Scalars['String']['input'];
  credentialId: Scalars['String']['input'];
};


/** mutation root */
export type Mutation_RootPasskeyRegisterOptionsArgs = {
  name: Scalars['String']['input'];
};


/** mutation root */
export type Mutation_RootPasskeyRegisterVerifyArgs = {
  credential: Scalars['String']['input'];
};


/** mutation root */
export type Mutation_RootRegisterArgs = {
  input: RegisterInput;
};


/** mutation root */
export type Mutation_RootSendEmailOtpArgs = {
  email: Scalars['String']['input'];
};


/** mutation root */
export type Mutation_RootUpdate_AttachmentsArgs = {
  _inc?: InputMaybe<Attachments_Inc_Input>;
  _set?: InputMaybe<Attachments_Set_Input>;
  where: Attachments_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Attachments_By_PkArgs = {
  _inc?: InputMaybe<Attachments_Inc_Input>;
  _set?: InputMaybe<Attachments_Set_Input>;
  pk_columns: Attachments_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Attachments_ManyArgs = {
  updates: Array<Attachments_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Auth_GroupArgs = {
  _inc?: InputMaybe<Auth_Group_Inc_Input>;
  _set?: InputMaybe<Auth_Group_Set_Input>;
  where: Auth_Group_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Auth_Group_By_PkArgs = {
  _inc?: InputMaybe<Auth_Group_Inc_Input>;
  _set?: InputMaybe<Auth_Group_Set_Input>;
  pk_columns: Auth_Group_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Auth_Group_ManyArgs = {
  updates: Array<Auth_Group_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Auth_Group_PermissionsArgs = {
  _inc?: InputMaybe<Auth_Group_Permissions_Inc_Input>;
  _set?: InputMaybe<Auth_Group_Permissions_Set_Input>;
  where: Auth_Group_Permissions_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Auth_Group_Permissions_By_PkArgs = {
  _inc?: InputMaybe<Auth_Group_Permissions_Inc_Input>;
  _set?: InputMaybe<Auth_Group_Permissions_Set_Input>;
  pk_columns: Auth_Group_Permissions_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Auth_Group_Permissions_ManyArgs = {
  updates: Array<Auth_Group_Permissions_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Auth_PermissionArgs = {
  _inc?: InputMaybe<Auth_Permission_Inc_Input>;
  _set?: InputMaybe<Auth_Permission_Set_Input>;
  where: Auth_Permission_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Auth_Permission_By_PkArgs = {
  _inc?: InputMaybe<Auth_Permission_Inc_Input>;
  _set?: InputMaybe<Auth_Permission_Set_Input>;
  pk_columns: Auth_Permission_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Auth_Permission_ManyArgs = {
  updates: Array<Auth_Permission_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_CitiesArgs = {
  _set?: InputMaybe<Cities_Set_Input>;
  where: Cities_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Cities_By_PkArgs = {
  _set?: InputMaybe<Cities_Set_Input>;
  pk_columns: Cities_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Cities_ManyArgs = {
  updates: Array<Cities_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Contribution_Price_ItemsArgs = {
  _inc?: InputMaybe<Contribution_Price_Items_Inc_Input>;
  _set?: InputMaybe<Contribution_Price_Items_Set_Input>;
  where: Contribution_Price_Items_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Contribution_Price_Items_By_PkArgs = {
  _inc?: InputMaybe<Contribution_Price_Items_Inc_Input>;
  _set?: InputMaybe<Contribution_Price_Items_Set_Input>;
  pk_columns: Contribution_Price_Items_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Contribution_Price_Items_ManyArgs = {
  updates: Array<Contribution_Price_Items_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_ContributionsArgs = {
  _inc?: InputMaybe<Contributions_Inc_Input>;
  _set?: InputMaybe<Contributions_Set_Input>;
  where: Contributions_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Contributions_AttachmentsArgs = {
  _inc?: InputMaybe<Contributions_Attachments_Inc_Input>;
  _set?: InputMaybe<Contributions_Attachments_Set_Input>;
  where: Contributions_Attachments_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Contributions_Attachments_By_PkArgs = {
  _inc?: InputMaybe<Contributions_Attachments_Inc_Input>;
  _set?: InputMaybe<Contributions_Attachments_Set_Input>;
  pk_columns: Contributions_Attachments_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Contributions_Attachments_ManyArgs = {
  updates: Array<Contributions_Attachments_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Contributions_By_PkArgs = {
  _inc?: InputMaybe<Contributions_Inc_Input>;
  _set?: InputMaybe<Contributions_Set_Input>;
  pk_columns: Contributions_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Contributions_ManyArgs = {
  updates: Array<Contributions_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_CountriesArgs = {
  _set?: InputMaybe<Countries_Set_Input>;
  where: Countries_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Countries_By_PkArgs = {
  _set?: InputMaybe<Countries_Set_Input>;
  pk_columns: Countries_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Countries_ManyArgs = {
  updates: Array<Countries_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_MakesArgs = {
  _inc?: InputMaybe<Makes_Inc_Input>;
  _set?: InputMaybe<Makes_Set_Input>;
  where: Makes_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Makes_By_PkArgs = {
  _inc?: InputMaybe<Makes_Inc_Input>;
  _set?: InputMaybe<Makes_Set_Input>;
  pk_columns: Makes_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Makes_ManyArgs = {
  updates: Array<Makes_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Price_ItemsArgs = {
  _inc?: InputMaybe<Price_Items_Inc_Input>;
  _set?: InputMaybe<Price_Items_Set_Input>;
  where: Price_Items_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Price_Items_By_PkArgs = {
  _inc?: InputMaybe<Price_Items_Inc_Input>;
  _set?: InputMaybe<Price_Items_Set_Input>;
  pk_columns: Price_Items_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Price_Items_ManyArgs = {
  updates: Array<Price_Items_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_StatesArgs = {
  _set?: InputMaybe<States_Set_Input>;
  where: States_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_States_By_PkArgs = {
  _set?: InputMaybe<States_Set_Input>;
  pk_columns: States_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_States_ManyArgs = {
  updates: Array<States_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_User_PasskeysArgs = {
  _set?: InputMaybe<User_Passkeys_Set_Input>;
  where: User_Passkeys_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_User_Passkeys_By_PkArgs = {
  _set?: InputMaybe<User_Passkeys_Set_Input>;
  pk_columns: User_Passkeys_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_User_Passkeys_ManyArgs = {
  updates: Array<User_Passkeys_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_User_TokensArgs = {
  _set?: InputMaybe<User_Tokens_Set_Input>;
  where: User_Tokens_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_User_Tokens_By_PkArgs = {
  _set?: InputMaybe<User_Tokens_Set_Input>;
  pk_columns: User_Tokens_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_User_Tokens_ManyArgs = {
  updates: Array<User_Tokens_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_UsersArgs = {
  _set?: InputMaybe<Users_Set_Input>;
  where: Users_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Users_By_PkArgs = {
  _set?: InputMaybe<Users_Set_Input>;
  pk_columns: Users_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Users_GroupsArgs = {
  _inc?: InputMaybe<Users_Groups_Inc_Input>;
  _set?: InputMaybe<Users_Groups_Set_Input>;
  where: Users_Groups_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Users_Groups_By_PkArgs = {
  _inc?: InputMaybe<Users_Groups_Inc_Input>;
  _set?: InputMaybe<Users_Groups_Set_Input>;
  pk_columns: Users_Groups_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Users_Groups_ManyArgs = {
  updates: Array<Users_Groups_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Users_ManyArgs = {
  updates: Array<Users_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Users_User_PermissionsArgs = {
  _inc?: InputMaybe<Users_User_Permissions_Inc_Input>;
  _set?: InputMaybe<Users_User_Permissions_Set_Input>;
  where: Users_User_Permissions_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Users_User_Permissions_By_PkArgs = {
  _inc?: InputMaybe<Users_User_Permissions_Inc_Input>;
  _set?: InputMaybe<Users_User_Permissions_Set_Input>;
  pk_columns: Users_User_Permissions_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Users_User_Permissions_ManyArgs = {
  updates: Array<Users_User_Permissions_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Variant_ColorsArgs = {
  _set?: InputMaybe<Variant_Colors_Set_Input>;
  where: Variant_Colors_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Variant_Colors_AttachmentsArgs = {
  _inc?: InputMaybe<Variant_Colors_Attachments_Inc_Input>;
  _set?: InputMaybe<Variant_Colors_Attachments_Set_Input>;
  where: Variant_Colors_Attachments_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Variant_Colors_Attachments_By_PkArgs = {
  _inc?: InputMaybe<Variant_Colors_Attachments_Inc_Input>;
  _set?: InputMaybe<Variant_Colors_Attachments_Set_Input>;
  pk_columns: Variant_Colors_Attachments_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Variant_Colors_Attachments_ManyArgs = {
  updates: Array<Variant_Colors_Attachments_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Variant_Colors_By_PkArgs = {
  _set?: InputMaybe<Variant_Colors_Set_Input>;
  pk_columns: Variant_Colors_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Variant_Colors_ManyArgs = {
  updates: Array<Variant_Colors_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_VariantsArgs = {
  _append?: InputMaybe<Variants_Append_Input>;
  _delete_at_path?: InputMaybe<Variants_Delete_At_Path_Input>;
  _delete_elem?: InputMaybe<Variants_Delete_Elem_Input>;
  _delete_key?: InputMaybe<Variants_Delete_Key_Input>;
  _prepend?: InputMaybe<Variants_Prepend_Input>;
  _set?: InputMaybe<Variants_Set_Input>;
  where: Variants_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Variants_AttachmentsArgs = {
  _inc?: InputMaybe<Variants_Attachments_Inc_Input>;
  _set?: InputMaybe<Variants_Attachments_Set_Input>;
  where: Variants_Attachments_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Variants_Attachments_By_PkArgs = {
  _inc?: InputMaybe<Variants_Attachments_Inc_Input>;
  _set?: InputMaybe<Variants_Attachments_Set_Input>;
  pk_columns: Variants_Attachments_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Variants_Attachments_ManyArgs = {
  updates: Array<Variants_Attachments_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Variants_By_PkArgs = {
  _append?: InputMaybe<Variants_Append_Input>;
  _delete_at_path?: InputMaybe<Variants_Delete_At_Path_Input>;
  _delete_elem?: InputMaybe<Variants_Delete_Elem_Input>;
  _delete_key?: InputMaybe<Variants_Delete_Key_Input>;
  _prepend?: InputMaybe<Variants_Prepend_Input>;
  _set?: InputMaybe<Variants_Set_Input>;
  pk_columns: Variants_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Variants_ManyArgs = {
  updates: Array<Variants_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_Vehicle_TypesArgs = {
  _set?: InputMaybe<Vehicle_Types_Set_Input>;
  where: Vehicle_Types_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Vehicle_Types_By_PkArgs = {
  _set?: InputMaybe<Vehicle_Types_Set_Input>;
  pk_columns: Vehicle_Types_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Vehicle_Types_ManyArgs = {
  updates: Array<Vehicle_Types_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_VehiclesArgs = {
  _set?: InputMaybe<Vehicles_Set_Input>;
  where: Vehicles_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Vehicles_By_PkArgs = {
  _set?: InputMaybe<Vehicles_Set_Input>;
  pk_columns: Vehicles_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Vehicles_ManyArgs = {
  updates: Array<Vehicles_Updates>;
};


/** mutation root */
export type Mutation_RootUpdate_VotesArgs = {
  _set?: InputMaybe<Votes_Set_Input>;
  where: Votes_Bool_Exp;
};


/** mutation root */
export type Mutation_RootUpdate_Votes_By_PkArgs = {
  _set?: InputMaybe<Votes_Set_Input>;
  pk_columns: Votes_Pk_Columns_Input;
};


/** mutation root */
export type Mutation_RootUpdate_Votes_ManyArgs = {
  updates: Array<Votes_Updates>;
};


/** mutation root */
export type Mutation_RootVerifyOtpArgs = {
  input: OtpInput;
};

/** Boolean expression to compare columns of type "numeric". All fields are combined with logical 'AND'. */
export type Numeric_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['numeric']['input']>;
  _gt?: InputMaybe<Scalars['numeric']['input']>;
  _gte?: InputMaybe<Scalars['numeric']['input']>;
  _in?: InputMaybe<Array<Scalars['numeric']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['numeric']['input']>;
  _lte?: InputMaybe<Scalars['numeric']['input']>;
  _neq?: InputMaybe<Scalars['numeric']['input']>;
  _nin?: InputMaybe<Array<Scalars['numeric']['input']>>;
};

/** column ordering options */
export enum Order_By {
  /** in ascending order, nulls last */
  Asc = 'asc',
  /** in ascending order, nulls first */
  AscNullsFirst = 'asc_nulls_first',
  /** in ascending order, nulls last */
  AscNullsLast = 'asc_nulls_last',
  /** in descending order, nulls first */
  Desc = 'desc',
  /** in descending order, nulls first */
  DescNullsFirst = 'desc_nulls_first',
  /** in descending order, nulls last */
  DescNullsLast = 'desc_nulls_last'
}

/** columns and relationships of "price_items" */
export type Price_Items = {
  __typename?: 'price_items';
  category: Scalars['String']['output'];
  created_at: Scalars['timestamptz']['output'];
  description?: Maybe<Scalars['String']['output']>;
  id: Scalars['uuid']['output'];
  name: Scalars['String']['output'];
  serial_no: Scalars['smallint']['output'];
  type: Scalars['String']['output'];
  updated_at: Scalars['timestamptz']['output'];
};

/** aggregated selection of "price_items" */
export type Price_Items_Aggregate = {
  __typename?: 'price_items_aggregate';
  aggregate?: Maybe<Price_Items_Aggregate_Fields>;
  nodes: Array<Price_Items>;
};

/** aggregate fields of "price_items" */
export type Price_Items_Aggregate_Fields = {
  __typename?: 'price_items_aggregate_fields';
  avg?: Maybe<Price_Items_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Price_Items_Max_Fields>;
  min?: Maybe<Price_Items_Min_Fields>;
  stddev?: Maybe<Price_Items_Stddev_Fields>;
  stddev_pop?: Maybe<Price_Items_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Price_Items_Stddev_Samp_Fields>;
  sum?: Maybe<Price_Items_Sum_Fields>;
  var_pop?: Maybe<Price_Items_Var_Pop_Fields>;
  var_samp?: Maybe<Price_Items_Var_Samp_Fields>;
  variance?: Maybe<Price_Items_Variance_Fields>;
};


/** aggregate fields of "price_items" */
export type Price_Items_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Price_Items_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** aggregate avg on columns */
export type Price_Items_Avg_Fields = {
  __typename?: 'price_items_avg_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
};

/** Boolean expression to filter rows from the table "price_items". All fields are combined with a logical 'AND'. */
export type Price_Items_Bool_Exp = {
  _and?: InputMaybe<Array<Price_Items_Bool_Exp>>;
  _not?: InputMaybe<Price_Items_Bool_Exp>;
  _or?: InputMaybe<Array<Price_Items_Bool_Exp>>;
  category?: InputMaybe<String_Comparison_Exp>;
  created_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  description?: InputMaybe<String_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
  serial_no?: InputMaybe<Smallint_Comparison_Exp>;
  type?: InputMaybe<String_Comparison_Exp>;
  updated_at?: InputMaybe<Timestamptz_Comparison_Exp>;
};

/** unique or primary key constraints on table "price_items" */
export enum Price_Items_Constraint {
  /** unique or primary key constraint on columns "id" */
  PriceItemsPkey = 'price_items_pkey'
}

/** input type for incrementing numeric columns in table "price_items" */
export type Price_Items_Inc_Input = {
  serial_no?: InputMaybe<Scalars['smallint']['input']>;
};

/** input type for inserting data into table "price_items" */
export type Price_Items_Insert_Input = {
  category?: InputMaybe<Scalars['String']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  serial_no?: InputMaybe<Scalars['smallint']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
};

/** aggregate max on columns */
export type Price_Items_Max_Fields = {
  __typename?: 'price_items_max_fields';
  category?: Maybe<Scalars['String']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  description?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  serial_no?: Maybe<Scalars['smallint']['output']>;
  type?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
};

/** aggregate min on columns */
export type Price_Items_Min_Fields = {
  __typename?: 'price_items_min_fields';
  category?: Maybe<Scalars['String']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  description?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  serial_no?: Maybe<Scalars['smallint']['output']>;
  type?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
};

/** response of any mutation on the table "price_items" */
export type Price_Items_Mutation_Response = {
  __typename?: 'price_items_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Price_Items>;
};

/** input type for inserting object relation for remote table "price_items" */
export type Price_Items_Obj_Rel_Insert_Input = {
  data: Price_Items_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Price_Items_On_Conflict>;
};

/** on_conflict condition type for table "price_items" */
export type Price_Items_On_Conflict = {
  constraint: Price_Items_Constraint;
  update_columns?: Array<Price_Items_Update_Column>;
  where?: InputMaybe<Price_Items_Bool_Exp>;
};

/** Ordering options when selecting data from "price_items". */
export type Price_Items_Order_By = {
  category?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  description?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  serial_no?: InputMaybe<Order_By>;
  type?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
};

/** primary key columns input for table: price_items */
export type Price_Items_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "price_items" */
export enum Price_Items_Select_Column {
  /** column name */
  Category = 'category',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  Description = 'description',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name',
  /** column name */
  SerialNo = 'serial_no',
  /** column name */
  Type = 'type',
  /** column name */
  UpdatedAt = 'updated_at'
}

/** input type for updating data in table "price_items" */
export type Price_Items_Set_Input = {
  category?: InputMaybe<Scalars['String']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  serial_no?: InputMaybe<Scalars['smallint']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
};

/** aggregate stddev on columns */
export type Price_Items_Stddev_Fields = {
  __typename?: 'price_items_stddev_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_pop on columns */
export type Price_Items_Stddev_Pop_Fields = {
  __typename?: 'price_items_stddev_pop_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
};

/** aggregate stddev_samp on columns */
export type Price_Items_Stddev_Samp_Fields = {
  __typename?: 'price_items_stddev_samp_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
};

/** Streaming cursor of the table "price_items" */
export type Price_Items_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Price_Items_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Price_Items_Stream_Cursor_Value_Input = {
  category?: InputMaybe<Scalars['String']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  serial_no?: InputMaybe<Scalars['smallint']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
};

/** aggregate sum on columns */
export type Price_Items_Sum_Fields = {
  __typename?: 'price_items_sum_fields';
  serial_no?: Maybe<Scalars['smallint']['output']>;
};

/** update columns of table "price_items" */
export enum Price_Items_Update_Column {
  /** column name */
  Category = 'category',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  Description = 'description',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name',
  /** column name */
  SerialNo = 'serial_no',
  /** column name */
  Type = 'type',
  /** column name */
  UpdatedAt = 'updated_at'
}

export type Price_Items_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Price_Items_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Price_Items_Set_Input>;
  /** filter the rows which have to be updated */
  where: Price_Items_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Price_Items_Var_Pop_Fields = {
  __typename?: 'price_items_var_pop_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
};

/** aggregate var_samp on columns */
export type Price_Items_Var_Samp_Fields = {
  __typename?: 'price_items_var_samp_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
};

/** aggregate variance on columns */
export type Price_Items_Variance_Fields = {
  __typename?: 'price_items_variance_fields';
  serial_no?: Maybe<Scalars['Float']['output']>;
};

export type Query_Root = {
  __typename?: 'query_root';
  /** fetch data from the table: "attachments" */
  attachments: Array<Attachments>;
  /** fetch aggregated fields from the table: "attachments" */
  attachments_aggregate: Attachments_Aggregate;
  /** fetch data from the table: "attachments" using primary key columns */
  attachments_by_pk?: Maybe<Attachments>;
  /** fetch data from the table: "auth_group" */
  auth_group: Array<Auth_Group>;
  /** fetch aggregated fields from the table: "auth_group" */
  auth_group_aggregate: Auth_Group_Aggregate;
  /** fetch data from the table: "auth_group" using primary key columns */
  auth_group_by_pk?: Maybe<Auth_Group>;
  /** fetch data from the table: "auth_group_permissions" */
  auth_group_permissions: Array<Auth_Group_Permissions>;
  /** fetch aggregated fields from the table: "auth_group_permissions" */
  auth_group_permissions_aggregate: Auth_Group_Permissions_Aggregate;
  /** fetch data from the table: "auth_group_permissions" using primary key columns */
  auth_group_permissions_by_pk?: Maybe<Auth_Group_Permissions>;
  /** fetch data from the table: "auth_permission" */
  auth_permission: Array<Auth_Permission>;
  /** fetch aggregated fields from the table: "auth_permission" */
  auth_permission_aggregate: Auth_Permission_Aggregate;
  /** fetch data from the table: "auth_permission" using primary key columns */
  auth_permission_by_pk?: Maybe<Auth_Permission>;
  /** An array relationship */
  cities: Array<Cities>;
  /** An aggregate relationship */
  cities_aggregate: Cities_Aggregate;
  /** fetch data from the table: "cities" using primary key columns */
  cities_by_pk?: Maybe<Cities>;
  /** fetch data from the table: "contribution_price_items" */
  contribution_price_items: Array<Contribution_Price_Items>;
  /** fetch aggregated fields from the table: "contribution_price_items" */
  contribution_price_items_aggregate: Contribution_Price_Items_Aggregate;
  /** fetch data from the table: "contribution_price_items" using primary key columns */
  contribution_price_items_by_pk?: Maybe<Contribution_Price_Items>;
  /** An array relationship */
  contributions: Array<Contributions>;
  /** An aggregate relationship */
  contributions_aggregate: Contributions_Aggregate;
  /** fetch data from the table: "contributions_attachments" */
  contributions_attachments: Array<Contributions_Attachments>;
  /** fetch aggregated fields from the table: "contributions_attachments" */
  contributions_attachments_aggregate: Contributions_Attachments_Aggregate;
  /** fetch data from the table: "contributions_attachments" using primary key columns */
  contributions_attachments_by_pk?: Maybe<Contributions_Attachments>;
  /** fetch data from the table: "contributions" using primary key columns */
  contributions_by_pk?: Maybe<Contributions>;
  /** fetch data from the table: "countries" */
  countries: Array<Countries>;
  /** fetch aggregated fields from the table: "countries" */
  countries_aggregate: Countries_Aggregate;
  /** fetch data from the table: "countries" using primary key columns */
  countries_by_pk?: Maybe<Countries>;
  /** fetch data from the table: "makes" */
  makes: Array<Makes>;
  /** fetch aggregated fields from the table: "makes" */
  makes_aggregate: Makes_Aggregate;
  /** fetch data from the table: "makes" using primary key columns */
  makes_by_pk?: Maybe<Makes>;
  me?: Maybe<UserType>;
  membershipTypeByEmail: MembershipTypeByEmailResponse;
  myContributions: MyContributionsResponse;
  /** fetch data from the table: "price_items" */
  price_items: Array<Price_Items>;
  /** fetch aggregated fields from the table: "price_items" */
  price_items_aggregate: Price_Items_Aggregate;
  /** fetch data from the table: "price_items" using primary key columns */
  price_items_by_pk?: Maybe<Price_Items>;
  /** An array relationship */
  states: Array<States>;
  /** An aggregate relationship */
  states_aggregate: States_Aggregate;
  /** fetch data from the table: "states" using primary key columns */
  states_by_pk?: Maybe<States>;
  /** fetch data from the table: "user_passkeys" */
  user_passkeys: Array<User_Passkeys>;
  /** fetch aggregated fields from the table: "user_passkeys" */
  user_passkeys_aggregate: User_Passkeys_Aggregate;
  /** fetch data from the table: "user_passkeys" using primary key columns */
  user_passkeys_by_pk?: Maybe<User_Passkeys>;
  /** fetch data from the table: "user_tokens" */
  user_tokens: Array<User_Tokens>;
  /** fetch aggregated fields from the table: "user_tokens" */
  user_tokens_aggregate: User_Tokens_Aggregate;
  /** fetch data from the table: "user_tokens" using primary key columns */
  user_tokens_by_pk?: Maybe<User_Tokens>;
  /** fetch data from the table: "users" */
  users: Array<Users>;
  /** fetch aggregated fields from the table: "users" */
  users_aggregate: Users_Aggregate;
  /** fetch data from the table: "users" using primary key columns */
  users_by_pk?: Maybe<Users>;
  /** fetch data from the table: "users_groups" */
  users_groups: Array<Users_Groups>;
  /** fetch aggregated fields from the table: "users_groups" */
  users_groups_aggregate: Users_Groups_Aggregate;
  /** fetch data from the table: "users_groups" using primary key columns */
  users_groups_by_pk?: Maybe<Users_Groups>;
  /** fetch data from the table: "users_user_permissions" */
  users_user_permissions: Array<Users_User_Permissions>;
  /** fetch aggregated fields from the table: "users_user_permissions" */
  users_user_permissions_aggregate: Users_User_Permissions_Aggregate;
  /** fetch data from the table: "users_user_permissions" using primary key columns */
  users_user_permissions_by_pk?: Maybe<Users_User_Permissions>;
  /** fetch data from the table: "variant_colors" */
  variant_colors: Array<Variant_Colors>;
  /** fetch aggregated fields from the table: "variant_colors" */
  variant_colors_aggregate: Variant_Colors_Aggregate;
  /** fetch data from the table: "variant_colors_attachments" */
  variant_colors_attachments: Array<Variant_Colors_Attachments>;
  /** fetch aggregated fields from the table: "variant_colors_attachments" */
  variant_colors_attachments_aggregate: Variant_Colors_Attachments_Aggregate;
  /** fetch data from the table: "variant_colors_attachments" using primary key columns */
  variant_colors_attachments_by_pk?: Maybe<Variant_Colors_Attachments>;
  /** fetch data from the table: "variant_colors" using primary key columns */
  variant_colors_by_pk?: Maybe<Variant_Colors>;
  /** An array relationship */
  variants: Array<Variants>;
  /** An aggregate relationship */
  variants_aggregate: Variants_Aggregate;
  /** fetch data from the table: "variants_attachments" */
  variants_attachments: Array<Variants_Attachments>;
  /** fetch aggregated fields from the table: "variants_attachments" */
  variants_attachments_aggregate: Variants_Attachments_Aggregate;
  /** fetch data from the table: "variants_attachments" using primary key columns */
  variants_attachments_by_pk?: Maybe<Variants_Attachments>;
  /** fetch data from the table: "variants" using primary key columns */
  variants_by_pk?: Maybe<Variants>;
  /** fetch data from the table: "vehicle_types" */
  vehicle_types: Array<Vehicle_Types>;
  /** fetch aggregated fields from the table: "vehicle_types" */
  vehicle_types_aggregate: Vehicle_Types_Aggregate;
  /** fetch data from the table: "vehicle_types" using primary key columns */
  vehicle_types_by_pk?: Maybe<Vehicle_Types>;
  /** An array relationship */
  vehicles: Array<Vehicles>;
  /** An aggregate relationship */
  vehicles_aggregate: Vehicles_Aggregate;
  /** fetch data from the table: "vehicles" using primary key columns */
  vehicles_by_pk?: Maybe<Vehicles>;
  version: Scalars['String']['output'];
  /** An array relationship */
  votes: Array<Votes>;
  /** An aggregate relationship */
  votes_aggregate: Votes_Aggregate;
  /** fetch data from the table: "votes" using primary key columns */
  votes_by_pk?: Maybe<Votes>;
};


export type Query_RootAttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Attachments_Order_By>>;
  where?: InputMaybe<Attachments_Bool_Exp>;
};


export type Query_RootAttachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Attachments_Order_By>>;
  where?: InputMaybe<Attachments_Bool_Exp>;
};


export type Query_RootAttachments_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootAuth_GroupArgs = {
  distinct_on?: InputMaybe<Array<Auth_Group_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Group_Order_By>>;
  where?: InputMaybe<Auth_Group_Bool_Exp>;
};


export type Query_RootAuth_Group_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Auth_Group_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Group_Order_By>>;
  where?: InputMaybe<Auth_Group_Bool_Exp>;
};


export type Query_RootAuth_Group_By_PkArgs = {
  id: Scalars['Int']['input'];
};


export type Query_RootAuth_Group_PermissionsArgs = {
  distinct_on?: InputMaybe<Array<Auth_Group_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Group_Permissions_Order_By>>;
  where?: InputMaybe<Auth_Group_Permissions_Bool_Exp>;
};


export type Query_RootAuth_Group_Permissions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Auth_Group_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Group_Permissions_Order_By>>;
  where?: InputMaybe<Auth_Group_Permissions_Bool_Exp>;
};


export type Query_RootAuth_Group_Permissions_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Query_RootAuth_PermissionArgs = {
  distinct_on?: InputMaybe<Array<Auth_Permission_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Permission_Order_By>>;
  where?: InputMaybe<Auth_Permission_Bool_Exp>;
};


export type Query_RootAuth_Permission_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Auth_Permission_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Permission_Order_By>>;
  where?: InputMaybe<Auth_Permission_Bool_Exp>;
};


export type Query_RootAuth_Permission_By_PkArgs = {
  id: Scalars['Int']['input'];
};


export type Query_RootCitiesArgs = {
  distinct_on?: InputMaybe<Array<Cities_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Cities_Order_By>>;
  where?: InputMaybe<Cities_Bool_Exp>;
};


export type Query_RootCities_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Cities_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Cities_Order_By>>;
  where?: InputMaybe<Cities_Bool_Exp>;
};


export type Query_RootCities_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootContribution_Price_ItemsArgs = {
  distinct_on?: InputMaybe<Array<Contribution_Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contribution_Price_Items_Order_By>>;
  where?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
};


export type Query_RootContribution_Price_Items_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contribution_Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contribution_Price_Items_Order_By>>;
  where?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
};


export type Query_RootContribution_Price_Items_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootContributionsArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


export type Query_RootContributions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


export type Query_RootContributions_AttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Attachments_Order_By>>;
  where?: InputMaybe<Contributions_Attachments_Bool_Exp>;
};


export type Query_RootContributions_Attachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Attachments_Order_By>>;
  where?: InputMaybe<Contributions_Attachments_Bool_Exp>;
};


export type Query_RootContributions_Attachments_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Query_RootContributions_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootCountriesArgs = {
  distinct_on?: InputMaybe<Array<Countries_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Countries_Order_By>>;
  where?: InputMaybe<Countries_Bool_Exp>;
};


export type Query_RootCountries_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Countries_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Countries_Order_By>>;
  where?: InputMaybe<Countries_Bool_Exp>;
};


export type Query_RootCountries_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootMakesArgs = {
  distinct_on?: InputMaybe<Array<Makes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Makes_Order_By>>;
  where?: InputMaybe<Makes_Bool_Exp>;
};


export type Query_RootMakes_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Makes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Makes_Order_By>>;
  where?: InputMaybe<Makes_Bool_Exp>;
};


export type Query_RootMakes_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootMembershipTypeByEmailArgs = {
  email: Scalars['String']['input'];
};


export type Query_RootMyContributionsArgs = {
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<Scalars['String']['input']>;
};


export type Query_RootPrice_ItemsArgs = {
  distinct_on?: InputMaybe<Array<Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Price_Items_Order_By>>;
  where?: InputMaybe<Price_Items_Bool_Exp>;
};


export type Query_RootPrice_Items_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Price_Items_Order_By>>;
  where?: InputMaybe<Price_Items_Bool_Exp>;
};


export type Query_RootPrice_Items_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootStatesArgs = {
  distinct_on?: InputMaybe<Array<States_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<States_Order_By>>;
  where?: InputMaybe<States_Bool_Exp>;
};


export type Query_RootStates_AggregateArgs = {
  distinct_on?: InputMaybe<Array<States_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<States_Order_By>>;
  where?: InputMaybe<States_Bool_Exp>;
};


export type Query_RootStates_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootUser_PasskeysArgs = {
  distinct_on?: InputMaybe<Array<User_Passkeys_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Passkeys_Order_By>>;
  where?: InputMaybe<User_Passkeys_Bool_Exp>;
};


export type Query_RootUser_Passkeys_AggregateArgs = {
  distinct_on?: InputMaybe<Array<User_Passkeys_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Passkeys_Order_By>>;
  where?: InputMaybe<User_Passkeys_Bool_Exp>;
};


export type Query_RootUser_Passkeys_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootUser_TokensArgs = {
  distinct_on?: InputMaybe<Array<User_Tokens_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Tokens_Order_By>>;
  where?: InputMaybe<User_Tokens_Bool_Exp>;
};


export type Query_RootUser_Tokens_AggregateArgs = {
  distinct_on?: InputMaybe<Array<User_Tokens_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Tokens_Order_By>>;
  where?: InputMaybe<User_Tokens_Bool_Exp>;
};


export type Query_RootUser_Tokens_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootUsersArgs = {
  distinct_on?: InputMaybe<Array<Users_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Order_By>>;
  where?: InputMaybe<Users_Bool_Exp>;
};


export type Query_RootUsers_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Users_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Order_By>>;
  where?: InputMaybe<Users_Bool_Exp>;
};


export type Query_RootUsers_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootUsers_GroupsArgs = {
  distinct_on?: InputMaybe<Array<Users_Groups_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Groups_Order_By>>;
  where?: InputMaybe<Users_Groups_Bool_Exp>;
};


export type Query_RootUsers_Groups_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Users_Groups_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Groups_Order_By>>;
  where?: InputMaybe<Users_Groups_Bool_Exp>;
};


export type Query_RootUsers_Groups_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Query_RootUsers_User_PermissionsArgs = {
  distinct_on?: InputMaybe<Array<Users_User_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_User_Permissions_Order_By>>;
  where?: InputMaybe<Users_User_Permissions_Bool_Exp>;
};


export type Query_RootUsers_User_Permissions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Users_User_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_User_Permissions_Order_By>>;
  where?: InputMaybe<Users_User_Permissions_Bool_Exp>;
};


export type Query_RootUsers_User_Permissions_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Query_RootVariant_ColorsArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Order_By>>;
  where?: InputMaybe<Variant_Colors_Bool_Exp>;
};


export type Query_RootVariant_Colors_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Order_By>>;
  where?: InputMaybe<Variant_Colors_Bool_Exp>;
};


export type Query_RootVariant_Colors_AttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Attachments_Order_By>>;
  where?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
};


export type Query_RootVariant_Colors_Attachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Attachments_Order_By>>;
  where?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
};


export type Query_RootVariant_Colors_Attachments_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Query_RootVariant_Colors_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootVariantsArgs = {
  distinct_on?: InputMaybe<Array<Variants_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Order_By>>;
  where?: InputMaybe<Variants_Bool_Exp>;
};


export type Query_RootVariants_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variants_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Order_By>>;
  where?: InputMaybe<Variants_Bool_Exp>;
};


export type Query_RootVariants_AttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Variants_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Attachments_Order_By>>;
  where?: InputMaybe<Variants_Attachments_Bool_Exp>;
};


export type Query_RootVariants_Attachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variants_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Attachments_Order_By>>;
  where?: InputMaybe<Variants_Attachments_Bool_Exp>;
};


export type Query_RootVariants_Attachments_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Query_RootVariants_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootVehicle_TypesArgs = {
  distinct_on?: InputMaybe<Array<Vehicle_Types_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicle_Types_Order_By>>;
  where?: InputMaybe<Vehicle_Types_Bool_Exp>;
};


export type Query_RootVehicle_Types_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Vehicle_Types_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicle_Types_Order_By>>;
  where?: InputMaybe<Vehicle_Types_Bool_Exp>;
};


export type Query_RootVehicle_Types_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootVehiclesArgs = {
  distinct_on?: InputMaybe<Array<Vehicles_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicles_Order_By>>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};


export type Query_RootVehicles_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Vehicles_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicles_Order_By>>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};


export type Query_RootVehicles_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Query_RootVotesArgs = {
  distinct_on?: InputMaybe<Array<Votes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Votes_Order_By>>;
  where?: InputMaybe<Votes_Bool_Exp>;
};


export type Query_RootVotes_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Votes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Votes_Order_By>>;
  where?: InputMaybe<Votes_Bool_Exp>;
};


export type Query_RootVotes_By_PkArgs = {
  id: Scalars['uuid']['input'];
};

/** Boolean expression to compare columns of type "smallint". All fields are combined with logical 'AND'. */
export type Smallint_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['smallint']['input']>;
  _gt?: InputMaybe<Scalars['smallint']['input']>;
  _gte?: InputMaybe<Scalars['smallint']['input']>;
  _in?: InputMaybe<Array<Scalars['smallint']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['smallint']['input']>;
  _lte?: InputMaybe<Scalars['smallint']['input']>;
  _neq?: InputMaybe<Scalars['smallint']['input']>;
  _nin?: InputMaybe<Array<Scalars['smallint']['input']>>;
};

/** columns and relationships of "states" */
export type States = {
  __typename?: 'states';
  /** An array relationship */
  cities: Array<Cities>;
  /** An aggregate relationship */
  cities_aggregate: Cities_Aggregate;
  code?: Maybe<Scalars['String']['output']>;
  /** An object relationship */
  country: Countries;
  country_id: Scalars['uuid']['output'];
  id: Scalars['uuid']['output'];
  name: Scalars['String']['output'];
};


/** columns and relationships of "states" */
export type StatesCitiesArgs = {
  distinct_on?: InputMaybe<Array<Cities_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Cities_Order_By>>;
  where?: InputMaybe<Cities_Bool_Exp>;
};


/** columns and relationships of "states" */
export type StatesCities_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Cities_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Cities_Order_By>>;
  where?: InputMaybe<Cities_Bool_Exp>;
};

/** aggregated selection of "states" */
export type States_Aggregate = {
  __typename?: 'states_aggregate';
  aggregate?: Maybe<States_Aggregate_Fields>;
  nodes: Array<States>;
};

export type States_Aggregate_Bool_Exp = {
  count?: InputMaybe<States_Aggregate_Bool_Exp_Count>;
};

export type States_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<States_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<States_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "states" */
export type States_Aggregate_Fields = {
  __typename?: 'states_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<States_Max_Fields>;
  min?: Maybe<States_Min_Fields>;
};


/** aggregate fields of "states" */
export type States_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<States_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "states" */
export type States_Aggregate_Order_By = {
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<States_Max_Order_By>;
  min?: InputMaybe<States_Min_Order_By>;
};

/** input type for inserting array relation for remote table "states" */
export type States_Arr_Rel_Insert_Input = {
  data: Array<States_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<States_On_Conflict>;
};

/** Boolean expression to filter rows from the table "states". All fields are combined with a logical 'AND'. */
export type States_Bool_Exp = {
  _and?: InputMaybe<Array<States_Bool_Exp>>;
  _not?: InputMaybe<States_Bool_Exp>;
  _or?: InputMaybe<Array<States_Bool_Exp>>;
  cities?: InputMaybe<Cities_Bool_Exp>;
  cities_aggregate?: InputMaybe<Cities_Aggregate_Bool_Exp>;
  code?: InputMaybe<String_Comparison_Exp>;
  country?: InputMaybe<Countries_Bool_Exp>;
  country_id?: InputMaybe<Uuid_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
};

/** unique or primary key constraints on table "states" */
export enum States_Constraint {
  /** unique or primary key constraint on columns "id" */
  StatesPkey = 'states_pkey'
}

/** input type for inserting data into table "states" */
export type States_Insert_Input = {
  cities?: InputMaybe<Cities_Arr_Rel_Insert_Input>;
  code?: InputMaybe<Scalars['String']['input']>;
  country?: InputMaybe<Countries_Obj_Rel_Insert_Input>;
  country_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** aggregate max on columns */
export type States_Max_Fields = {
  __typename?: 'states_max_fields';
  code?: Maybe<Scalars['String']['output']>;
  country_id?: Maybe<Scalars['uuid']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** order by max() on columns of table "states" */
export type States_Max_Order_By = {
  code?: InputMaybe<Order_By>;
  country_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type States_Min_Fields = {
  __typename?: 'states_min_fields';
  code?: Maybe<Scalars['String']['output']>;
  country_id?: Maybe<Scalars['uuid']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** order by min() on columns of table "states" */
export type States_Min_Order_By = {
  code?: InputMaybe<Order_By>;
  country_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "states" */
export type States_Mutation_Response = {
  __typename?: 'states_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<States>;
};

/** input type for inserting object relation for remote table "states" */
export type States_Obj_Rel_Insert_Input = {
  data: States_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<States_On_Conflict>;
};

/** on_conflict condition type for table "states" */
export type States_On_Conflict = {
  constraint: States_Constraint;
  update_columns?: Array<States_Update_Column>;
  where?: InputMaybe<States_Bool_Exp>;
};

/** Ordering options when selecting data from "states". */
export type States_Order_By = {
  cities_aggregate?: InputMaybe<Cities_Aggregate_Order_By>;
  code?: InputMaybe<Order_By>;
  country?: InputMaybe<Countries_Order_By>;
  country_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
};

/** primary key columns input for table: states */
export type States_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "states" */
export enum States_Select_Column {
  /** column name */
  Code = 'code',
  /** column name */
  CountryId = 'country_id',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

/** input type for updating data in table "states" */
export type States_Set_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  country_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** Streaming cursor of the table "states" */
export type States_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: States_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type States_Stream_Cursor_Value_Input = {
  code?: InputMaybe<Scalars['String']['input']>;
  country_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** update columns of table "states" */
export enum States_Update_Column {
  /** column name */
  Code = 'code',
  /** column name */
  CountryId = 'country_id',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

export type States_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<States_Set_Input>;
  /** filter the rows which have to be updated */
  where: States_Bool_Exp;
};

export type Subscription_Root = {
  __typename?: 'subscription_root';
  /** fetch data from the table: "attachments" */
  attachments: Array<Attachments>;
  /** fetch aggregated fields from the table: "attachments" */
  attachments_aggregate: Attachments_Aggregate;
  /** fetch data from the table: "attachments" using primary key columns */
  attachments_by_pk?: Maybe<Attachments>;
  /** fetch data from the table in a streaming manner: "attachments" */
  attachments_stream: Array<Attachments>;
  /** fetch data from the table: "auth_group" */
  auth_group: Array<Auth_Group>;
  /** fetch aggregated fields from the table: "auth_group" */
  auth_group_aggregate: Auth_Group_Aggregate;
  /** fetch data from the table: "auth_group" using primary key columns */
  auth_group_by_pk?: Maybe<Auth_Group>;
  /** fetch data from the table: "auth_group_permissions" */
  auth_group_permissions: Array<Auth_Group_Permissions>;
  /** fetch aggregated fields from the table: "auth_group_permissions" */
  auth_group_permissions_aggregate: Auth_Group_Permissions_Aggregate;
  /** fetch data from the table: "auth_group_permissions" using primary key columns */
  auth_group_permissions_by_pk?: Maybe<Auth_Group_Permissions>;
  /** fetch data from the table in a streaming manner: "auth_group_permissions" */
  auth_group_permissions_stream: Array<Auth_Group_Permissions>;
  /** fetch data from the table in a streaming manner: "auth_group" */
  auth_group_stream: Array<Auth_Group>;
  /** fetch data from the table: "auth_permission" */
  auth_permission: Array<Auth_Permission>;
  /** fetch aggregated fields from the table: "auth_permission" */
  auth_permission_aggregate: Auth_Permission_Aggregate;
  /** fetch data from the table: "auth_permission" using primary key columns */
  auth_permission_by_pk?: Maybe<Auth_Permission>;
  /** fetch data from the table in a streaming manner: "auth_permission" */
  auth_permission_stream: Array<Auth_Permission>;
  /** An array relationship */
  cities: Array<Cities>;
  /** An aggregate relationship */
  cities_aggregate: Cities_Aggregate;
  /** fetch data from the table: "cities" using primary key columns */
  cities_by_pk?: Maybe<Cities>;
  /** fetch data from the table in a streaming manner: "cities" */
  cities_stream: Array<Cities>;
  /** fetch data from the table: "contribution_price_items" */
  contribution_price_items: Array<Contribution_Price_Items>;
  /** fetch aggregated fields from the table: "contribution_price_items" */
  contribution_price_items_aggregate: Contribution_Price_Items_Aggregate;
  /** fetch data from the table: "contribution_price_items" using primary key columns */
  contribution_price_items_by_pk?: Maybe<Contribution_Price_Items>;
  /** fetch data from the table in a streaming manner: "contribution_price_items" */
  contribution_price_items_stream: Array<Contribution_Price_Items>;
  /** An array relationship */
  contributions: Array<Contributions>;
  /** An aggregate relationship */
  contributions_aggregate: Contributions_Aggregate;
  /** fetch data from the table: "contributions_attachments" */
  contributions_attachments: Array<Contributions_Attachments>;
  /** fetch aggregated fields from the table: "contributions_attachments" */
  contributions_attachments_aggregate: Contributions_Attachments_Aggregate;
  /** fetch data from the table: "contributions_attachments" using primary key columns */
  contributions_attachments_by_pk?: Maybe<Contributions_Attachments>;
  /** fetch data from the table in a streaming manner: "contributions_attachments" */
  contributions_attachments_stream: Array<Contributions_Attachments>;
  /** fetch data from the table: "contributions" using primary key columns */
  contributions_by_pk?: Maybe<Contributions>;
  /** fetch data from the table in a streaming manner: "contributions" */
  contributions_stream: Array<Contributions>;
  /** fetch data from the table: "countries" */
  countries: Array<Countries>;
  /** fetch aggregated fields from the table: "countries" */
  countries_aggregate: Countries_Aggregate;
  /** fetch data from the table: "countries" using primary key columns */
  countries_by_pk?: Maybe<Countries>;
  /** fetch data from the table in a streaming manner: "countries" */
  countries_stream: Array<Countries>;
  /** fetch data from the table: "makes" */
  makes: Array<Makes>;
  /** fetch aggregated fields from the table: "makes" */
  makes_aggregate: Makes_Aggregate;
  /** fetch data from the table: "makes" using primary key columns */
  makes_by_pk?: Maybe<Makes>;
  /** fetch data from the table in a streaming manner: "makes" */
  makes_stream: Array<Makes>;
  /** fetch data from the table: "price_items" */
  price_items: Array<Price_Items>;
  /** fetch aggregated fields from the table: "price_items" */
  price_items_aggregate: Price_Items_Aggregate;
  /** fetch data from the table: "price_items" using primary key columns */
  price_items_by_pk?: Maybe<Price_Items>;
  /** fetch data from the table in a streaming manner: "price_items" */
  price_items_stream: Array<Price_Items>;
  /** An array relationship */
  states: Array<States>;
  /** An aggregate relationship */
  states_aggregate: States_Aggregate;
  /** fetch data from the table: "states" using primary key columns */
  states_by_pk?: Maybe<States>;
  /** fetch data from the table in a streaming manner: "states" */
  states_stream: Array<States>;
  /** fetch data from the table: "user_passkeys" */
  user_passkeys: Array<User_Passkeys>;
  /** fetch aggregated fields from the table: "user_passkeys" */
  user_passkeys_aggregate: User_Passkeys_Aggregate;
  /** fetch data from the table: "user_passkeys" using primary key columns */
  user_passkeys_by_pk?: Maybe<User_Passkeys>;
  /** fetch data from the table in a streaming manner: "user_passkeys" */
  user_passkeys_stream: Array<User_Passkeys>;
  /** fetch data from the table: "user_tokens" */
  user_tokens: Array<User_Tokens>;
  /** fetch aggregated fields from the table: "user_tokens" */
  user_tokens_aggregate: User_Tokens_Aggregate;
  /** fetch data from the table: "user_tokens" using primary key columns */
  user_tokens_by_pk?: Maybe<User_Tokens>;
  /** fetch data from the table in a streaming manner: "user_tokens" */
  user_tokens_stream: Array<User_Tokens>;
  /** fetch data from the table: "users" */
  users: Array<Users>;
  /** fetch aggregated fields from the table: "users" */
  users_aggregate: Users_Aggregate;
  /** fetch data from the table: "users" using primary key columns */
  users_by_pk?: Maybe<Users>;
  /** fetch data from the table: "users_groups" */
  users_groups: Array<Users_Groups>;
  /** fetch aggregated fields from the table: "users_groups" */
  users_groups_aggregate: Users_Groups_Aggregate;
  /** fetch data from the table: "users_groups" using primary key columns */
  users_groups_by_pk?: Maybe<Users_Groups>;
  /** fetch data from the table in a streaming manner: "users_groups" */
  users_groups_stream: Array<Users_Groups>;
  /** fetch data from the table in a streaming manner: "users" */
  users_stream: Array<Users>;
  /** fetch data from the table: "users_user_permissions" */
  users_user_permissions: Array<Users_User_Permissions>;
  /** fetch aggregated fields from the table: "users_user_permissions" */
  users_user_permissions_aggregate: Users_User_Permissions_Aggregate;
  /** fetch data from the table: "users_user_permissions" using primary key columns */
  users_user_permissions_by_pk?: Maybe<Users_User_Permissions>;
  /** fetch data from the table in a streaming manner: "users_user_permissions" */
  users_user_permissions_stream: Array<Users_User_Permissions>;
  /** fetch data from the table: "variant_colors" */
  variant_colors: Array<Variant_Colors>;
  /** fetch aggregated fields from the table: "variant_colors" */
  variant_colors_aggregate: Variant_Colors_Aggregate;
  /** fetch data from the table: "variant_colors_attachments" */
  variant_colors_attachments: Array<Variant_Colors_Attachments>;
  /** fetch aggregated fields from the table: "variant_colors_attachments" */
  variant_colors_attachments_aggregate: Variant_Colors_Attachments_Aggregate;
  /** fetch data from the table: "variant_colors_attachments" using primary key columns */
  variant_colors_attachments_by_pk?: Maybe<Variant_Colors_Attachments>;
  /** fetch data from the table in a streaming manner: "variant_colors_attachments" */
  variant_colors_attachments_stream: Array<Variant_Colors_Attachments>;
  /** fetch data from the table: "variant_colors" using primary key columns */
  variant_colors_by_pk?: Maybe<Variant_Colors>;
  /** fetch data from the table in a streaming manner: "variant_colors" */
  variant_colors_stream: Array<Variant_Colors>;
  /** An array relationship */
  variants: Array<Variants>;
  /** An aggregate relationship */
  variants_aggregate: Variants_Aggregate;
  /** fetch data from the table: "variants_attachments" */
  variants_attachments: Array<Variants_Attachments>;
  /** fetch aggregated fields from the table: "variants_attachments" */
  variants_attachments_aggregate: Variants_Attachments_Aggregate;
  /** fetch data from the table: "variants_attachments" using primary key columns */
  variants_attachments_by_pk?: Maybe<Variants_Attachments>;
  /** fetch data from the table in a streaming manner: "variants_attachments" */
  variants_attachments_stream: Array<Variants_Attachments>;
  /** fetch data from the table: "variants" using primary key columns */
  variants_by_pk?: Maybe<Variants>;
  /** fetch data from the table in a streaming manner: "variants" */
  variants_stream: Array<Variants>;
  /** fetch data from the table: "vehicle_types" */
  vehicle_types: Array<Vehicle_Types>;
  /** fetch aggregated fields from the table: "vehicle_types" */
  vehicle_types_aggregate: Vehicle_Types_Aggregate;
  /** fetch data from the table: "vehicle_types" using primary key columns */
  vehicle_types_by_pk?: Maybe<Vehicle_Types>;
  /** fetch data from the table in a streaming manner: "vehicle_types" */
  vehicle_types_stream: Array<Vehicle_Types>;
  /** An array relationship */
  vehicles: Array<Vehicles>;
  /** An aggregate relationship */
  vehicles_aggregate: Vehicles_Aggregate;
  /** fetch data from the table: "vehicles" using primary key columns */
  vehicles_by_pk?: Maybe<Vehicles>;
  /** fetch data from the table in a streaming manner: "vehicles" */
  vehicles_stream: Array<Vehicles>;
  /** An array relationship */
  votes: Array<Votes>;
  /** An aggregate relationship */
  votes_aggregate: Votes_Aggregate;
  /** fetch data from the table: "votes" using primary key columns */
  votes_by_pk?: Maybe<Votes>;
  /** fetch data from the table in a streaming manner: "votes" */
  votes_stream: Array<Votes>;
};


export type Subscription_RootAttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Attachments_Order_By>>;
  where?: InputMaybe<Attachments_Bool_Exp>;
};


export type Subscription_RootAttachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Attachments_Order_By>>;
  where?: InputMaybe<Attachments_Bool_Exp>;
};


export type Subscription_RootAttachments_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootAttachments_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Attachments_Stream_Cursor_Input>>;
  where?: InputMaybe<Attachments_Bool_Exp>;
};


export type Subscription_RootAuth_GroupArgs = {
  distinct_on?: InputMaybe<Array<Auth_Group_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Group_Order_By>>;
  where?: InputMaybe<Auth_Group_Bool_Exp>;
};


export type Subscription_RootAuth_Group_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Auth_Group_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Group_Order_By>>;
  where?: InputMaybe<Auth_Group_Bool_Exp>;
};


export type Subscription_RootAuth_Group_By_PkArgs = {
  id: Scalars['Int']['input'];
};


export type Subscription_RootAuth_Group_PermissionsArgs = {
  distinct_on?: InputMaybe<Array<Auth_Group_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Group_Permissions_Order_By>>;
  where?: InputMaybe<Auth_Group_Permissions_Bool_Exp>;
};


export type Subscription_RootAuth_Group_Permissions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Auth_Group_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Group_Permissions_Order_By>>;
  where?: InputMaybe<Auth_Group_Permissions_Bool_Exp>;
};


export type Subscription_RootAuth_Group_Permissions_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Subscription_RootAuth_Group_Permissions_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Auth_Group_Permissions_Stream_Cursor_Input>>;
  where?: InputMaybe<Auth_Group_Permissions_Bool_Exp>;
};


export type Subscription_RootAuth_Group_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Auth_Group_Stream_Cursor_Input>>;
  where?: InputMaybe<Auth_Group_Bool_Exp>;
};


export type Subscription_RootAuth_PermissionArgs = {
  distinct_on?: InputMaybe<Array<Auth_Permission_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Permission_Order_By>>;
  where?: InputMaybe<Auth_Permission_Bool_Exp>;
};


export type Subscription_RootAuth_Permission_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Auth_Permission_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Auth_Permission_Order_By>>;
  where?: InputMaybe<Auth_Permission_Bool_Exp>;
};


export type Subscription_RootAuth_Permission_By_PkArgs = {
  id: Scalars['Int']['input'];
};


export type Subscription_RootAuth_Permission_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Auth_Permission_Stream_Cursor_Input>>;
  where?: InputMaybe<Auth_Permission_Bool_Exp>;
};


export type Subscription_RootCitiesArgs = {
  distinct_on?: InputMaybe<Array<Cities_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Cities_Order_By>>;
  where?: InputMaybe<Cities_Bool_Exp>;
};


export type Subscription_RootCities_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Cities_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Cities_Order_By>>;
  where?: InputMaybe<Cities_Bool_Exp>;
};


export type Subscription_RootCities_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootCities_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Cities_Stream_Cursor_Input>>;
  where?: InputMaybe<Cities_Bool_Exp>;
};


export type Subscription_RootContribution_Price_ItemsArgs = {
  distinct_on?: InputMaybe<Array<Contribution_Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contribution_Price_Items_Order_By>>;
  where?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
};


export type Subscription_RootContribution_Price_Items_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contribution_Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contribution_Price_Items_Order_By>>;
  where?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
};


export type Subscription_RootContribution_Price_Items_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootContribution_Price_Items_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Contribution_Price_Items_Stream_Cursor_Input>>;
  where?: InputMaybe<Contribution_Price_Items_Bool_Exp>;
};


export type Subscription_RootContributionsArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


export type Subscription_RootContributions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


export type Subscription_RootContributions_AttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Attachments_Order_By>>;
  where?: InputMaybe<Contributions_Attachments_Bool_Exp>;
};


export type Subscription_RootContributions_Attachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Attachments_Order_By>>;
  where?: InputMaybe<Contributions_Attachments_Bool_Exp>;
};


export type Subscription_RootContributions_Attachments_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Subscription_RootContributions_Attachments_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Contributions_Attachments_Stream_Cursor_Input>>;
  where?: InputMaybe<Contributions_Attachments_Bool_Exp>;
};


export type Subscription_RootContributions_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootContributions_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Contributions_Stream_Cursor_Input>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


export type Subscription_RootCountriesArgs = {
  distinct_on?: InputMaybe<Array<Countries_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Countries_Order_By>>;
  where?: InputMaybe<Countries_Bool_Exp>;
};


export type Subscription_RootCountries_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Countries_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Countries_Order_By>>;
  where?: InputMaybe<Countries_Bool_Exp>;
};


export type Subscription_RootCountries_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootCountries_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Countries_Stream_Cursor_Input>>;
  where?: InputMaybe<Countries_Bool_Exp>;
};


export type Subscription_RootMakesArgs = {
  distinct_on?: InputMaybe<Array<Makes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Makes_Order_By>>;
  where?: InputMaybe<Makes_Bool_Exp>;
};


export type Subscription_RootMakes_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Makes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Makes_Order_By>>;
  where?: InputMaybe<Makes_Bool_Exp>;
};


export type Subscription_RootMakes_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootMakes_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Makes_Stream_Cursor_Input>>;
  where?: InputMaybe<Makes_Bool_Exp>;
};


export type Subscription_RootPrice_ItemsArgs = {
  distinct_on?: InputMaybe<Array<Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Price_Items_Order_By>>;
  where?: InputMaybe<Price_Items_Bool_Exp>;
};


export type Subscription_RootPrice_Items_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Price_Items_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Price_Items_Order_By>>;
  where?: InputMaybe<Price_Items_Bool_Exp>;
};


export type Subscription_RootPrice_Items_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootPrice_Items_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Price_Items_Stream_Cursor_Input>>;
  where?: InputMaybe<Price_Items_Bool_Exp>;
};


export type Subscription_RootStatesArgs = {
  distinct_on?: InputMaybe<Array<States_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<States_Order_By>>;
  where?: InputMaybe<States_Bool_Exp>;
};


export type Subscription_RootStates_AggregateArgs = {
  distinct_on?: InputMaybe<Array<States_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<States_Order_By>>;
  where?: InputMaybe<States_Bool_Exp>;
};


export type Subscription_RootStates_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootStates_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<States_Stream_Cursor_Input>>;
  where?: InputMaybe<States_Bool_Exp>;
};


export type Subscription_RootUser_PasskeysArgs = {
  distinct_on?: InputMaybe<Array<User_Passkeys_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Passkeys_Order_By>>;
  where?: InputMaybe<User_Passkeys_Bool_Exp>;
};


export type Subscription_RootUser_Passkeys_AggregateArgs = {
  distinct_on?: InputMaybe<Array<User_Passkeys_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Passkeys_Order_By>>;
  where?: InputMaybe<User_Passkeys_Bool_Exp>;
};


export type Subscription_RootUser_Passkeys_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootUser_Passkeys_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<User_Passkeys_Stream_Cursor_Input>>;
  where?: InputMaybe<User_Passkeys_Bool_Exp>;
};


export type Subscription_RootUser_TokensArgs = {
  distinct_on?: InputMaybe<Array<User_Tokens_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Tokens_Order_By>>;
  where?: InputMaybe<User_Tokens_Bool_Exp>;
};


export type Subscription_RootUser_Tokens_AggregateArgs = {
  distinct_on?: InputMaybe<Array<User_Tokens_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Tokens_Order_By>>;
  where?: InputMaybe<User_Tokens_Bool_Exp>;
};


export type Subscription_RootUser_Tokens_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootUser_Tokens_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<User_Tokens_Stream_Cursor_Input>>;
  where?: InputMaybe<User_Tokens_Bool_Exp>;
};


export type Subscription_RootUsersArgs = {
  distinct_on?: InputMaybe<Array<Users_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Order_By>>;
  where?: InputMaybe<Users_Bool_Exp>;
};


export type Subscription_RootUsers_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Users_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Order_By>>;
  where?: InputMaybe<Users_Bool_Exp>;
};


export type Subscription_RootUsers_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootUsers_GroupsArgs = {
  distinct_on?: InputMaybe<Array<Users_Groups_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Groups_Order_By>>;
  where?: InputMaybe<Users_Groups_Bool_Exp>;
};


export type Subscription_RootUsers_Groups_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Users_Groups_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Groups_Order_By>>;
  where?: InputMaybe<Users_Groups_Bool_Exp>;
};


export type Subscription_RootUsers_Groups_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Subscription_RootUsers_Groups_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Users_Groups_Stream_Cursor_Input>>;
  where?: InputMaybe<Users_Groups_Bool_Exp>;
};


export type Subscription_RootUsers_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Users_Stream_Cursor_Input>>;
  where?: InputMaybe<Users_Bool_Exp>;
};


export type Subscription_RootUsers_User_PermissionsArgs = {
  distinct_on?: InputMaybe<Array<Users_User_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_User_Permissions_Order_By>>;
  where?: InputMaybe<Users_User_Permissions_Bool_Exp>;
};


export type Subscription_RootUsers_User_Permissions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Users_User_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_User_Permissions_Order_By>>;
  where?: InputMaybe<Users_User_Permissions_Bool_Exp>;
};


export type Subscription_RootUsers_User_Permissions_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Subscription_RootUsers_User_Permissions_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Users_User_Permissions_Stream_Cursor_Input>>;
  where?: InputMaybe<Users_User_Permissions_Bool_Exp>;
};


export type Subscription_RootVariant_ColorsArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Order_By>>;
  where?: InputMaybe<Variant_Colors_Bool_Exp>;
};


export type Subscription_RootVariant_Colors_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Order_By>>;
  where?: InputMaybe<Variant_Colors_Bool_Exp>;
};


export type Subscription_RootVariant_Colors_AttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Attachments_Order_By>>;
  where?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
};


export type Subscription_RootVariant_Colors_Attachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Attachments_Order_By>>;
  where?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
};


export type Subscription_RootVariant_Colors_Attachments_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Subscription_RootVariant_Colors_Attachments_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Variant_Colors_Attachments_Stream_Cursor_Input>>;
  where?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
};


export type Subscription_RootVariant_Colors_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootVariant_Colors_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Variant_Colors_Stream_Cursor_Input>>;
  where?: InputMaybe<Variant_Colors_Bool_Exp>;
};


export type Subscription_RootVariantsArgs = {
  distinct_on?: InputMaybe<Array<Variants_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Order_By>>;
  where?: InputMaybe<Variants_Bool_Exp>;
};


export type Subscription_RootVariants_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variants_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Order_By>>;
  where?: InputMaybe<Variants_Bool_Exp>;
};


export type Subscription_RootVariants_AttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Variants_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Attachments_Order_By>>;
  where?: InputMaybe<Variants_Attachments_Bool_Exp>;
};


export type Subscription_RootVariants_Attachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variants_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Attachments_Order_By>>;
  where?: InputMaybe<Variants_Attachments_Bool_Exp>;
};


export type Subscription_RootVariants_Attachments_By_PkArgs = {
  id: Scalars['bigint']['input'];
};


export type Subscription_RootVariants_Attachments_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Variants_Attachments_Stream_Cursor_Input>>;
  where?: InputMaybe<Variants_Attachments_Bool_Exp>;
};


export type Subscription_RootVariants_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootVariants_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Variants_Stream_Cursor_Input>>;
  where?: InputMaybe<Variants_Bool_Exp>;
};


export type Subscription_RootVehicle_TypesArgs = {
  distinct_on?: InputMaybe<Array<Vehicle_Types_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicle_Types_Order_By>>;
  where?: InputMaybe<Vehicle_Types_Bool_Exp>;
};


export type Subscription_RootVehicle_Types_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Vehicle_Types_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicle_Types_Order_By>>;
  where?: InputMaybe<Vehicle_Types_Bool_Exp>;
};


export type Subscription_RootVehicle_Types_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootVehicle_Types_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Vehicle_Types_Stream_Cursor_Input>>;
  where?: InputMaybe<Vehicle_Types_Bool_Exp>;
};


export type Subscription_RootVehiclesArgs = {
  distinct_on?: InputMaybe<Array<Vehicles_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicles_Order_By>>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};


export type Subscription_RootVehicles_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Vehicles_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicles_Order_By>>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};


export type Subscription_RootVehicles_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootVehicles_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Vehicles_Stream_Cursor_Input>>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};


export type Subscription_RootVotesArgs = {
  distinct_on?: InputMaybe<Array<Votes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Votes_Order_By>>;
  where?: InputMaybe<Votes_Bool_Exp>;
};


export type Subscription_RootVotes_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Votes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Votes_Order_By>>;
  where?: InputMaybe<Votes_Bool_Exp>;
};


export type Subscription_RootVotes_By_PkArgs = {
  id: Scalars['uuid']['input'];
};


export type Subscription_RootVotes_StreamArgs = {
  batch_size: Scalars['Int']['input'];
  cursor: Array<InputMaybe<Votes_Stream_Cursor_Input>>;
  where?: InputMaybe<Votes_Bool_Exp>;
};

/** Boolean expression to compare columns of type "timestamptz". All fields are combined with logical 'AND'. */
export type Timestamptz_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['timestamptz']['input']>;
  _gt?: InputMaybe<Scalars['timestamptz']['input']>;
  _gte?: InputMaybe<Scalars['timestamptz']['input']>;
  _in?: InputMaybe<Array<Scalars['timestamptz']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['timestamptz']['input']>;
  _lte?: InputMaybe<Scalars['timestamptz']['input']>;
  _neq?: InputMaybe<Scalars['timestamptz']['input']>;
  _nin?: InputMaybe<Array<Scalars['timestamptz']['input']>>;
};

/** columns and relationships of "user_passkeys" */
export type User_Passkeys = {
  __typename?: 'user_passkeys';
  created_at: Scalars['timestamptz']['output'];
  credential_id: Scalars['bytea']['output'];
  description?: Maybe<Scalars['String']['output']>;
  id: Scalars['uuid']['output'];
  name?: Maybe<Scalars['String']['output']>;
  public_key: Scalars['bytea']['output'];
  updated_at: Scalars['timestamptz']['output'];
  user_id: Scalars['uuid']['output'];
};

/** aggregated selection of "user_passkeys" */
export type User_Passkeys_Aggregate = {
  __typename?: 'user_passkeys_aggregate';
  aggregate?: Maybe<User_Passkeys_Aggregate_Fields>;
  nodes: Array<User_Passkeys>;
};

export type User_Passkeys_Aggregate_Bool_Exp = {
  count?: InputMaybe<User_Passkeys_Aggregate_Bool_Exp_Count>;
};

export type User_Passkeys_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<User_Passkeys_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<User_Passkeys_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "user_passkeys" */
export type User_Passkeys_Aggregate_Fields = {
  __typename?: 'user_passkeys_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<User_Passkeys_Max_Fields>;
  min?: Maybe<User_Passkeys_Min_Fields>;
};


/** aggregate fields of "user_passkeys" */
export type User_Passkeys_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<User_Passkeys_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "user_passkeys" */
export type User_Passkeys_Aggregate_Order_By = {
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<User_Passkeys_Max_Order_By>;
  min?: InputMaybe<User_Passkeys_Min_Order_By>;
};

/** input type for inserting array relation for remote table "user_passkeys" */
export type User_Passkeys_Arr_Rel_Insert_Input = {
  data: Array<User_Passkeys_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<User_Passkeys_On_Conflict>;
};

/** Boolean expression to filter rows from the table "user_passkeys". All fields are combined with a logical 'AND'. */
export type User_Passkeys_Bool_Exp = {
  _and?: InputMaybe<Array<User_Passkeys_Bool_Exp>>;
  _not?: InputMaybe<User_Passkeys_Bool_Exp>;
  _or?: InputMaybe<Array<User_Passkeys_Bool_Exp>>;
  created_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  credential_id?: InputMaybe<Bytea_Comparison_Exp>;
  description?: InputMaybe<String_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
  public_key?: InputMaybe<Bytea_Comparison_Exp>;
  updated_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  user_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "user_passkeys" */
export enum User_Passkeys_Constraint {
  /** unique or primary key constraint on columns "credential_id" */
  UserPasskeysCredentialId_016b7a67Uniq = 'user_passkeys_credential_id_016b7a67_uniq',
  /** unique or primary key constraint on columns "id" */
  UserPasskeysPkey = 'user_passkeys_pkey'
}

/** input type for inserting data into table "user_passkeys" */
export type User_Passkeys_Insert_Input = {
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  credential_id?: InputMaybe<Scalars['bytea']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  public_key?: InputMaybe<Scalars['bytea']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type User_Passkeys_Max_Fields = {
  __typename?: 'user_passkeys_max_fields';
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  description?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "user_passkeys" */
export type User_Passkeys_Max_Order_By = {
  created_at?: InputMaybe<Order_By>;
  description?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type User_Passkeys_Min_Fields = {
  __typename?: 'user_passkeys_min_fields';
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  description?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "user_passkeys" */
export type User_Passkeys_Min_Order_By = {
  created_at?: InputMaybe<Order_By>;
  description?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "user_passkeys" */
export type User_Passkeys_Mutation_Response = {
  __typename?: 'user_passkeys_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<User_Passkeys>;
};

/** on_conflict condition type for table "user_passkeys" */
export type User_Passkeys_On_Conflict = {
  constraint: User_Passkeys_Constraint;
  update_columns?: Array<User_Passkeys_Update_Column>;
  where?: InputMaybe<User_Passkeys_Bool_Exp>;
};

/** Ordering options when selecting data from "user_passkeys". */
export type User_Passkeys_Order_By = {
  created_at?: InputMaybe<Order_By>;
  credential_id?: InputMaybe<Order_By>;
  description?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  public_key?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: user_passkeys */
export type User_Passkeys_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "user_passkeys" */
export enum User_Passkeys_Select_Column {
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  CredentialId = 'credential_id',
  /** column name */
  Description = 'description',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name',
  /** column name */
  PublicKey = 'public_key',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  UserId = 'user_id'
}

/** input type for updating data in table "user_passkeys" */
export type User_Passkeys_Set_Input = {
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  credential_id?: InputMaybe<Scalars['bytea']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  public_key?: InputMaybe<Scalars['bytea']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** Streaming cursor of the table "user_passkeys" */
export type User_Passkeys_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: User_Passkeys_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type User_Passkeys_Stream_Cursor_Value_Input = {
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  credential_id?: InputMaybe<Scalars['bytea']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  public_key?: InputMaybe<Scalars['bytea']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** update columns of table "user_passkeys" */
export enum User_Passkeys_Update_Column {
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  CredentialId = 'credential_id',
  /** column name */
  Description = 'description',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name',
  /** column name */
  PublicKey = 'public_key',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  UserId = 'user_id'
}

export type User_Passkeys_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<User_Passkeys_Set_Input>;
  /** filter the rows which have to be updated */
  where: User_Passkeys_Bool_Exp;
};

/** columns and relationships of "user_tokens" */
export type User_Tokens = {
  __typename?: 'user_tokens';
  client: Scalars['String']['output'];
  created_at: Scalars['timestamptz']['output'];
  description?: Maybe<Scalars['String']['output']>;
  expires_at?: Maybe<Scalars['timestamptz']['output']>;
  id: Scalars['uuid']['output'];
  token: Scalars['String']['output'];
  type: Scalars['String']['output'];
  updated_at: Scalars['timestamptz']['output'];
  used: Scalars['Boolean']['output'];
  /** An object relationship */
  user: Users;
  user_id: Scalars['uuid']['output'];
};

/** aggregated selection of "user_tokens" */
export type User_Tokens_Aggregate = {
  __typename?: 'user_tokens_aggregate';
  aggregate?: Maybe<User_Tokens_Aggregate_Fields>;
  nodes: Array<User_Tokens>;
};

export type User_Tokens_Aggregate_Bool_Exp = {
  bool_and?: InputMaybe<User_Tokens_Aggregate_Bool_Exp_Bool_And>;
  bool_or?: InputMaybe<User_Tokens_Aggregate_Bool_Exp_Bool_Or>;
  count?: InputMaybe<User_Tokens_Aggregate_Bool_Exp_Count>;
};

export type User_Tokens_Aggregate_Bool_Exp_Bool_And = {
  arguments: User_Tokens_Select_Column_User_Tokens_Aggregate_Bool_Exp_Bool_And_Arguments_Columns;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<User_Tokens_Bool_Exp>;
  predicate: Boolean_Comparison_Exp;
};

export type User_Tokens_Aggregate_Bool_Exp_Bool_Or = {
  arguments: User_Tokens_Select_Column_User_Tokens_Aggregate_Bool_Exp_Bool_Or_Arguments_Columns;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<User_Tokens_Bool_Exp>;
  predicate: Boolean_Comparison_Exp;
};

export type User_Tokens_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<User_Tokens_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<User_Tokens_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "user_tokens" */
export type User_Tokens_Aggregate_Fields = {
  __typename?: 'user_tokens_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<User_Tokens_Max_Fields>;
  min?: Maybe<User_Tokens_Min_Fields>;
};


/** aggregate fields of "user_tokens" */
export type User_Tokens_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<User_Tokens_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "user_tokens" */
export type User_Tokens_Aggregate_Order_By = {
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<User_Tokens_Max_Order_By>;
  min?: InputMaybe<User_Tokens_Min_Order_By>;
};

/** input type for inserting array relation for remote table "user_tokens" */
export type User_Tokens_Arr_Rel_Insert_Input = {
  data: Array<User_Tokens_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<User_Tokens_On_Conflict>;
};

/** Boolean expression to filter rows from the table "user_tokens". All fields are combined with a logical 'AND'. */
export type User_Tokens_Bool_Exp = {
  _and?: InputMaybe<Array<User_Tokens_Bool_Exp>>;
  _not?: InputMaybe<User_Tokens_Bool_Exp>;
  _or?: InputMaybe<Array<User_Tokens_Bool_Exp>>;
  client?: InputMaybe<String_Comparison_Exp>;
  created_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  description?: InputMaybe<String_Comparison_Exp>;
  expires_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  token?: InputMaybe<String_Comparison_Exp>;
  type?: InputMaybe<String_Comparison_Exp>;
  updated_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  used?: InputMaybe<Boolean_Comparison_Exp>;
  user?: InputMaybe<Users_Bool_Exp>;
  user_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "user_tokens" */
export enum User_Tokens_Constraint {
  /** unique or primary key constraint on columns "id" */
  UserTokensPkey = 'user_tokens_pkey'
}

/** input type for inserting data into table "user_tokens" */
export type User_Tokens_Insert_Input = {
  client?: InputMaybe<Scalars['String']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  expires_at?: InputMaybe<Scalars['timestamptz']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  token?: InputMaybe<Scalars['String']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  used?: InputMaybe<Scalars['Boolean']['input']>;
  user?: InputMaybe<Users_Obj_Rel_Insert_Input>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type User_Tokens_Max_Fields = {
  __typename?: 'user_tokens_max_fields';
  client?: Maybe<Scalars['String']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  description?: Maybe<Scalars['String']['output']>;
  expires_at?: Maybe<Scalars['timestamptz']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  token?: Maybe<Scalars['String']['output']>;
  type?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "user_tokens" */
export type User_Tokens_Max_Order_By = {
  client?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  description?: InputMaybe<Order_By>;
  expires_at?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  token?: InputMaybe<Order_By>;
  type?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type User_Tokens_Min_Fields = {
  __typename?: 'user_tokens_min_fields';
  client?: Maybe<Scalars['String']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  description?: Maybe<Scalars['String']['output']>;
  expires_at?: Maybe<Scalars['timestamptz']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  token?: Maybe<Scalars['String']['output']>;
  type?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "user_tokens" */
export type User_Tokens_Min_Order_By = {
  client?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  description?: InputMaybe<Order_By>;
  expires_at?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  token?: InputMaybe<Order_By>;
  type?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "user_tokens" */
export type User_Tokens_Mutation_Response = {
  __typename?: 'user_tokens_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<User_Tokens>;
};

/** on_conflict condition type for table "user_tokens" */
export type User_Tokens_On_Conflict = {
  constraint: User_Tokens_Constraint;
  update_columns?: Array<User_Tokens_Update_Column>;
  where?: InputMaybe<User_Tokens_Bool_Exp>;
};

/** Ordering options when selecting data from "user_tokens". */
export type User_Tokens_Order_By = {
  client?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  description?: InputMaybe<Order_By>;
  expires_at?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  token?: InputMaybe<Order_By>;
  type?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  used?: InputMaybe<Order_By>;
  user?: InputMaybe<Users_Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: user_tokens */
export type User_Tokens_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "user_tokens" */
export enum User_Tokens_Select_Column {
  /** column name */
  Client = 'client',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  Description = 'description',
  /** column name */
  ExpiresAt = 'expires_at',
  /** column name */
  Id = 'id',
  /** column name */
  Token = 'token',
  /** column name */
  Type = 'type',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Used = 'used',
  /** column name */
  UserId = 'user_id'
}

/** select "user_tokens_aggregate_bool_exp_bool_and_arguments_columns" columns of table "user_tokens" */
export enum User_Tokens_Select_Column_User_Tokens_Aggregate_Bool_Exp_Bool_And_Arguments_Columns {
  /** column name */
  Used = 'used'
}

/** select "user_tokens_aggregate_bool_exp_bool_or_arguments_columns" columns of table "user_tokens" */
export enum User_Tokens_Select_Column_User_Tokens_Aggregate_Bool_Exp_Bool_Or_Arguments_Columns {
  /** column name */
  Used = 'used'
}

/** input type for updating data in table "user_tokens" */
export type User_Tokens_Set_Input = {
  client?: InputMaybe<Scalars['String']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  expires_at?: InputMaybe<Scalars['timestamptz']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  token?: InputMaybe<Scalars['String']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  used?: InputMaybe<Scalars['Boolean']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** Streaming cursor of the table "user_tokens" */
export type User_Tokens_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: User_Tokens_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type User_Tokens_Stream_Cursor_Value_Input = {
  client?: InputMaybe<Scalars['String']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  expires_at?: InputMaybe<Scalars['timestamptz']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  token?: InputMaybe<Scalars['String']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  used?: InputMaybe<Scalars['Boolean']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** update columns of table "user_tokens" */
export enum User_Tokens_Update_Column {
  /** column name */
  Client = 'client',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  Description = 'description',
  /** column name */
  ExpiresAt = 'expires_at',
  /** column name */
  Id = 'id',
  /** column name */
  Token = 'token',
  /** column name */
  Type = 'type',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Used = 'used',
  /** column name */
  UserId = 'user_id'
}

export type User_Tokens_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<User_Tokens_Set_Input>;
  /** filter the rows which have to be updated */
  where: User_Tokens_Bool_Exp;
};

/** columns and relationships of "users" */
export type Users = {
  __typename?: 'users';
  apple_id?: Maybe<Scalars['String']['output']>;
  avatar?: Maybe<Scalars['String']['output']>;
  /** An object relationship */
  city?: Maybe<Cities>;
  city_id?: Maybe<Scalars['uuid']['output']>;
  /** An array relationship */
  contributions: Array<Contributions>;
  /** An aggregate relationship */
  contributions_aggregate: Contributions_Aggregate;
  created_at: Scalars['timestamptz']['output'];
  date_joined: Scalars['timestamptz']['output'];
  email: Scalars['String']['output'];
  email_verified: Scalars['Boolean']['output'];
  first_name?: Maybe<Scalars['String']['output']>;
  google_id?: Maybe<Scalars['String']['output']>;
  /** An array relationship */
  groups: Array<Users_Groups>;
  /** An aggregate relationship */
  groups_aggregate: Users_Groups_Aggregate;
  has_contributed: Scalars['Boolean']['output'];
  id: Scalars['uuid']['output'];
  is_active: Scalars['Boolean']['output'];
  is_staff: Scalars['Boolean']['output'];
  is_superuser: Scalars['Boolean']['output'];
  last_login?: Maybe<Scalars['timestamptz']['output']>;
  last_name?: Maybe<Scalars['String']['output']>;
  /** An array relationship */
  passkeys: Array<User_Passkeys>;
  /** An aggregate relationship */
  passkeys_aggregate: User_Passkeys_Aggregate;
  password: Scalars['String']['output'];
  /** An array relationship */
  permissions: Array<Users_User_Permissions>;
  /** An aggregate relationship */
  permissions_aggregate: Users_User_Permissions_Aggregate;
  /** An array relationship */
  tokens: Array<User_Tokens>;
  /** An aggregate relationship */
  tokens_aggregate: User_Tokens_Aggregate;
  updated_at: Scalars['timestamptz']['output'];
  username: Scalars['String']['output'];
  /** An array relationship */
  votes: Array<Votes>;
  /** An aggregate relationship */
  votes_aggregate: Votes_Aggregate;
};


/** columns and relationships of "users" */
export type UsersContributionsArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersContributions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersGroupsArgs = {
  distinct_on?: InputMaybe<Array<Users_Groups_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Groups_Order_By>>;
  where?: InputMaybe<Users_Groups_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersGroups_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Users_Groups_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_Groups_Order_By>>;
  where?: InputMaybe<Users_Groups_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersPasskeysArgs = {
  distinct_on?: InputMaybe<Array<User_Passkeys_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Passkeys_Order_By>>;
  where?: InputMaybe<User_Passkeys_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersPasskeys_AggregateArgs = {
  distinct_on?: InputMaybe<Array<User_Passkeys_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Passkeys_Order_By>>;
  where?: InputMaybe<User_Passkeys_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersPermissionsArgs = {
  distinct_on?: InputMaybe<Array<Users_User_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_User_Permissions_Order_By>>;
  where?: InputMaybe<Users_User_Permissions_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersPermissions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Users_User_Permissions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Users_User_Permissions_Order_By>>;
  where?: InputMaybe<Users_User_Permissions_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersTokensArgs = {
  distinct_on?: InputMaybe<Array<User_Tokens_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Tokens_Order_By>>;
  where?: InputMaybe<User_Tokens_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersTokens_AggregateArgs = {
  distinct_on?: InputMaybe<Array<User_Tokens_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<User_Tokens_Order_By>>;
  where?: InputMaybe<User_Tokens_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersVotesArgs = {
  distinct_on?: InputMaybe<Array<Votes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Votes_Order_By>>;
  where?: InputMaybe<Votes_Bool_Exp>;
};


/** columns and relationships of "users" */
export type UsersVotes_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Votes_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Votes_Order_By>>;
  where?: InputMaybe<Votes_Bool_Exp>;
};

/** aggregated selection of "users" */
export type Users_Aggregate = {
  __typename?: 'users_aggregate';
  aggregate?: Maybe<Users_Aggregate_Fields>;
  nodes: Array<Users>;
};

/** aggregate fields of "users" */
export type Users_Aggregate_Fields = {
  __typename?: 'users_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<Users_Max_Fields>;
  min?: Maybe<Users_Min_Fields>;
};


/** aggregate fields of "users" */
export type Users_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Users_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** Boolean expression to filter rows from the table "users". All fields are combined with a logical 'AND'. */
export type Users_Bool_Exp = {
  _and?: InputMaybe<Array<Users_Bool_Exp>>;
  _not?: InputMaybe<Users_Bool_Exp>;
  _or?: InputMaybe<Array<Users_Bool_Exp>>;
  apple_id?: InputMaybe<String_Comparison_Exp>;
  avatar?: InputMaybe<String_Comparison_Exp>;
  city?: InputMaybe<Cities_Bool_Exp>;
  city_id?: InputMaybe<Uuid_Comparison_Exp>;
  contributions?: InputMaybe<Contributions_Bool_Exp>;
  contributions_aggregate?: InputMaybe<Contributions_Aggregate_Bool_Exp>;
  created_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  date_joined?: InputMaybe<Timestamptz_Comparison_Exp>;
  email?: InputMaybe<String_Comparison_Exp>;
  email_verified?: InputMaybe<Boolean_Comparison_Exp>;
  first_name?: InputMaybe<String_Comparison_Exp>;
  google_id?: InputMaybe<String_Comparison_Exp>;
  groups?: InputMaybe<Users_Groups_Bool_Exp>;
  groups_aggregate?: InputMaybe<Users_Groups_Aggregate_Bool_Exp>;
  has_contributed?: InputMaybe<Boolean_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  is_active?: InputMaybe<Boolean_Comparison_Exp>;
  is_staff?: InputMaybe<Boolean_Comparison_Exp>;
  is_superuser?: InputMaybe<Boolean_Comparison_Exp>;
  last_login?: InputMaybe<Timestamptz_Comparison_Exp>;
  last_name?: InputMaybe<String_Comparison_Exp>;
  passkeys?: InputMaybe<User_Passkeys_Bool_Exp>;
  passkeys_aggregate?: InputMaybe<User_Passkeys_Aggregate_Bool_Exp>;
  password?: InputMaybe<String_Comparison_Exp>;
  permissions?: InputMaybe<Users_User_Permissions_Bool_Exp>;
  permissions_aggregate?: InputMaybe<Users_User_Permissions_Aggregate_Bool_Exp>;
  tokens?: InputMaybe<User_Tokens_Bool_Exp>;
  tokens_aggregate?: InputMaybe<User_Tokens_Aggregate_Bool_Exp>;
  updated_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  username?: InputMaybe<String_Comparison_Exp>;
  votes?: InputMaybe<Votes_Bool_Exp>;
  votes_aggregate?: InputMaybe<Votes_Aggregate_Bool_Exp>;
};

/** unique or primary key constraints on table "users" */
export enum Users_Constraint {
  /** unique or primary key constraint on columns "apple_id" */
  UsersAppleIdKey = 'users_apple_id_key',
  /** unique or primary key constraint on columns "email" */
  UsersEmailKey = 'users_email_key',
  /** unique or primary key constraint on columns "google_id" */
  UsersGoogleIdKey = 'users_google_id_key',
  /** unique or primary key constraint on columns "id" */
  UsersPkey = 'users_pkey',
  /** unique or primary key constraint on columns "username" */
  UsersUsernameKey = 'users_username_key'
}

/** columns and relationships of "users_groups" */
export type Users_Groups = {
  __typename?: 'users_groups';
  group_id: Scalars['Int']['output'];
  id: Scalars['bigint']['output'];
  user_id: Scalars['uuid']['output'];
};

/** aggregated selection of "users_groups" */
export type Users_Groups_Aggregate = {
  __typename?: 'users_groups_aggregate';
  aggregate?: Maybe<Users_Groups_Aggregate_Fields>;
  nodes: Array<Users_Groups>;
};

export type Users_Groups_Aggregate_Bool_Exp = {
  count?: InputMaybe<Users_Groups_Aggregate_Bool_Exp_Count>;
};

export type Users_Groups_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Users_Groups_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Users_Groups_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "users_groups" */
export type Users_Groups_Aggregate_Fields = {
  __typename?: 'users_groups_aggregate_fields';
  avg?: Maybe<Users_Groups_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Users_Groups_Max_Fields>;
  min?: Maybe<Users_Groups_Min_Fields>;
  stddev?: Maybe<Users_Groups_Stddev_Fields>;
  stddev_pop?: Maybe<Users_Groups_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Users_Groups_Stddev_Samp_Fields>;
  sum?: Maybe<Users_Groups_Sum_Fields>;
  var_pop?: Maybe<Users_Groups_Var_Pop_Fields>;
  var_samp?: Maybe<Users_Groups_Var_Samp_Fields>;
  variance?: Maybe<Users_Groups_Variance_Fields>;
};


/** aggregate fields of "users_groups" */
export type Users_Groups_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Users_Groups_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "users_groups" */
export type Users_Groups_Aggregate_Order_By = {
  avg?: InputMaybe<Users_Groups_Avg_Order_By>;
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Users_Groups_Max_Order_By>;
  min?: InputMaybe<Users_Groups_Min_Order_By>;
  stddev?: InputMaybe<Users_Groups_Stddev_Order_By>;
  stddev_pop?: InputMaybe<Users_Groups_Stddev_Pop_Order_By>;
  stddev_samp?: InputMaybe<Users_Groups_Stddev_Samp_Order_By>;
  sum?: InputMaybe<Users_Groups_Sum_Order_By>;
  var_pop?: InputMaybe<Users_Groups_Var_Pop_Order_By>;
  var_samp?: InputMaybe<Users_Groups_Var_Samp_Order_By>;
  variance?: InputMaybe<Users_Groups_Variance_Order_By>;
};

/** input type for inserting array relation for remote table "users_groups" */
export type Users_Groups_Arr_Rel_Insert_Input = {
  data: Array<Users_Groups_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Users_Groups_On_Conflict>;
};

/** aggregate avg on columns */
export type Users_Groups_Avg_Fields = {
  __typename?: 'users_groups_avg_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by avg() on columns of table "users_groups" */
export type Users_Groups_Avg_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** Boolean expression to filter rows from the table "users_groups". All fields are combined with a logical 'AND'. */
export type Users_Groups_Bool_Exp = {
  _and?: InputMaybe<Array<Users_Groups_Bool_Exp>>;
  _not?: InputMaybe<Users_Groups_Bool_Exp>;
  _or?: InputMaybe<Array<Users_Groups_Bool_Exp>>;
  group_id?: InputMaybe<Int_Comparison_Exp>;
  id?: InputMaybe<Bigint_Comparison_Exp>;
  user_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "users_groups" */
export enum Users_Groups_Constraint {
  /** unique or primary key constraint on columns "id" */
  UsersGroupsPkey = 'users_groups_pkey',
  /** unique or primary key constraint on columns "user_id", "group_id" */
  UsersGroupsUserIdGroupIdFc7788e8Uniq = 'users_groups_user_id_group_id_fc7788e8_uniq'
}

/** input type for incrementing numeric columns in table "users_groups" */
export type Users_Groups_Inc_Input = {
  group_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
};

/** input type for inserting data into table "users_groups" */
export type Users_Groups_Insert_Input = {
  group_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Users_Groups_Max_Fields = {
  __typename?: 'users_groups_max_fields';
  group_id?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "users_groups" */
export type Users_Groups_Max_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Users_Groups_Min_Fields = {
  __typename?: 'users_groups_min_fields';
  group_id?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "users_groups" */
export type Users_Groups_Min_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "users_groups" */
export type Users_Groups_Mutation_Response = {
  __typename?: 'users_groups_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Users_Groups>;
};

/** on_conflict condition type for table "users_groups" */
export type Users_Groups_On_Conflict = {
  constraint: Users_Groups_Constraint;
  update_columns?: Array<Users_Groups_Update_Column>;
  where?: InputMaybe<Users_Groups_Bool_Exp>;
};

/** Ordering options when selecting data from "users_groups". */
export type Users_Groups_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: users_groups */
export type Users_Groups_Pk_Columns_Input = {
  id: Scalars['bigint']['input'];
};

/** select columns of table "users_groups" */
export enum Users_Groups_Select_Column {
  /** column name */
  GroupId = 'group_id',
  /** column name */
  Id = 'id',
  /** column name */
  UserId = 'user_id'
}

/** input type for updating data in table "users_groups" */
export type Users_Groups_Set_Input = {
  group_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate stddev on columns */
export type Users_Groups_Stddev_Fields = {
  __typename?: 'users_groups_stddev_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev() on columns of table "users_groups" */
export type Users_Groups_Stddev_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** aggregate stddev_pop on columns */
export type Users_Groups_Stddev_Pop_Fields = {
  __typename?: 'users_groups_stddev_pop_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_pop() on columns of table "users_groups" */
export type Users_Groups_Stddev_Pop_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** aggregate stddev_samp on columns */
export type Users_Groups_Stddev_Samp_Fields = {
  __typename?: 'users_groups_stddev_samp_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_samp() on columns of table "users_groups" */
export type Users_Groups_Stddev_Samp_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** Streaming cursor of the table "users_groups" */
export type Users_Groups_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Users_Groups_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Users_Groups_Stream_Cursor_Value_Input = {
  group_id?: InputMaybe<Scalars['Int']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate sum on columns */
export type Users_Groups_Sum_Fields = {
  __typename?: 'users_groups_sum_fields';
  group_id?: Maybe<Scalars['Int']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
};

/** order by sum() on columns of table "users_groups" */
export type Users_Groups_Sum_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** update columns of table "users_groups" */
export enum Users_Groups_Update_Column {
  /** column name */
  GroupId = 'group_id',
  /** column name */
  Id = 'id',
  /** column name */
  UserId = 'user_id'
}

export type Users_Groups_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Users_Groups_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Users_Groups_Set_Input>;
  /** filter the rows which have to be updated */
  where: Users_Groups_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Users_Groups_Var_Pop_Fields = {
  __typename?: 'users_groups_var_pop_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_pop() on columns of table "users_groups" */
export type Users_Groups_Var_Pop_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** aggregate var_samp on columns */
export type Users_Groups_Var_Samp_Fields = {
  __typename?: 'users_groups_var_samp_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_samp() on columns of table "users_groups" */
export type Users_Groups_Var_Samp_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** aggregate variance on columns */
export type Users_Groups_Variance_Fields = {
  __typename?: 'users_groups_variance_fields';
  group_id?: Maybe<Scalars['Float']['output']>;
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by variance() on columns of table "users_groups" */
export type Users_Groups_Variance_Order_By = {
  group_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
};

/** input type for inserting data into table "users" */
export type Users_Insert_Input = {
  apple_id?: InputMaybe<Scalars['String']['input']>;
  avatar?: InputMaybe<Scalars['String']['input']>;
  city?: InputMaybe<Cities_Obj_Rel_Insert_Input>;
  city_id?: InputMaybe<Scalars['uuid']['input']>;
  contributions?: InputMaybe<Contributions_Arr_Rel_Insert_Input>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  date_joined?: InputMaybe<Scalars['timestamptz']['input']>;
  email?: InputMaybe<Scalars['String']['input']>;
  email_verified?: InputMaybe<Scalars['Boolean']['input']>;
  first_name?: InputMaybe<Scalars['String']['input']>;
  google_id?: InputMaybe<Scalars['String']['input']>;
  groups?: InputMaybe<Users_Groups_Arr_Rel_Insert_Input>;
  has_contributed?: InputMaybe<Scalars['Boolean']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  is_active?: InputMaybe<Scalars['Boolean']['input']>;
  is_staff?: InputMaybe<Scalars['Boolean']['input']>;
  is_superuser?: InputMaybe<Scalars['Boolean']['input']>;
  last_login?: InputMaybe<Scalars['timestamptz']['input']>;
  last_name?: InputMaybe<Scalars['String']['input']>;
  passkeys?: InputMaybe<User_Passkeys_Arr_Rel_Insert_Input>;
  password?: InputMaybe<Scalars['String']['input']>;
  permissions?: InputMaybe<Users_User_Permissions_Arr_Rel_Insert_Input>;
  tokens?: InputMaybe<User_Tokens_Arr_Rel_Insert_Input>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  username?: InputMaybe<Scalars['String']['input']>;
  votes?: InputMaybe<Votes_Arr_Rel_Insert_Input>;
};

/** aggregate max on columns */
export type Users_Max_Fields = {
  __typename?: 'users_max_fields';
  apple_id?: Maybe<Scalars['String']['output']>;
  avatar?: Maybe<Scalars['String']['output']>;
  city_id?: Maybe<Scalars['uuid']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  date_joined?: Maybe<Scalars['timestamptz']['output']>;
  email?: Maybe<Scalars['String']['output']>;
  first_name?: Maybe<Scalars['String']['output']>;
  google_id?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  last_login?: Maybe<Scalars['timestamptz']['output']>;
  last_name?: Maybe<Scalars['String']['output']>;
  password?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  username?: Maybe<Scalars['String']['output']>;
};

/** aggregate min on columns */
export type Users_Min_Fields = {
  __typename?: 'users_min_fields';
  apple_id?: Maybe<Scalars['String']['output']>;
  avatar?: Maybe<Scalars['String']['output']>;
  city_id?: Maybe<Scalars['uuid']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  date_joined?: Maybe<Scalars['timestamptz']['output']>;
  email?: Maybe<Scalars['String']['output']>;
  first_name?: Maybe<Scalars['String']['output']>;
  google_id?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  last_login?: Maybe<Scalars['timestamptz']['output']>;
  last_name?: Maybe<Scalars['String']['output']>;
  password?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  username?: Maybe<Scalars['String']['output']>;
};

/** response of any mutation on the table "users" */
export type Users_Mutation_Response = {
  __typename?: 'users_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Users>;
};

/** input type for inserting object relation for remote table "users" */
export type Users_Obj_Rel_Insert_Input = {
  data: Users_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Users_On_Conflict>;
};

/** on_conflict condition type for table "users" */
export type Users_On_Conflict = {
  constraint: Users_Constraint;
  update_columns?: Array<Users_Update_Column>;
  where?: InputMaybe<Users_Bool_Exp>;
};

/** Ordering options when selecting data from "users". */
export type Users_Order_By = {
  apple_id?: InputMaybe<Order_By>;
  avatar?: InputMaybe<Order_By>;
  city?: InputMaybe<Cities_Order_By>;
  city_id?: InputMaybe<Order_By>;
  contributions_aggregate?: InputMaybe<Contributions_Aggregate_Order_By>;
  created_at?: InputMaybe<Order_By>;
  date_joined?: InputMaybe<Order_By>;
  email?: InputMaybe<Order_By>;
  email_verified?: InputMaybe<Order_By>;
  first_name?: InputMaybe<Order_By>;
  google_id?: InputMaybe<Order_By>;
  groups_aggregate?: InputMaybe<Users_Groups_Aggregate_Order_By>;
  has_contributed?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  is_active?: InputMaybe<Order_By>;
  is_staff?: InputMaybe<Order_By>;
  is_superuser?: InputMaybe<Order_By>;
  last_login?: InputMaybe<Order_By>;
  last_name?: InputMaybe<Order_By>;
  passkeys_aggregate?: InputMaybe<User_Passkeys_Aggregate_Order_By>;
  password?: InputMaybe<Order_By>;
  permissions_aggregate?: InputMaybe<Users_User_Permissions_Aggregate_Order_By>;
  tokens_aggregate?: InputMaybe<User_Tokens_Aggregate_Order_By>;
  updated_at?: InputMaybe<Order_By>;
  username?: InputMaybe<Order_By>;
  votes_aggregate?: InputMaybe<Votes_Aggregate_Order_By>;
};

/** primary key columns input for table: users */
export type Users_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "users" */
export enum Users_Select_Column {
  /** column name */
  AppleId = 'apple_id',
  /** column name */
  Avatar = 'avatar',
  /** column name */
  CityId = 'city_id',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  DateJoined = 'date_joined',
  /** column name */
  Email = 'email',
  /** column name */
  EmailVerified = 'email_verified',
  /** column name */
  FirstName = 'first_name',
  /** column name */
  GoogleId = 'google_id',
  /** column name */
  HasContributed = 'has_contributed',
  /** column name */
  Id = 'id',
  /** column name */
  IsActive = 'is_active',
  /** column name */
  IsStaff = 'is_staff',
  /** column name */
  IsSuperuser = 'is_superuser',
  /** column name */
  LastLogin = 'last_login',
  /** column name */
  LastName = 'last_name',
  /** column name */
  Password = 'password',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Username = 'username'
}

/** input type for updating data in table "users" */
export type Users_Set_Input = {
  apple_id?: InputMaybe<Scalars['String']['input']>;
  avatar?: InputMaybe<Scalars['String']['input']>;
  city_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  date_joined?: InputMaybe<Scalars['timestamptz']['input']>;
  email?: InputMaybe<Scalars['String']['input']>;
  email_verified?: InputMaybe<Scalars['Boolean']['input']>;
  first_name?: InputMaybe<Scalars['String']['input']>;
  google_id?: InputMaybe<Scalars['String']['input']>;
  has_contributed?: InputMaybe<Scalars['Boolean']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  is_active?: InputMaybe<Scalars['Boolean']['input']>;
  is_staff?: InputMaybe<Scalars['Boolean']['input']>;
  is_superuser?: InputMaybe<Scalars['Boolean']['input']>;
  last_login?: InputMaybe<Scalars['timestamptz']['input']>;
  last_name?: InputMaybe<Scalars['String']['input']>;
  password?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  username?: InputMaybe<Scalars['String']['input']>;
};

/** Streaming cursor of the table "users" */
export type Users_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Users_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Users_Stream_Cursor_Value_Input = {
  apple_id?: InputMaybe<Scalars['String']['input']>;
  avatar?: InputMaybe<Scalars['String']['input']>;
  city_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  date_joined?: InputMaybe<Scalars['timestamptz']['input']>;
  email?: InputMaybe<Scalars['String']['input']>;
  email_verified?: InputMaybe<Scalars['Boolean']['input']>;
  first_name?: InputMaybe<Scalars['String']['input']>;
  google_id?: InputMaybe<Scalars['String']['input']>;
  has_contributed?: InputMaybe<Scalars['Boolean']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  is_active?: InputMaybe<Scalars['Boolean']['input']>;
  is_staff?: InputMaybe<Scalars['Boolean']['input']>;
  is_superuser?: InputMaybe<Scalars['Boolean']['input']>;
  last_login?: InputMaybe<Scalars['timestamptz']['input']>;
  last_name?: InputMaybe<Scalars['String']['input']>;
  password?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  username?: InputMaybe<Scalars['String']['input']>;
};

/** update columns of table "users" */
export enum Users_Update_Column {
  /** column name */
  AppleId = 'apple_id',
  /** column name */
  Avatar = 'avatar',
  /** column name */
  CityId = 'city_id',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  DateJoined = 'date_joined',
  /** column name */
  Email = 'email',
  /** column name */
  EmailVerified = 'email_verified',
  /** column name */
  FirstName = 'first_name',
  /** column name */
  GoogleId = 'google_id',
  /** column name */
  HasContributed = 'has_contributed',
  /** column name */
  Id = 'id',
  /** column name */
  IsActive = 'is_active',
  /** column name */
  IsStaff = 'is_staff',
  /** column name */
  IsSuperuser = 'is_superuser',
  /** column name */
  LastLogin = 'last_login',
  /** column name */
  LastName = 'last_name',
  /** column name */
  Password = 'password',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  Username = 'username'
}

export type Users_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Users_Set_Input>;
  /** filter the rows which have to be updated */
  where: Users_Bool_Exp;
};

/** columns and relationships of "users_user_permissions" */
export type Users_User_Permissions = {
  __typename?: 'users_user_permissions';
  id: Scalars['bigint']['output'];
  permission_id: Scalars['Int']['output'];
  user_id: Scalars['uuid']['output'];
};

/** aggregated selection of "users_user_permissions" */
export type Users_User_Permissions_Aggregate = {
  __typename?: 'users_user_permissions_aggregate';
  aggregate?: Maybe<Users_User_Permissions_Aggregate_Fields>;
  nodes: Array<Users_User_Permissions>;
};

export type Users_User_Permissions_Aggregate_Bool_Exp = {
  count?: InputMaybe<Users_User_Permissions_Aggregate_Bool_Exp_Count>;
};

export type Users_User_Permissions_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Users_User_Permissions_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Users_User_Permissions_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "users_user_permissions" */
export type Users_User_Permissions_Aggregate_Fields = {
  __typename?: 'users_user_permissions_aggregate_fields';
  avg?: Maybe<Users_User_Permissions_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Users_User_Permissions_Max_Fields>;
  min?: Maybe<Users_User_Permissions_Min_Fields>;
  stddev?: Maybe<Users_User_Permissions_Stddev_Fields>;
  stddev_pop?: Maybe<Users_User_Permissions_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Users_User_Permissions_Stddev_Samp_Fields>;
  sum?: Maybe<Users_User_Permissions_Sum_Fields>;
  var_pop?: Maybe<Users_User_Permissions_Var_Pop_Fields>;
  var_samp?: Maybe<Users_User_Permissions_Var_Samp_Fields>;
  variance?: Maybe<Users_User_Permissions_Variance_Fields>;
};


/** aggregate fields of "users_user_permissions" */
export type Users_User_Permissions_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Users_User_Permissions_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "users_user_permissions" */
export type Users_User_Permissions_Aggregate_Order_By = {
  avg?: InputMaybe<Users_User_Permissions_Avg_Order_By>;
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Users_User_Permissions_Max_Order_By>;
  min?: InputMaybe<Users_User_Permissions_Min_Order_By>;
  stddev?: InputMaybe<Users_User_Permissions_Stddev_Order_By>;
  stddev_pop?: InputMaybe<Users_User_Permissions_Stddev_Pop_Order_By>;
  stddev_samp?: InputMaybe<Users_User_Permissions_Stddev_Samp_Order_By>;
  sum?: InputMaybe<Users_User_Permissions_Sum_Order_By>;
  var_pop?: InputMaybe<Users_User_Permissions_Var_Pop_Order_By>;
  var_samp?: InputMaybe<Users_User_Permissions_Var_Samp_Order_By>;
  variance?: InputMaybe<Users_User_Permissions_Variance_Order_By>;
};

/** input type for inserting array relation for remote table "users_user_permissions" */
export type Users_User_Permissions_Arr_Rel_Insert_Input = {
  data: Array<Users_User_Permissions_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Users_User_Permissions_On_Conflict>;
};

/** aggregate avg on columns */
export type Users_User_Permissions_Avg_Fields = {
  __typename?: 'users_user_permissions_avg_fields';
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** order by avg() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Avg_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
};

/** Boolean expression to filter rows from the table "users_user_permissions". All fields are combined with a logical 'AND'. */
export type Users_User_Permissions_Bool_Exp = {
  _and?: InputMaybe<Array<Users_User_Permissions_Bool_Exp>>;
  _not?: InputMaybe<Users_User_Permissions_Bool_Exp>;
  _or?: InputMaybe<Array<Users_User_Permissions_Bool_Exp>>;
  id?: InputMaybe<Bigint_Comparison_Exp>;
  permission_id?: InputMaybe<Int_Comparison_Exp>;
  user_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "users_user_permissions" */
export enum Users_User_Permissions_Constraint {
  /** unique or primary key constraint on columns "id" */
  UsersUserPermissionsPkey = 'users_user_permissions_pkey',
  /** unique or primary key constraint on columns "permission_id", "user_id" */
  UsersUserPermissionsUserIdPermissionId_3b86cbdfUniq = 'users_user_permissions_user_id_permission_id_3b86cbdf_uniq'
}

/** input type for incrementing numeric columns in table "users_user_permissions" */
export type Users_User_Permissions_Inc_Input = {
  id?: InputMaybe<Scalars['bigint']['input']>;
  permission_id?: InputMaybe<Scalars['Int']['input']>;
};

/** input type for inserting data into table "users_user_permissions" */
export type Users_User_Permissions_Insert_Input = {
  id?: InputMaybe<Scalars['bigint']['input']>;
  permission_id?: InputMaybe<Scalars['Int']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Users_User_Permissions_Max_Fields = {
  __typename?: 'users_user_permissions_max_fields';
  id?: Maybe<Scalars['bigint']['output']>;
  permission_id?: Maybe<Scalars['Int']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Max_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Users_User_Permissions_Min_Fields = {
  __typename?: 'users_user_permissions_min_fields';
  id?: Maybe<Scalars['bigint']['output']>;
  permission_id?: Maybe<Scalars['Int']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Min_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "users_user_permissions" */
export type Users_User_Permissions_Mutation_Response = {
  __typename?: 'users_user_permissions_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Users_User_Permissions>;
};

/** on_conflict condition type for table "users_user_permissions" */
export type Users_User_Permissions_On_Conflict = {
  constraint: Users_User_Permissions_Constraint;
  update_columns?: Array<Users_User_Permissions_Update_Column>;
  where?: InputMaybe<Users_User_Permissions_Bool_Exp>;
};

/** Ordering options when selecting data from "users_user_permissions". */
export type Users_User_Permissions_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: users_user_permissions */
export type Users_User_Permissions_Pk_Columns_Input = {
  id: Scalars['bigint']['input'];
};

/** select columns of table "users_user_permissions" */
export enum Users_User_Permissions_Select_Column {
  /** column name */
  Id = 'id',
  /** column name */
  PermissionId = 'permission_id',
  /** column name */
  UserId = 'user_id'
}

/** input type for updating data in table "users_user_permissions" */
export type Users_User_Permissions_Set_Input = {
  id?: InputMaybe<Scalars['bigint']['input']>;
  permission_id?: InputMaybe<Scalars['Int']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate stddev on columns */
export type Users_User_Permissions_Stddev_Fields = {
  __typename?: 'users_user_permissions_stddev_fields';
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Stddev_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
};

/** aggregate stddev_pop on columns */
export type Users_User_Permissions_Stddev_Pop_Fields = {
  __typename?: 'users_user_permissions_stddev_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_pop() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Stddev_Pop_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
};

/** aggregate stddev_samp on columns */
export type Users_User_Permissions_Stddev_Samp_Fields = {
  __typename?: 'users_user_permissions_stddev_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_samp() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Stddev_Samp_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
};

/** Streaming cursor of the table "users_user_permissions" */
export type Users_User_Permissions_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Users_User_Permissions_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Users_User_Permissions_Stream_Cursor_Value_Input = {
  id?: InputMaybe<Scalars['bigint']['input']>;
  permission_id?: InputMaybe<Scalars['Int']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate sum on columns */
export type Users_User_Permissions_Sum_Fields = {
  __typename?: 'users_user_permissions_sum_fields';
  id?: Maybe<Scalars['bigint']['output']>;
  permission_id?: Maybe<Scalars['Int']['output']>;
};

/** order by sum() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Sum_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
};

/** update columns of table "users_user_permissions" */
export enum Users_User_Permissions_Update_Column {
  /** column name */
  Id = 'id',
  /** column name */
  PermissionId = 'permission_id',
  /** column name */
  UserId = 'user_id'
}

export type Users_User_Permissions_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Users_User_Permissions_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Users_User_Permissions_Set_Input>;
  /** filter the rows which have to be updated */
  where: Users_User_Permissions_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Users_User_Permissions_Var_Pop_Fields = {
  __typename?: 'users_user_permissions_var_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_pop() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Var_Pop_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
};

/** aggregate var_samp on columns */
export type Users_User_Permissions_Var_Samp_Fields = {
  __typename?: 'users_user_permissions_var_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_samp() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Var_Samp_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
};

/** aggregate variance on columns */
export type Users_User_Permissions_Variance_Fields = {
  __typename?: 'users_user_permissions_variance_fields';
  id?: Maybe<Scalars['Float']['output']>;
  permission_id?: Maybe<Scalars['Float']['output']>;
};

/** order by variance() on columns of table "users_user_permissions" */
export type Users_User_Permissions_Variance_Order_By = {
  id?: InputMaybe<Order_By>;
  permission_id?: InputMaybe<Order_By>;
};

/** Boolean expression to compare columns of type "uuid". All fields are combined with logical 'AND'. */
export type Uuid_Comparison_Exp = {
  _eq?: InputMaybe<Scalars['uuid']['input']>;
  _gt?: InputMaybe<Scalars['uuid']['input']>;
  _gte?: InputMaybe<Scalars['uuid']['input']>;
  _in?: InputMaybe<Array<Scalars['uuid']['input']>>;
  _is_null?: InputMaybe<Scalars['Boolean']['input']>;
  _lt?: InputMaybe<Scalars['uuid']['input']>;
  _lte?: InputMaybe<Scalars['uuid']['input']>;
  _neq?: InputMaybe<Scalars['uuid']['input']>;
  _nin?: InputMaybe<Array<Scalars['uuid']['input']>>;
};

/** columns and relationships of "variant_colors" */
export type Variant_Colors = {
  __typename?: 'variant_colors';
  /** An array relationship */
  attachments: Array<Variant_Colors_Attachments>;
  /** An aggregate relationship */
  attachments_aggregate: Variant_Colors_Attachments_Aggregate;
  /** An array relationship */
  contributions: Array<Contributions>;
  /** An aggregate relationship */
  contributions_aggregate: Contributions_Aggregate;
  hex_code?: Maybe<Scalars['String']['output']>;
  id: Scalars['uuid']['output'];
  name: Scalars['String']['output'];
  /** An object relationship */
  variant: Variants;
  variant_id: Scalars['uuid']['output'];
};


/** columns and relationships of "variant_colors" */
export type Variant_ColorsAttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Attachments_Order_By>>;
  where?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
};


/** columns and relationships of "variant_colors" */
export type Variant_ColorsAttachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Attachments_Order_By>>;
  where?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
};


/** columns and relationships of "variant_colors" */
export type Variant_ColorsContributionsArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


/** columns and relationships of "variant_colors" */
export type Variant_ColorsContributions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};

/** aggregated selection of "variant_colors" */
export type Variant_Colors_Aggregate = {
  __typename?: 'variant_colors_aggregate';
  aggregate?: Maybe<Variant_Colors_Aggregate_Fields>;
  nodes: Array<Variant_Colors>;
};

export type Variant_Colors_Aggregate_Bool_Exp = {
  count?: InputMaybe<Variant_Colors_Aggregate_Bool_Exp_Count>;
};

export type Variant_Colors_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Variant_Colors_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Variant_Colors_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "variant_colors" */
export type Variant_Colors_Aggregate_Fields = {
  __typename?: 'variant_colors_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<Variant_Colors_Max_Fields>;
  min?: Maybe<Variant_Colors_Min_Fields>;
};


/** aggregate fields of "variant_colors" */
export type Variant_Colors_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Variant_Colors_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "variant_colors" */
export type Variant_Colors_Aggregate_Order_By = {
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Variant_Colors_Max_Order_By>;
  min?: InputMaybe<Variant_Colors_Min_Order_By>;
};

/** input type for inserting array relation for remote table "variant_colors" */
export type Variant_Colors_Arr_Rel_Insert_Input = {
  data: Array<Variant_Colors_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Variant_Colors_On_Conflict>;
};

/** columns and relationships of "variant_colors_attachments" */
export type Variant_Colors_Attachments = {
  __typename?: 'variant_colors_attachments';
  /** An object relationship */
  attachment: Attachments;
  attachment_id: Scalars['uuid']['output'];
  /** An object relationship */
  color: Variant_Colors;
  id: Scalars['bigint']['output'];
  variantcolor_id: Scalars['uuid']['output'];
};

/** aggregated selection of "variant_colors_attachments" */
export type Variant_Colors_Attachments_Aggregate = {
  __typename?: 'variant_colors_attachments_aggregate';
  aggregate?: Maybe<Variant_Colors_Attachments_Aggregate_Fields>;
  nodes: Array<Variant_Colors_Attachments>;
};

export type Variant_Colors_Attachments_Aggregate_Bool_Exp = {
  count?: InputMaybe<Variant_Colors_Attachments_Aggregate_Bool_Exp_Count>;
};

export type Variant_Colors_Attachments_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Variant_Colors_Attachments_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "variant_colors_attachments" */
export type Variant_Colors_Attachments_Aggregate_Fields = {
  __typename?: 'variant_colors_attachments_aggregate_fields';
  avg?: Maybe<Variant_Colors_Attachments_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Variant_Colors_Attachments_Max_Fields>;
  min?: Maybe<Variant_Colors_Attachments_Min_Fields>;
  stddev?: Maybe<Variant_Colors_Attachments_Stddev_Fields>;
  stddev_pop?: Maybe<Variant_Colors_Attachments_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Variant_Colors_Attachments_Stddev_Samp_Fields>;
  sum?: Maybe<Variant_Colors_Attachments_Sum_Fields>;
  var_pop?: Maybe<Variant_Colors_Attachments_Var_Pop_Fields>;
  var_samp?: Maybe<Variant_Colors_Attachments_Var_Samp_Fields>;
  variance?: Maybe<Variant_Colors_Attachments_Variance_Fields>;
};


/** aggregate fields of "variant_colors_attachments" */
export type Variant_Colors_Attachments_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Variant_Colors_Attachments_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Aggregate_Order_By = {
  avg?: InputMaybe<Variant_Colors_Attachments_Avg_Order_By>;
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Variant_Colors_Attachments_Max_Order_By>;
  min?: InputMaybe<Variant_Colors_Attachments_Min_Order_By>;
  stddev?: InputMaybe<Variant_Colors_Attachments_Stddev_Order_By>;
  stddev_pop?: InputMaybe<Variant_Colors_Attachments_Stddev_Pop_Order_By>;
  stddev_samp?: InputMaybe<Variant_Colors_Attachments_Stddev_Samp_Order_By>;
  sum?: InputMaybe<Variant_Colors_Attachments_Sum_Order_By>;
  var_pop?: InputMaybe<Variant_Colors_Attachments_Var_Pop_Order_By>;
  var_samp?: InputMaybe<Variant_Colors_Attachments_Var_Samp_Order_By>;
  variance?: InputMaybe<Variant_Colors_Attachments_Variance_Order_By>;
};

/** input type for inserting array relation for remote table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Arr_Rel_Insert_Input = {
  data: Array<Variant_Colors_Attachments_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Variant_Colors_Attachments_On_Conflict>;
};

/** aggregate avg on columns */
export type Variant_Colors_Attachments_Avg_Fields = {
  __typename?: 'variant_colors_attachments_avg_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by avg() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Avg_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** Boolean expression to filter rows from the table "variant_colors_attachments". All fields are combined with a logical 'AND'. */
export type Variant_Colors_Attachments_Bool_Exp = {
  _and?: InputMaybe<Array<Variant_Colors_Attachments_Bool_Exp>>;
  _not?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
  _or?: InputMaybe<Array<Variant_Colors_Attachments_Bool_Exp>>;
  attachment?: InputMaybe<Attachments_Bool_Exp>;
  attachment_id?: InputMaybe<Uuid_Comparison_Exp>;
  color?: InputMaybe<Variant_Colors_Bool_Exp>;
  id?: InputMaybe<Bigint_Comparison_Exp>;
  variantcolor_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "variant_colors_attachments" */
export enum Variant_Colors_Attachments_Constraint {
  /** unique or primary key constraint on columns "attachment_id", "variantcolor_id" */
  VariantColorsAttachmenVariantcolorIdAttachmeF246b268Uniq = 'variant_colors_attachmen_variantcolor_id_attachme_f246b268_uniq',
  /** unique or primary key constraint on columns "id" */
  VariantColorsAttachmentsPkey = 'variant_colors_attachments_pkey'
}

/** input type for incrementing numeric columns in table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Inc_Input = {
  id?: InputMaybe<Scalars['bigint']['input']>;
};

/** input type for inserting data into table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Insert_Input = {
  attachment?: InputMaybe<Attachments_Obj_Rel_Insert_Input>;
  attachment_id?: InputMaybe<Scalars['uuid']['input']>;
  color?: InputMaybe<Variant_Colors_Obj_Rel_Insert_Input>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  variantcolor_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Variant_Colors_Attachments_Max_Fields = {
  __typename?: 'variant_colors_attachments_max_fields';
  attachment_id?: Maybe<Scalars['uuid']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
  variantcolor_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Max_Order_By = {
  attachment_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  variantcolor_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Variant_Colors_Attachments_Min_Fields = {
  __typename?: 'variant_colors_attachments_min_fields';
  attachment_id?: Maybe<Scalars['uuid']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
  variantcolor_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Min_Order_By = {
  attachment_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  variantcolor_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Mutation_Response = {
  __typename?: 'variant_colors_attachments_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Variant_Colors_Attachments>;
};

/** on_conflict condition type for table "variant_colors_attachments" */
export type Variant_Colors_Attachments_On_Conflict = {
  constraint: Variant_Colors_Attachments_Constraint;
  update_columns?: Array<Variant_Colors_Attachments_Update_Column>;
  where?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
};

/** Ordering options when selecting data from "variant_colors_attachments". */
export type Variant_Colors_Attachments_Order_By = {
  attachment?: InputMaybe<Attachments_Order_By>;
  attachment_id?: InputMaybe<Order_By>;
  color?: InputMaybe<Variant_Colors_Order_By>;
  id?: InputMaybe<Order_By>;
  variantcolor_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: variant_colors_attachments */
export type Variant_Colors_Attachments_Pk_Columns_Input = {
  id: Scalars['bigint']['input'];
};

/** select columns of table "variant_colors_attachments" */
export enum Variant_Colors_Attachments_Select_Column {
  /** column name */
  AttachmentId = 'attachment_id',
  /** column name */
  Id = 'id',
  /** column name */
  VariantcolorId = 'variantcolor_id'
}

/** input type for updating data in table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Set_Input = {
  attachment_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  variantcolor_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate stddev on columns */
export type Variant_Colors_Attachments_Stddev_Fields = {
  __typename?: 'variant_colors_attachments_stddev_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Stddev_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate stddev_pop on columns */
export type Variant_Colors_Attachments_Stddev_Pop_Fields = {
  __typename?: 'variant_colors_attachments_stddev_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_pop() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Stddev_Pop_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate stddev_samp on columns */
export type Variant_Colors_Attachments_Stddev_Samp_Fields = {
  __typename?: 'variant_colors_attachments_stddev_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_samp() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Stddev_Samp_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** Streaming cursor of the table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Variant_Colors_Attachments_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Variant_Colors_Attachments_Stream_Cursor_Value_Input = {
  attachment_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  variantcolor_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate sum on columns */
export type Variant_Colors_Attachments_Sum_Fields = {
  __typename?: 'variant_colors_attachments_sum_fields';
  id?: Maybe<Scalars['bigint']['output']>;
};

/** order by sum() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Sum_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** update columns of table "variant_colors_attachments" */
export enum Variant_Colors_Attachments_Update_Column {
  /** column name */
  AttachmentId = 'attachment_id',
  /** column name */
  Id = 'id',
  /** column name */
  VariantcolorId = 'variantcolor_id'
}

export type Variant_Colors_Attachments_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Variant_Colors_Attachments_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Variant_Colors_Attachments_Set_Input>;
  /** filter the rows which have to be updated */
  where: Variant_Colors_Attachments_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Variant_Colors_Attachments_Var_Pop_Fields = {
  __typename?: 'variant_colors_attachments_var_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_pop() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Var_Pop_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate var_samp on columns */
export type Variant_Colors_Attachments_Var_Samp_Fields = {
  __typename?: 'variant_colors_attachments_var_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_samp() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Var_Samp_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate variance on columns */
export type Variant_Colors_Attachments_Variance_Fields = {
  __typename?: 'variant_colors_attachments_variance_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by variance() on columns of table "variant_colors_attachments" */
export type Variant_Colors_Attachments_Variance_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** Boolean expression to filter rows from the table "variant_colors". All fields are combined with a logical 'AND'. */
export type Variant_Colors_Bool_Exp = {
  _and?: InputMaybe<Array<Variant_Colors_Bool_Exp>>;
  _not?: InputMaybe<Variant_Colors_Bool_Exp>;
  _or?: InputMaybe<Array<Variant_Colors_Bool_Exp>>;
  attachments?: InputMaybe<Variant_Colors_Attachments_Bool_Exp>;
  attachments_aggregate?: InputMaybe<Variant_Colors_Attachments_Aggregate_Bool_Exp>;
  contributions?: InputMaybe<Contributions_Bool_Exp>;
  contributions_aggregate?: InputMaybe<Contributions_Aggregate_Bool_Exp>;
  hex_code?: InputMaybe<String_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
  variant?: InputMaybe<Variants_Bool_Exp>;
  variant_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "variant_colors" */
export enum Variant_Colors_Constraint {
  /** unique or primary key constraint on columns "id" */
  VariantColorsPkey = 'variant_colors_pkey',
  /** unique or primary key constraint on columns "variant_id", "name" */
  VariantColorsVariantIdName_8b236f25Uniq = 'variant_colors_variant_id_name_8b236f25_uniq'
}

/** input type for inserting data into table "variant_colors" */
export type Variant_Colors_Insert_Input = {
  attachments?: InputMaybe<Variant_Colors_Attachments_Arr_Rel_Insert_Input>;
  contributions?: InputMaybe<Contributions_Arr_Rel_Insert_Input>;
  hex_code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  variant?: InputMaybe<Variants_Obj_Rel_Insert_Input>;
  variant_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Variant_Colors_Max_Fields = {
  __typename?: 'variant_colors_max_fields';
  hex_code?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  variant_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "variant_colors" */
export type Variant_Colors_Max_Order_By = {
  hex_code?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  variant_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Variant_Colors_Min_Fields = {
  __typename?: 'variant_colors_min_fields';
  hex_code?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  variant_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "variant_colors" */
export type Variant_Colors_Min_Order_By = {
  hex_code?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  variant_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "variant_colors" */
export type Variant_Colors_Mutation_Response = {
  __typename?: 'variant_colors_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Variant_Colors>;
};

/** input type for inserting object relation for remote table "variant_colors" */
export type Variant_Colors_Obj_Rel_Insert_Input = {
  data: Variant_Colors_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Variant_Colors_On_Conflict>;
};

/** on_conflict condition type for table "variant_colors" */
export type Variant_Colors_On_Conflict = {
  constraint: Variant_Colors_Constraint;
  update_columns?: Array<Variant_Colors_Update_Column>;
  where?: InputMaybe<Variant_Colors_Bool_Exp>;
};

/** Ordering options when selecting data from "variant_colors". */
export type Variant_Colors_Order_By = {
  attachments_aggregate?: InputMaybe<Variant_Colors_Attachments_Aggregate_Order_By>;
  contributions_aggregate?: InputMaybe<Contributions_Aggregate_Order_By>;
  hex_code?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  variant?: InputMaybe<Variants_Order_By>;
  variant_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: variant_colors */
export type Variant_Colors_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "variant_colors" */
export enum Variant_Colors_Select_Column {
  /** column name */
  HexCode = 'hex_code',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name',
  /** column name */
  VariantId = 'variant_id'
}

/** input type for updating data in table "variant_colors" */
export type Variant_Colors_Set_Input = {
  hex_code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  variant_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** Streaming cursor of the table "variant_colors" */
export type Variant_Colors_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Variant_Colors_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Variant_Colors_Stream_Cursor_Value_Input = {
  hex_code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  variant_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** update columns of table "variant_colors" */
export enum Variant_Colors_Update_Column {
  /** column name */
  HexCode = 'hex_code',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name',
  /** column name */
  VariantId = 'variant_id'
}

export type Variant_Colors_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Variant_Colors_Set_Input>;
  /** filter the rows which have to be updated */
  where: Variant_Colors_Bool_Exp;
};

/** columns and relationships of "variants" */
export type Variants = {
  __typename?: 'variants';
  /** An array relationship */
  attachments: Array<Variants_Attachments>;
  /** An aggregate relationship */
  attachments_aggregate: Variants_Attachments_Aggregate;
  /** An array relationship */
  colors: Array<Variant_Colors>;
  /** An aggregate relationship */
  colors_aggregate: Variant_Colors_Aggregate;
  /** An array relationship */
  contributions: Array<Contributions>;
  /** An aggregate relationship */
  contributions_aggregate: Contributions_Aggregate;
  description: Scalars['String']['output'];
  fuel_type: Scalars['String']['output'];
  id: Scalars['uuid']['output'];
  launch_date: Scalars['date']['output'];
  manufacturer_link?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  short_description?: Maybe<Scalars['String']['output']>;
  slug: Scalars['String']['output'];
  specifications?: Maybe<Scalars['jsonb']['output']>;
  transmission: Scalars['String']['output'];
  /** An object relationship */
  vehicle: Vehicles;
  vehicle_id: Scalars['uuid']['output'];
};


/** columns and relationships of "variants" */
export type VariantsAttachmentsArgs = {
  distinct_on?: InputMaybe<Array<Variants_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Attachments_Order_By>>;
  where?: InputMaybe<Variants_Attachments_Bool_Exp>;
};


/** columns and relationships of "variants" */
export type VariantsAttachments_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variants_Attachments_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Attachments_Order_By>>;
  where?: InputMaybe<Variants_Attachments_Bool_Exp>;
};


/** columns and relationships of "variants" */
export type VariantsColorsArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Order_By>>;
  where?: InputMaybe<Variant_Colors_Bool_Exp>;
};


/** columns and relationships of "variants" */
export type VariantsColors_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variant_Colors_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Order_By>>;
  where?: InputMaybe<Variant_Colors_Bool_Exp>;
};


/** columns and relationships of "variants" */
export type VariantsContributionsArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


/** columns and relationships of "variants" */
export type VariantsContributions_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Contributions_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By>>;
  where?: InputMaybe<Contributions_Bool_Exp>;
};


/** columns and relationships of "variants" */
export type VariantsSpecificationsArgs = {
  path?: InputMaybe<Scalars['String']['input']>;
};

/** aggregated selection of "variants" */
export type Variants_Aggregate = {
  __typename?: 'variants_aggregate';
  aggregate?: Maybe<Variants_Aggregate_Fields>;
  nodes: Array<Variants>;
};

export type Variants_Aggregate_Bool_Exp = {
  count?: InputMaybe<Variants_Aggregate_Bool_Exp_Count>;
};

export type Variants_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Variants_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Variants_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "variants" */
export type Variants_Aggregate_Fields = {
  __typename?: 'variants_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<Variants_Max_Fields>;
  min?: Maybe<Variants_Min_Fields>;
};


/** aggregate fields of "variants" */
export type Variants_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Variants_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "variants" */
export type Variants_Aggregate_Order_By = {
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Variants_Max_Order_By>;
  min?: InputMaybe<Variants_Min_Order_By>;
};

/** append existing jsonb value of filtered columns with new jsonb value */
export type Variants_Append_Input = {
  specifications?: InputMaybe<Scalars['jsonb']['input']>;
};

/** input type for inserting array relation for remote table "variants" */
export type Variants_Arr_Rel_Insert_Input = {
  data: Array<Variants_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Variants_On_Conflict>;
};

/** columns and relationships of "variants_attachments" */
export type Variants_Attachments = {
  __typename?: 'variants_attachments';
  /** An object relationship */
  attachment: Attachments;
  attachment_id: Scalars['uuid']['output'];
  id: Scalars['bigint']['output'];
  /** An object relationship */
  variant: Variants;
  variant_id: Scalars['uuid']['output'];
};

/** aggregated selection of "variants_attachments" */
export type Variants_Attachments_Aggregate = {
  __typename?: 'variants_attachments_aggregate';
  aggregate?: Maybe<Variants_Attachments_Aggregate_Fields>;
  nodes: Array<Variants_Attachments>;
};

export type Variants_Attachments_Aggregate_Bool_Exp = {
  count?: InputMaybe<Variants_Attachments_Aggregate_Bool_Exp_Count>;
};

export type Variants_Attachments_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Variants_Attachments_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Variants_Attachments_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "variants_attachments" */
export type Variants_Attachments_Aggregate_Fields = {
  __typename?: 'variants_attachments_aggregate_fields';
  avg?: Maybe<Variants_Attachments_Avg_Fields>;
  count: Scalars['Int']['output'];
  max?: Maybe<Variants_Attachments_Max_Fields>;
  min?: Maybe<Variants_Attachments_Min_Fields>;
  stddev?: Maybe<Variants_Attachments_Stddev_Fields>;
  stddev_pop?: Maybe<Variants_Attachments_Stddev_Pop_Fields>;
  stddev_samp?: Maybe<Variants_Attachments_Stddev_Samp_Fields>;
  sum?: Maybe<Variants_Attachments_Sum_Fields>;
  var_pop?: Maybe<Variants_Attachments_Var_Pop_Fields>;
  var_samp?: Maybe<Variants_Attachments_Var_Samp_Fields>;
  variance?: Maybe<Variants_Attachments_Variance_Fields>;
};


/** aggregate fields of "variants_attachments" */
export type Variants_Attachments_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Variants_Attachments_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "variants_attachments" */
export type Variants_Attachments_Aggregate_Order_By = {
  avg?: InputMaybe<Variants_Attachments_Avg_Order_By>;
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Variants_Attachments_Max_Order_By>;
  min?: InputMaybe<Variants_Attachments_Min_Order_By>;
  stddev?: InputMaybe<Variants_Attachments_Stddev_Order_By>;
  stddev_pop?: InputMaybe<Variants_Attachments_Stddev_Pop_Order_By>;
  stddev_samp?: InputMaybe<Variants_Attachments_Stddev_Samp_Order_By>;
  sum?: InputMaybe<Variants_Attachments_Sum_Order_By>;
  var_pop?: InputMaybe<Variants_Attachments_Var_Pop_Order_By>;
  var_samp?: InputMaybe<Variants_Attachments_Var_Samp_Order_By>;
  variance?: InputMaybe<Variants_Attachments_Variance_Order_By>;
};

/** input type for inserting array relation for remote table "variants_attachments" */
export type Variants_Attachments_Arr_Rel_Insert_Input = {
  data: Array<Variants_Attachments_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Variants_Attachments_On_Conflict>;
};

/** aggregate avg on columns */
export type Variants_Attachments_Avg_Fields = {
  __typename?: 'variants_attachments_avg_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by avg() on columns of table "variants_attachments" */
export type Variants_Attachments_Avg_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** Boolean expression to filter rows from the table "variants_attachments". All fields are combined with a logical 'AND'. */
export type Variants_Attachments_Bool_Exp = {
  _and?: InputMaybe<Array<Variants_Attachments_Bool_Exp>>;
  _not?: InputMaybe<Variants_Attachments_Bool_Exp>;
  _or?: InputMaybe<Array<Variants_Attachments_Bool_Exp>>;
  attachment?: InputMaybe<Attachments_Bool_Exp>;
  attachment_id?: InputMaybe<Uuid_Comparison_Exp>;
  id?: InputMaybe<Bigint_Comparison_Exp>;
  variant?: InputMaybe<Variants_Bool_Exp>;
  variant_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "variants_attachments" */
export enum Variants_Attachments_Constraint {
  /** unique or primary key constraint on columns "id" */
  VariantsAttachmentsPkey = 'variants_attachments_pkey',
  /** unique or primary key constraint on columns "variant_id", "attachment_id" */
  VariantsAttachmentsVariantIdAttachmentIdFabd455fUniq = 'variants_attachments_variant_id_attachment_id_fabd455f_uniq'
}

/** input type for incrementing numeric columns in table "variants_attachments" */
export type Variants_Attachments_Inc_Input = {
  id?: InputMaybe<Scalars['bigint']['input']>;
};

/** input type for inserting data into table "variants_attachments" */
export type Variants_Attachments_Insert_Input = {
  attachment?: InputMaybe<Attachments_Obj_Rel_Insert_Input>;
  attachment_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  variant?: InputMaybe<Variants_Obj_Rel_Insert_Input>;
  variant_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Variants_Attachments_Max_Fields = {
  __typename?: 'variants_attachments_max_fields';
  attachment_id?: Maybe<Scalars['uuid']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
  variant_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "variants_attachments" */
export type Variants_Attachments_Max_Order_By = {
  attachment_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  variant_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Variants_Attachments_Min_Fields = {
  __typename?: 'variants_attachments_min_fields';
  attachment_id?: Maybe<Scalars['uuid']['output']>;
  id?: Maybe<Scalars['bigint']['output']>;
  variant_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "variants_attachments" */
export type Variants_Attachments_Min_Order_By = {
  attachment_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  variant_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "variants_attachments" */
export type Variants_Attachments_Mutation_Response = {
  __typename?: 'variants_attachments_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Variants_Attachments>;
};

/** on_conflict condition type for table "variants_attachments" */
export type Variants_Attachments_On_Conflict = {
  constraint: Variants_Attachments_Constraint;
  update_columns?: Array<Variants_Attachments_Update_Column>;
  where?: InputMaybe<Variants_Attachments_Bool_Exp>;
};

/** Ordering options when selecting data from "variants_attachments". */
export type Variants_Attachments_Order_By = {
  attachment?: InputMaybe<Attachments_Order_By>;
  attachment_id?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  variant?: InputMaybe<Variants_Order_By>;
  variant_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: variants_attachments */
export type Variants_Attachments_Pk_Columns_Input = {
  id: Scalars['bigint']['input'];
};

/** select columns of table "variants_attachments" */
export enum Variants_Attachments_Select_Column {
  /** column name */
  AttachmentId = 'attachment_id',
  /** column name */
  Id = 'id',
  /** column name */
  VariantId = 'variant_id'
}

/** input type for updating data in table "variants_attachments" */
export type Variants_Attachments_Set_Input = {
  attachment_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  variant_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate stddev on columns */
export type Variants_Attachments_Stddev_Fields = {
  __typename?: 'variants_attachments_stddev_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev() on columns of table "variants_attachments" */
export type Variants_Attachments_Stddev_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate stddev_pop on columns */
export type Variants_Attachments_Stddev_Pop_Fields = {
  __typename?: 'variants_attachments_stddev_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_pop() on columns of table "variants_attachments" */
export type Variants_Attachments_Stddev_Pop_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate stddev_samp on columns */
export type Variants_Attachments_Stddev_Samp_Fields = {
  __typename?: 'variants_attachments_stddev_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by stddev_samp() on columns of table "variants_attachments" */
export type Variants_Attachments_Stddev_Samp_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** Streaming cursor of the table "variants_attachments" */
export type Variants_Attachments_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Variants_Attachments_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Variants_Attachments_Stream_Cursor_Value_Input = {
  attachment_id?: InputMaybe<Scalars['uuid']['input']>;
  id?: InputMaybe<Scalars['bigint']['input']>;
  variant_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate sum on columns */
export type Variants_Attachments_Sum_Fields = {
  __typename?: 'variants_attachments_sum_fields';
  id?: Maybe<Scalars['bigint']['output']>;
};

/** order by sum() on columns of table "variants_attachments" */
export type Variants_Attachments_Sum_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** update columns of table "variants_attachments" */
export enum Variants_Attachments_Update_Column {
  /** column name */
  AttachmentId = 'attachment_id',
  /** column name */
  Id = 'id',
  /** column name */
  VariantId = 'variant_id'
}

export type Variants_Attachments_Updates = {
  /** increments the numeric columns with given value of the filtered values */
  _inc?: InputMaybe<Variants_Attachments_Inc_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Variants_Attachments_Set_Input>;
  /** filter the rows which have to be updated */
  where: Variants_Attachments_Bool_Exp;
};

/** aggregate var_pop on columns */
export type Variants_Attachments_Var_Pop_Fields = {
  __typename?: 'variants_attachments_var_pop_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_pop() on columns of table "variants_attachments" */
export type Variants_Attachments_Var_Pop_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate var_samp on columns */
export type Variants_Attachments_Var_Samp_Fields = {
  __typename?: 'variants_attachments_var_samp_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by var_samp() on columns of table "variants_attachments" */
export type Variants_Attachments_Var_Samp_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** aggregate variance on columns */
export type Variants_Attachments_Variance_Fields = {
  __typename?: 'variants_attachments_variance_fields';
  id?: Maybe<Scalars['Float']['output']>;
};

/** order by variance() on columns of table "variants_attachments" */
export type Variants_Attachments_Variance_Order_By = {
  id?: InputMaybe<Order_By>;
};

/** Boolean expression to filter rows from the table "variants". All fields are combined with a logical 'AND'. */
export type Variants_Bool_Exp = {
  _and?: InputMaybe<Array<Variants_Bool_Exp>>;
  _not?: InputMaybe<Variants_Bool_Exp>;
  _or?: InputMaybe<Array<Variants_Bool_Exp>>;
  attachments?: InputMaybe<Variants_Attachments_Bool_Exp>;
  attachments_aggregate?: InputMaybe<Variants_Attachments_Aggregate_Bool_Exp>;
  colors?: InputMaybe<Variant_Colors_Bool_Exp>;
  colors_aggregate?: InputMaybe<Variant_Colors_Aggregate_Bool_Exp>;
  contributions?: InputMaybe<Contributions_Bool_Exp>;
  contributions_aggregate?: InputMaybe<Contributions_Aggregate_Bool_Exp>;
  description?: InputMaybe<String_Comparison_Exp>;
  fuel_type?: InputMaybe<String_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  launch_date?: InputMaybe<Date_Comparison_Exp>;
  manufacturer_link?: InputMaybe<String_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
  short_description?: InputMaybe<String_Comparison_Exp>;
  slug?: InputMaybe<String_Comparison_Exp>;
  specifications?: InputMaybe<Jsonb_Comparison_Exp>;
  transmission?: InputMaybe<String_Comparison_Exp>;
  vehicle?: InputMaybe<Vehicles_Bool_Exp>;
  vehicle_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "variants" */
export enum Variants_Constraint {
  /** unique or primary key constraint on columns "id" */
  VariantsPkey = 'variants_pkey',
  /** unique or primary key constraint on columns "slug" */
  VariantsSlug_8e3bb316Uniq = 'variants_slug_8e3bb316_uniq'
}

/** delete the field or element with specified path (for JSON arrays, negative integers count from the end) */
export type Variants_Delete_At_Path_Input = {
  specifications?: InputMaybe<Array<Scalars['String']['input']>>;
};

/** delete the array element with specified index (negative integers count from the end). throws an error if top level container is not an array */
export type Variants_Delete_Elem_Input = {
  specifications?: InputMaybe<Scalars['Int']['input']>;
};

/** delete key/value pair or string element. key/value pairs are matched based on their key value */
export type Variants_Delete_Key_Input = {
  specifications?: InputMaybe<Scalars['String']['input']>;
};

/** input type for inserting data into table "variants" */
export type Variants_Insert_Input = {
  attachments?: InputMaybe<Variants_Attachments_Arr_Rel_Insert_Input>;
  colors?: InputMaybe<Variant_Colors_Arr_Rel_Insert_Input>;
  contributions?: InputMaybe<Contributions_Arr_Rel_Insert_Input>;
  description?: InputMaybe<Scalars['String']['input']>;
  fuel_type?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  launch_date?: InputMaybe<Scalars['date']['input']>;
  manufacturer_link?: InputMaybe<Scalars['String']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  short_description?: InputMaybe<Scalars['String']['input']>;
  slug?: InputMaybe<Scalars['String']['input']>;
  specifications?: InputMaybe<Scalars['jsonb']['input']>;
  transmission?: InputMaybe<Scalars['String']['input']>;
  vehicle?: InputMaybe<Vehicles_Obj_Rel_Insert_Input>;
  vehicle_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Variants_Max_Fields = {
  __typename?: 'variants_max_fields';
  description?: Maybe<Scalars['String']['output']>;
  fuel_type?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  launch_date?: Maybe<Scalars['date']['output']>;
  manufacturer_link?: Maybe<Scalars['String']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  short_description?: Maybe<Scalars['String']['output']>;
  slug?: Maybe<Scalars['String']['output']>;
  transmission?: Maybe<Scalars['String']['output']>;
  vehicle_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "variants" */
export type Variants_Max_Order_By = {
  description?: InputMaybe<Order_By>;
  fuel_type?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  launch_date?: InputMaybe<Order_By>;
  manufacturer_link?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  short_description?: InputMaybe<Order_By>;
  slug?: InputMaybe<Order_By>;
  transmission?: InputMaybe<Order_By>;
  vehicle_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Variants_Min_Fields = {
  __typename?: 'variants_min_fields';
  description?: Maybe<Scalars['String']['output']>;
  fuel_type?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  launch_date?: Maybe<Scalars['date']['output']>;
  manufacturer_link?: Maybe<Scalars['String']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  short_description?: Maybe<Scalars['String']['output']>;
  slug?: Maybe<Scalars['String']['output']>;
  transmission?: Maybe<Scalars['String']['output']>;
  vehicle_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "variants" */
export type Variants_Min_Order_By = {
  description?: InputMaybe<Order_By>;
  fuel_type?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  launch_date?: InputMaybe<Order_By>;
  manufacturer_link?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  short_description?: InputMaybe<Order_By>;
  slug?: InputMaybe<Order_By>;
  transmission?: InputMaybe<Order_By>;
  vehicle_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "variants" */
export type Variants_Mutation_Response = {
  __typename?: 'variants_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Variants>;
};

/** input type for inserting object relation for remote table "variants" */
export type Variants_Obj_Rel_Insert_Input = {
  data: Variants_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Variants_On_Conflict>;
};

/** on_conflict condition type for table "variants" */
export type Variants_On_Conflict = {
  constraint: Variants_Constraint;
  update_columns?: Array<Variants_Update_Column>;
  where?: InputMaybe<Variants_Bool_Exp>;
};

/** Ordering options when selecting data from "variants". */
export type Variants_Order_By = {
  attachments_aggregate?: InputMaybe<Variants_Attachments_Aggregate_Order_By>;
  colors_aggregate?: InputMaybe<Variant_Colors_Aggregate_Order_By>;
  contributions_aggregate?: InputMaybe<Contributions_Aggregate_Order_By>;
  description?: InputMaybe<Order_By>;
  fuel_type?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  launch_date?: InputMaybe<Order_By>;
  manufacturer_link?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  short_description?: InputMaybe<Order_By>;
  slug?: InputMaybe<Order_By>;
  specifications?: InputMaybe<Order_By>;
  transmission?: InputMaybe<Order_By>;
  vehicle?: InputMaybe<Vehicles_Order_By>;
  vehicle_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: variants */
export type Variants_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** prepend existing jsonb value of filtered columns with new jsonb value */
export type Variants_Prepend_Input = {
  specifications?: InputMaybe<Scalars['jsonb']['input']>;
};

/** select columns of table "variants" */
export enum Variants_Select_Column {
  /** column name */
  Description = 'description',
  /** column name */
  FuelType = 'fuel_type',
  /** column name */
  Id = 'id',
  /** column name */
  LaunchDate = 'launch_date',
  /** column name */
  ManufacturerLink = 'manufacturer_link',
  /** column name */
  Name = 'name',
  /** column name */
  ShortDescription = 'short_description',
  /** column name */
  Slug = 'slug',
  /** column name */
  Specifications = 'specifications',
  /** column name */
  Transmission = 'transmission',
  /** column name */
  VehicleId = 'vehicle_id'
}

/** input type for updating data in table "variants" */
export type Variants_Set_Input = {
  description?: InputMaybe<Scalars['String']['input']>;
  fuel_type?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  launch_date?: InputMaybe<Scalars['date']['input']>;
  manufacturer_link?: InputMaybe<Scalars['String']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  short_description?: InputMaybe<Scalars['String']['input']>;
  slug?: InputMaybe<Scalars['String']['input']>;
  specifications?: InputMaybe<Scalars['jsonb']['input']>;
  transmission?: InputMaybe<Scalars['String']['input']>;
  vehicle_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** Streaming cursor of the table "variants" */
export type Variants_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Variants_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Variants_Stream_Cursor_Value_Input = {
  description?: InputMaybe<Scalars['String']['input']>;
  fuel_type?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  launch_date?: InputMaybe<Scalars['date']['input']>;
  manufacturer_link?: InputMaybe<Scalars['String']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  short_description?: InputMaybe<Scalars['String']['input']>;
  slug?: InputMaybe<Scalars['String']['input']>;
  specifications?: InputMaybe<Scalars['jsonb']['input']>;
  transmission?: InputMaybe<Scalars['String']['input']>;
  vehicle_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** update columns of table "variants" */
export enum Variants_Update_Column {
  /** column name */
  Description = 'description',
  /** column name */
  FuelType = 'fuel_type',
  /** column name */
  Id = 'id',
  /** column name */
  LaunchDate = 'launch_date',
  /** column name */
  ManufacturerLink = 'manufacturer_link',
  /** column name */
  Name = 'name',
  /** column name */
  ShortDescription = 'short_description',
  /** column name */
  Slug = 'slug',
  /** column name */
  Specifications = 'specifications',
  /** column name */
  Transmission = 'transmission',
  /** column name */
  VehicleId = 'vehicle_id'
}

export type Variants_Updates = {
  /** append existing jsonb value of filtered columns with new jsonb value */
  _append?: InputMaybe<Variants_Append_Input>;
  /** delete the field or element with specified path (for JSON arrays, negative integers count from the end) */
  _delete_at_path?: InputMaybe<Variants_Delete_At_Path_Input>;
  /** delete the array element with specified index (negative integers count from the end). throws an error if top level container is not an array */
  _delete_elem?: InputMaybe<Variants_Delete_Elem_Input>;
  /** delete key/value pair or string element. key/value pairs are matched based on their key value */
  _delete_key?: InputMaybe<Variants_Delete_Key_Input>;
  /** prepend existing jsonb value of filtered columns with new jsonb value */
  _prepend?: InputMaybe<Variants_Prepend_Input>;
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Variants_Set_Input>;
  /** filter the rows which have to be updated */
  where: Variants_Bool_Exp;
};

/** columns and relationships of "vehicle_types" */
export type Vehicle_Types = {
  __typename?: 'vehicle_types';
  category: Scalars['String']['output'];
  code: Scalars['String']['output'];
  id: Scalars['uuid']['output'];
  name: Scalars['String']['output'];
  /** An array relationship */
  vehicles: Array<Vehicles>;
  /** An aggregate relationship */
  vehicles_aggregate: Vehicles_Aggregate;
};


/** columns and relationships of "vehicle_types" */
export type Vehicle_TypesVehiclesArgs = {
  distinct_on?: InputMaybe<Array<Vehicles_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicles_Order_By>>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};


/** columns and relationships of "vehicle_types" */
export type Vehicle_TypesVehicles_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Vehicles_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicles_Order_By>>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};

/** aggregated selection of "vehicle_types" */
export type Vehicle_Types_Aggregate = {
  __typename?: 'vehicle_types_aggregate';
  aggregate?: Maybe<Vehicle_Types_Aggregate_Fields>;
  nodes: Array<Vehicle_Types>;
};

/** aggregate fields of "vehicle_types" */
export type Vehicle_Types_Aggregate_Fields = {
  __typename?: 'vehicle_types_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<Vehicle_Types_Max_Fields>;
  min?: Maybe<Vehicle_Types_Min_Fields>;
};


/** aggregate fields of "vehicle_types" */
export type Vehicle_Types_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Vehicle_Types_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** Boolean expression to filter rows from the table "vehicle_types". All fields are combined with a logical 'AND'. */
export type Vehicle_Types_Bool_Exp = {
  _and?: InputMaybe<Array<Vehicle_Types_Bool_Exp>>;
  _not?: InputMaybe<Vehicle_Types_Bool_Exp>;
  _or?: InputMaybe<Array<Vehicle_Types_Bool_Exp>>;
  category?: InputMaybe<String_Comparison_Exp>;
  code?: InputMaybe<String_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
  vehicles?: InputMaybe<Vehicles_Bool_Exp>;
  vehicles_aggregate?: InputMaybe<Vehicles_Aggregate_Bool_Exp>;
};

/** unique or primary key constraints on table "vehicle_types" */
export enum Vehicle_Types_Constraint {
  /** unique or primary key constraint on columns "code" */
  VehicleTypesCodeE8abf8b3Uniq = 'vehicle_types_code_e8abf8b3_uniq',
  /** unique or primary key constraint on columns "id" */
  VehicleTypesPkey = 'vehicle_types_pkey'
}

/** input type for inserting data into table "vehicle_types" */
export type Vehicle_Types_Insert_Input = {
  category?: InputMaybe<Scalars['String']['input']>;
  code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  vehicles?: InputMaybe<Vehicles_Arr_Rel_Insert_Input>;
};

/** aggregate max on columns */
export type Vehicle_Types_Max_Fields = {
  __typename?: 'vehicle_types_max_fields';
  category?: Maybe<Scalars['String']['output']>;
  code?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** aggregate min on columns */
export type Vehicle_Types_Min_Fields = {
  __typename?: 'vehicle_types_min_fields';
  category?: Maybe<Scalars['String']['output']>;
  code?: Maybe<Scalars['String']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
};

/** response of any mutation on the table "vehicle_types" */
export type Vehicle_Types_Mutation_Response = {
  __typename?: 'vehicle_types_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Vehicle_Types>;
};

/** input type for inserting object relation for remote table "vehicle_types" */
export type Vehicle_Types_Obj_Rel_Insert_Input = {
  data: Vehicle_Types_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Vehicle_Types_On_Conflict>;
};

/** on_conflict condition type for table "vehicle_types" */
export type Vehicle_Types_On_Conflict = {
  constraint: Vehicle_Types_Constraint;
  update_columns?: Array<Vehicle_Types_Update_Column>;
  where?: InputMaybe<Vehicle_Types_Bool_Exp>;
};

/** Ordering options when selecting data from "vehicle_types". */
export type Vehicle_Types_Order_By = {
  category?: InputMaybe<Order_By>;
  code?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  vehicles_aggregate?: InputMaybe<Vehicles_Aggregate_Order_By>;
};

/** primary key columns input for table: vehicle_types */
export type Vehicle_Types_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "vehicle_types" */
export enum Vehicle_Types_Select_Column {
  /** column name */
  Category = 'category',
  /** column name */
  Code = 'code',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

/** input type for updating data in table "vehicle_types" */
export type Vehicle_Types_Set_Input = {
  category?: InputMaybe<Scalars['String']['input']>;
  code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** Streaming cursor of the table "vehicle_types" */
export type Vehicle_Types_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Vehicle_Types_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Vehicle_Types_Stream_Cursor_Value_Input = {
  category?: InputMaybe<Scalars['String']['input']>;
  code?: InputMaybe<Scalars['String']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
};

/** update columns of table "vehicle_types" */
export enum Vehicle_Types_Update_Column {
  /** column name */
  Category = 'category',
  /** column name */
  Code = 'code',
  /** column name */
  Id = 'id',
  /** column name */
  Name = 'name'
}

export type Vehicle_Types_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Vehicle_Types_Set_Input>;
  /** filter the rows which have to be updated */
  where: Vehicle_Types_Bool_Exp;
};

/** columns and relationships of "vehicles" */
export type Vehicles = {
  __typename?: 'vehicles';
  id: Scalars['uuid']['output'];
  /** An object relationship */
  make: Makes;
  make_id: Scalars['uuid']['output'];
  name: Scalars['String']['output'];
  /** An object relationship */
  type: Vehicle_Types;
  /** An array relationship */
  variants: Array<Variants>;
  /** An aggregate relationship */
  variants_aggregate: Variants_Aggregate;
  vehicle_type_id: Scalars['uuid']['output'];
};


/** columns and relationships of "vehicles" */
export type VehiclesVariantsArgs = {
  distinct_on?: InputMaybe<Array<Variants_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Order_By>>;
  where?: InputMaybe<Variants_Bool_Exp>;
};


/** columns and relationships of "vehicles" */
export type VehiclesVariants_AggregateArgs = {
  distinct_on?: InputMaybe<Array<Variants_Select_Column>>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Order_By>>;
  where?: InputMaybe<Variants_Bool_Exp>;
};

/** aggregated selection of "vehicles" */
export type Vehicles_Aggregate = {
  __typename?: 'vehicles_aggregate';
  aggregate?: Maybe<Vehicles_Aggregate_Fields>;
  nodes: Array<Vehicles>;
};

export type Vehicles_Aggregate_Bool_Exp = {
  count?: InputMaybe<Vehicles_Aggregate_Bool_Exp_Count>;
};

export type Vehicles_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Vehicles_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Vehicles_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "vehicles" */
export type Vehicles_Aggregate_Fields = {
  __typename?: 'vehicles_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<Vehicles_Max_Fields>;
  min?: Maybe<Vehicles_Min_Fields>;
};


/** aggregate fields of "vehicles" */
export type Vehicles_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Vehicles_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "vehicles" */
export type Vehicles_Aggregate_Order_By = {
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Vehicles_Max_Order_By>;
  min?: InputMaybe<Vehicles_Min_Order_By>;
};

/** input type for inserting array relation for remote table "vehicles" */
export type Vehicles_Arr_Rel_Insert_Input = {
  data: Array<Vehicles_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Vehicles_On_Conflict>;
};

/** Boolean expression to filter rows from the table "vehicles". All fields are combined with a logical 'AND'. */
export type Vehicles_Bool_Exp = {
  _and?: InputMaybe<Array<Vehicles_Bool_Exp>>;
  _not?: InputMaybe<Vehicles_Bool_Exp>;
  _or?: InputMaybe<Array<Vehicles_Bool_Exp>>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  make?: InputMaybe<Makes_Bool_Exp>;
  make_id?: InputMaybe<Uuid_Comparison_Exp>;
  name?: InputMaybe<String_Comparison_Exp>;
  type?: InputMaybe<Vehicle_Types_Bool_Exp>;
  variants?: InputMaybe<Variants_Bool_Exp>;
  variants_aggregate?: InputMaybe<Variants_Aggregate_Bool_Exp>;
  vehicle_type_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "vehicles" */
export enum Vehicles_Constraint {
  /** unique or primary key constraint on columns "id" */
  VehiclesPkey = 'vehicles_pkey'
}

/** input type for inserting data into table "vehicles" */
export type Vehicles_Insert_Input = {
  id?: InputMaybe<Scalars['uuid']['input']>;
  make?: InputMaybe<Makes_Obj_Rel_Insert_Input>;
  make_id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  type?: InputMaybe<Vehicle_Types_Obj_Rel_Insert_Input>;
  variants?: InputMaybe<Variants_Arr_Rel_Insert_Input>;
  vehicle_type_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Vehicles_Max_Fields = {
  __typename?: 'vehicles_max_fields';
  id?: Maybe<Scalars['uuid']['output']>;
  make_id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  vehicle_type_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "vehicles" */
export type Vehicles_Max_Order_By = {
  id?: InputMaybe<Order_By>;
  make_id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  vehicle_type_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Vehicles_Min_Fields = {
  __typename?: 'vehicles_min_fields';
  id?: Maybe<Scalars['uuid']['output']>;
  make_id?: Maybe<Scalars['uuid']['output']>;
  name?: Maybe<Scalars['String']['output']>;
  vehicle_type_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "vehicles" */
export type Vehicles_Min_Order_By = {
  id?: InputMaybe<Order_By>;
  make_id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  vehicle_type_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "vehicles" */
export type Vehicles_Mutation_Response = {
  __typename?: 'vehicles_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Vehicles>;
};

/** input type for inserting object relation for remote table "vehicles" */
export type Vehicles_Obj_Rel_Insert_Input = {
  data: Vehicles_Insert_Input;
  /** upsert condition */
  on_conflict?: InputMaybe<Vehicles_On_Conflict>;
};

/** on_conflict condition type for table "vehicles" */
export type Vehicles_On_Conflict = {
  constraint: Vehicles_Constraint;
  update_columns?: Array<Vehicles_Update_Column>;
  where?: InputMaybe<Vehicles_Bool_Exp>;
};

/** Ordering options when selecting data from "vehicles". */
export type Vehicles_Order_By = {
  id?: InputMaybe<Order_By>;
  make?: InputMaybe<Makes_Order_By>;
  make_id?: InputMaybe<Order_By>;
  name?: InputMaybe<Order_By>;
  type?: InputMaybe<Vehicle_Types_Order_By>;
  variants_aggregate?: InputMaybe<Variants_Aggregate_Order_By>;
  vehicle_type_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: vehicles */
export type Vehicles_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "vehicles" */
export enum Vehicles_Select_Column {
  /** column name */
  Id = 'id',
  /** column name */
  MakeId = 'make_id',
  /** column name */
  Name = 'name',
  /** column name */
  VehicleTypeId = 'vehicle_type_id'
}

/** input type for updating data in table "vehicles" */
export type Vehicles_Set_Input = {
  id?: InputMaybe<Scalars['uuid']['input']>;
  make_id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  vehicle_type_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** Streaming cursor of the table "vehicles" */
export type Vehicles_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Vehicles_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Vehicles_Stream_Cursor_Value_Input = {
  id?: InputMaybe<Scalars['uuid']['input']>;
  make_id?: InputMaybe<Scalars['uuid']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  vehicle_type_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** update columns of table "vehicles" */
export enum Vehicles_Update_Column {
  /** column name */
  Id = 'id',
  /** column name */
  MakeId = 'make_id',
  /** column name */
  Name = 'name',
  /** column name */
  VehicleTypeId = 'vehicle_type_id'
}

export type Vehicles_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Vehicles_Set_Input>;
  /** filter the rows which have to be updated */
  where: Vehicles_Bool_Exp;
};

/** columns and relationships of "votes" */
export type Votes = {
  __typename?: 'votes';
  contribution_id: Scalars['uuid']['output'];
  created_at: Scalars['timestamptz']['output'];
  id: Scalars['uuid']['output'];
  type: Scalars['String']['output'];
  updated_at: Scalars['timestamptz']['output'];
  user_id: Scalars['uuid']['output'];
};

/** aggregated selection of "votes" */
export type Votes_Aggregate = {
  __typename?: 'votes_aggregate';
  aggregate?: Maybe<Votes_Aggregate_Fields>;
  nodes: Array<Votes>;
};

export type Votes_Aggregate_Bool_Exp = {
  count?: InputMaybe<Votes_Aggregate_Bool_Exp_Count>;
};

export type Votes_Aggregate_Bool_Exp_Count = {
  arguments?: InputMaybe<Array<Votes_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
  filter?: InputMaybe<Votes_Bool_Exp>;
  predicate: Int_Comparison_Exp;
};

/** aggregate fields of "votes" */
export type Votes_Aggregate_Fields = {
  __typename?: 'votes_aggregate_fields';
  count: Scalars['Int']['output'];
  max?: Maybe<Votes_Max_Fields>;
  min?: Maybe<Votes_Min_Fields>;
};


/** aggregate fields of "votes" */
export type Votes_Aggregate_FieldsCountArgs = {
  columns?: InputMaybe<Array<Votes_Select_Column>>;
  distinct?: InputMaybe<Scalars['Boolean']['input']>;
};

/** order by aggregate values of table "votes" */
export type Votes_Aggregate_Order_By = {
  count?: InputMaybe<Order_By>;
  max?: InputMaybe<Votes_Max_Order_By>;
  min?: InputMaybe<Votes_Min_Order_By>;
};

/** input type for inserting array relation for remote table "votes" */
export type Votes_Arr_Rel_Insert_Input = {
  data: Array<Votes_Insert_Input>;
  /** upsert condition */
  on_conflict?: InputMaybe<Votes_On_Conflict>;
};

/** Boolean expression to filter rows from the table "votes". All fields are combined with a logical 'AND'. */
export type Votes_Bool_Exp = {
  _and?: InputMaybe<Array<Votes_Bool_Exp>>;
  _not?: InputMaybe<Votes_Bool_Exp>;
  _or?: InputMaybe<Array<Votes_Bool_Exp>>;
  contribution_id?: InputMaybe<Uuid_Comparison_Exp>;
  created_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  id?: InputMaybe<Uuid_Comparison_Exp>;
  type?: InputMaybe<String_Comparison_Exp>;
  updated_at?: InputMaybe<Timestamptz_Comparison_Exp>;
  user_id?: InputMaybe<Uuid_Comparison_Exp>;
};

/** unique or primary key constraints on table "votes" */
export enum Votes_Constraint {
  /** unique or primary key constraint on columns "user_id", "contribution_id" */
  VotesContributionIdUserIdC683cc92Uniq = 'votes_contribution_id_user_id_c683cc92_uniq',
  /** unique or primary key constraint on columns "id" */
  VotesPkey = 'votes_pkey'
}

/** input type for inserting data into table "votes" */
export type Votes_Insert_Input = {
  contribution_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** aggregate max on columns */
export type Votes_Max_Fields = {
  __typename?: 'votes_max_fields';
  contribution_id?: Maybe<Scalars['uuid']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  type?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by max() on columns of table "votes" */
export type Votes_Max_Order_By = {
  contribution_id?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  type?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** aggregate min on columns */
export type Votes_Min_Fields = {
  __typename?: 'votes_min_fields';
  contribution_id?: Maybe<Scalars['uuid']['output']>;
  created_at?: Maybe<Scalars['timestamptz']['output']>;
  id?: Maybe<Scalars['uuid']['output']>;
  type?: Maybe<Scalars['String']['output']>;
  updated_at?: Maybe<Scalars['timestamptz']['output']>;
  user_id?: Maybe<Scalars['uuid']['output']>;
};

/** order by min() on columns of table "votes" */
export type Votes_Min_Order_By = {
  contribution_id?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  type?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** response of any mutation on the table "votes" */
export type Votes_Mutation_Response = {
  __typename?: 'votes_mutation_response';
  /** number of rows affected by the mutation */
  affected_rows: Scalars['Int']['output'];
  /** data from the rows affected by the mutation */
  returning: Array<Votes>;
};

/** on_conflict condition type for table "votes" */
export type Votes_On_Conflict = {
  constraint: Votes_Constraint;
  update_columns?: Array<Votes_Update_Column>;
  where?: InputMaybe<Votes_Bool_Exp>;
};

/** Ordering options when selecting data from "votes". */
export type Votes_Order_By = {
  contribution_id?: InputMaybe<Order_By>;
  created_at?: InputMaybe<Order_By>;
  id?: InputMaybe<Order_By>;
  type?: InputMaybe<Order_By>;
  updated_at?: InputMaybe<Order_By>;
  user_id?: InputMaybe<Order_By>;
};

/** primary key columns input for table: votes */
export type Votes_Pk_Columns_Input = {
  id: Scalars['uuid']['input'];
};

/** select columns of table "votes" */
export enum Votes_Select_Column {
  /** column name */
  ContributionId = 'contribution_id',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  Id = 'id',
  /** column name */
  Type = 'type',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  UserId = 'user_id'
}

/** input type for updating data in table "votes" */
export type Votes_Set_Input = {
  contribution_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** Streaming cursor of the table "votes" */
export type Votes_Stream_Cursor_Input = {
  /** Stream column input with initial value */
  initial_value: Votes_Stream_Cursor_Value_Input;
  /** cursor ordering */
  ordering?: InputMaybe<Cursor_Ordering>;
};

/** Initial value of the column from where the streaming should start */
export type Votes_Stream_Cursor_Value_Input = {
  contribution_id?: InputMaybe<Scalars['uuid']['input']>;
  created_at?: InputMaybe<Scalars['timestamptz']['input']>;
  id?: InputMaybe<Scalars['uuid']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  updated_at?: InputMaybe<Scalars['timestamptz']['input']>;
  user_id?: InputMaybe<Scalars['uuid']['input']>;
};

/** update columns of table "votes" */
export enum Votes_Update_Column {
  /** column name */
  ContributionId = 'contribution_id',
  /** column name */
  CreatedAt = 'created_at',
  /** column name */
  Id = 'id',
  /** column name */
  Type = 'type',
  /** column name */
  UpdatedAt = 'updated_at',
  /** column name */
  UserId = 'user_id'
}

export type Votes_Updates = {
  /** sets the columns of the filtered rows to the given values */
  _set?: InputMaybe<Votes_Set_Input>;
  /** filter the rows which have to be updated */
  where: Votes_Bool_Exp;
};

export type CurrentUserQueryVariables = Exact<{ [key: string]: never; }>;


export type CurrentUserQuery = { __typename?: 'query_root', users: Array<{ __typename?: 'users', id: any, email: string, username: string, first_name?: string | null, last_name?: string | null, avatar?: string | null, has_contributed: boolean, email_verified: boolean, google_id?: string | null, passkeys: Array<{ __typename?: 'user_passkeys', id: any, credential_id: any, created_at: any, updated_at: any, description?: string | null }>, tokens: Array<{ __typename?: 'user_tokens', id: any, client: string, expires_at?: any | null, created_at: any }>, city?: { __typename?: 'cities', id: any, name: string, state: { __typename?: 'states', id: any, name: string } } | null }> };

export type MembershipTypeByEmailQueryVariables = Exact<{
  email: Scalars['String']['input'];
}>;


export type MembershipTypeByEmailQuery = { __typename?: 'query_root', membershipTypeByEmail: { __typename?: 'MembershipTypeByEmailResponse', message: string, data?: string | null } };

export type LoginMutationVariables = Exact<{
  email: Scalars['String']['input'];
  password: Scalars['String']['input'];
}>;


export type LoginMutation = { __typename?: 'mutation_root', login: { __typename?: 'LoginResponse', code: number, message: string, data?: { __typename?: 'Tokens', accessToken: string, refreshToken: any } | null } };

export type LoginWithMagicLinkMutationVariables = Exact<{
  email: Scalars['String']['input'];
}>;


export type LoginWithMagicLinkMutation = { __typename?: 'mutation_root', loginWithMagicLink: { __typename?: 'LoginWithMagicLinkResponse', code: number, data?: any | null, message: string } };

export type RegisterMutationVariables = Exact<{
  input: RegisterInput;
}>;


export type RegisterMutation = { __typename?: 'mutation_root', register: { __typename?: 'RegisterResponse', success: boolean, message: string, errors?: any | null, data?: { __typename?: 'RegisterDataType', user: { __typename?: 'UserType', id: any, email: string }, tokens: { __typename?: 'Tokens', accessToken: string, refreshToken: any } } | null } };

export type SendEmailOtpMutationVariables = Exact<{
  email: Scalars['String']['input'];
}>;


export type SendEmailOtpMutation = { __typename?: 'mutation_root', sendEmailOtp: { __typename?: 'SendEmailOtpResponse', code: number, data?: any | null, message: string } };

export type VerifyOtpMutationVariables = Exact<{
  input: OtpInput;
}>;


export type VerifyOtpMutation = { __typename?: 'mutation_root', verifyOtp: { __typename?: 'VerifyOtpResponse', code: number, message: string, data?: any | null } };

export type AuthCodeExchangeMutationVariables = Exact<{
  code: Scalars['String']['input'];
  type: Scalars['String']['input'];
}>;


export type AuthCodeExchangeMutation = { __typename?: 'mutation_root', authCodeExchange: { __typename?: 'AuthCodeExchangeResponse', code: number, message: string, success: boolean, data?: { __typename?: 'Tokens', accessToken: string, refreshToken: any } | null } };

export type ForgotPasswordMutationVariables = Exact<{
  identity: Scalars['String']['input'];
}>;


export type ForgotPasswordMutation = { __typename?: 'mutation_root', forgotPassword: { __typename?: 'ForgotPasswordResponse', code: number, data?: any | null, success: boolean, message: string } };

export type ForgotPasswordConfirmMutationVariables = Exact<{
  input: ForgotPasswordConfirmInput;
}>;


export type ForgotPasswordConfirmMutation = { __typename?: 'mutation_root', forgotPasswordConfirm: { __typename?: 'ForgotPasswordConfirmResponse', success: boolean, code: number, message: string, data?: { __typename?: 'Tokens', accessToken: string, refreshToken: any } | null } };

export type PasskeyRegisterOptionsMutationVariables = Exact<{
  name: Scalars['String']['input'];
}>;


export type PasskeyRegisterOptionsMutation = { __typename?: 'mutation_root', passkeyRegisterOptions: { __typename?: 'PasskeyRegisterOptions', data?: any | null, code: number, message: string, success: boolean } };

export type PasskeyRegisterVerifyMutationVariables = Exact<{
  credential: Scalars['String']['input'];
}>;


export type PasskeyRegisterVerifyMutation = { __typename?: 'mutation_root', passkeyRegisterVerify: { __typename?: 'PasskeyRegisterVerifyResponse', code: number, message: string, success: boolean, data?: { __typename?: 'PasskeyRegisterVerifyData', passKey: { __typename?: 'PassKey', id: any, credentialId: string, userId: any }, tokens: { __typename?: 'Tokens', accessToken: string, refreshToken: any } } | null } };

export type PasskeyAuthOptionsMutationVariables = Exact<{ [key: string]: never; }>;


export type PasskeyAuthOptionsMutation = { __typename?: 'mutation_root', passkeyAuthOptions: { __typename?: 'PasskeyAuthOptionsResponse', code: number, data?: any | null, message: string } };

export type PasskeyAuthOptionsVerifyMutationVariables = Exact<{
  credential: Scalars['String']['input'];
  credentialId: Scalars['String']['input'];
}>;


export type PasskeyAuthOptionsVerifyMutation = { __typename?: 'mutation_root', passkeyAuthOptionsVerify: { __typename?: 'PasskeyAuthOptionsVerifyResponse', code: number, message: string, data?: { __typename?: 'Tokens', accessToken: string, refreshToken: any } | null } };

export type Delete_User_TokensMutationVariables = Exact<{
  where: User_Tokens_Bool_Exp;
}>;


export type Delete_User_TokensMutation = { __typename?: 'mutation_root', delete_user_tokens?: { __typename?: 'user_tokens_mutation_response', affected_rows: number, returning: Array<{ __typename?: 'user_tokens', id: any, client: string }> } | null };

export type Delete_User_PasskeysMutationVariables = Exact<{
  where: User_Passkeys_Bool_Exp;
}>;


export type Delete_User_PasskeysMutation = { __typename?: 'mutation_root', delete_user_passkeys?: { __typename?: 'user_passkeys_mutation_response', affected_rows: number, returning: Array<{ __typename?: 'user_passkeys', id: any, credential_id: any }> } | null };

export type CitiesQueryVariables = Exact<{
  distinct_on?: InputMaybe<Array<Cities_Select_Column> | Cities_Select_Column>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Cities_Order_By> | Cities_Order_By>;
  where?: InputMaybe<Cities_Bool_Exp>;
}>;


export type CitiesQuery = { __typename?: 'query_root', cities: Array<{ __typename?: 'cities', id: any, name: string, state: { __typename?: 'states', id: any, name: string } }> };

export type MyContributionsQueryVariables = Exact<{
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  query?: InputMaybe<Scalars['String']['input']>;
}>;


export type MyContributionsQuery = { __typename?: 'query_root', myContributions: { __typename?: 'MyContributionsResponse', code: number, data: Array<any>, message: string } };

export type ContributionsQueryVariables = Exact<{
  distinct_on?: InputMaybe<Array<Contributions_Select_Column> | Contributions_Select_Column>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By> | Contributions_Order_By>;
  where?: InputMaybe<Contributions_Bool_Exp>;
}>;


export type ContributionsQuery = { __typename?: 'query_root', contributions: Array<{ __typename?: 'contributions', id: any, created_at: any, updated_at: any, quoted_on: any, dealership_name: string, remark?: string | null, upvotes: number, downvotes: number, total: any, city: { __typename?: 'cities', id: any, name: string }, variant: { __typename?: 'variants', id: any, name: string }, variant_color?: { __typename?: 'variant_colors', id: any, name: string } | null, items: Array<{ __typename?: 'contribution_price_items', id: any, serial_no: any, value: any, price_item: { __typename?: 'price_items', id: any, name: string, type: string } }> }> };

export type ContributionsBriefQueryVariables = Exact<{
  distinct_on?: InputMaybe<Array<Contributions_Select_Column> | Contributions_Select_Column>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Contributions_Order_By> | Contributions_Order_By>;
  where?: InputMaybe<Contributions_Bool_Exp>;
}>;


export type ContributionsBriefQuery = { __typename?: 'query_root', contributions: Array<{ __typename?: 'contributions', id: any, created_at: any, upvotes: number, downvotes: number, total: any, variant: { __typename?: 'variants', id: any, name: string }, variant_color?: { __typename?: 'variant_colors', id: any, name: string } | null }> };

export type Add_Update_ContributionMutationVariables = Exact<{
  object: Contributions_Insert_Input;
  on_conflict?: InputMaybe<Contributions_On_Conflict>;
}>;


export type Add_Update_ContributionMutation = { __typename?: 'mutation_root', insert_contributions_one?: { __typename?: 'contributions', id: any, created_at: any, updated_at: any, quoted_on: any, dealership_name: string, upvotes: number, downvotes: number, total: any, city: { __typename?: 'cities', id: any, name: string }, variant: { __typename?: 'variants', id: any, name: string }, variant_color?: { __typename?: 'variant_colors', id: any, name: string } | null, items: Array<{ __typename?: 'contribution_price_items', id: any, serial_no: any, value: any, price_item: { __typename?: 'price_items', id: any, name: string, type: string } }> } | null };

export type Price_ItemsQueryVariables = Exact<{
  distinct_on?: InputMaybe<Array<Price_Items_Select_Column> | Price_Items_Select_Column>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Price_Items_Order_By> | Price_Items_Order_By>;
  where?: InputMaybe<Price_Items_Bool_Exp>;
}>;


export type Price_ItemsQuery = { __typename?: 'query_root', price_items: Array<{ __typename?: 'price_items', id: any, name: string, type: string }> };

export type Delete_Price_ItemsMutationVariables = Exact<{
  where: Price_Items_Bool_Exp;
}>;


export type Delete_Price_ItemsMutation = { __typename?: 'mutation_root', delete_price_items?: { __typename?: 'price_items_mutation_response', affected_rows: number, returning: Array<{ __typename?: 'price_items', id: any, name: string }> } | null };

export type Vehicle_TypesQueryVariables = Exact<{
  distinct_on?: InputMaybe<Array<Vehicle_Types_Select_Column> | Vehicle_Types_Select_Column>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Vehicle_Types_Order_By> | Vehicle_Types_Order_By>;
  where?: InputMaybe<Vehicle_Types_Bool_Exp>;
}>;


export type Vehicle_TypesQuery = { __typename?: 'query_root', vehicle_types: Array<{ __typename?: 'vehicle_types', id: any, name: string, code: string }> };

export type MakesQueryVariables = Exact<{
  distinct_on?: InputMaybe<Array<Makes_Select_Column> | Makes_Select_Column>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Makes_Order_By> | Makes_Order_By>;
  where?: InputMaybe<Makes_Bool_Exp>;
}>;


export type MakesQuery = { __typename?: 'query_root', makes: Array<{ __typename?: 'makes', id: any, name: string, code: string }> };

export type Price_FilterQueryVariables = Exact<{ [key: string]: never; }>;


export type Price_FilterQuery = { __typename?: 'query_root', contributions_aggregate: { __typename?: 'contributions_aggregate', aggregate?: { __typename?: 'contributions_aggregate_fields', min?: { __typename?: 'contributions_min_fields', total?: any | null } | null, max?: { __typename?: 'contributions_max_fields', total?: any | null } | null } | null } };

export type Update_Users_By_PkMutationVariables = Exact<{
  _set?: InputMaybe<Users_Set_Input>;
  pk_columns: Users_Pk_Columns_Input;
}>;


export type Update_Users_By_PkMutation = { __typename?: 'mutation_root', update_users_by_pk?: { __typename?: 'users', id: any, email: string, email_verified: boolean, username: string, first_name?: string | null, last_name?: string | null, avatar?: string | null, city?: { __typename?: 'cities', id: any, name: string, state: { __typename?: 'states', id: any, name: string } } | null } | null };

export type VariantsQueryVariables = Exact<{
  distinct_on?: InputMaybe<Array<Variants_Select_Column> | Variants_Select_Column>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Order_By> | Variants_Order_By>;
  where?: InputMaybe<Variants_Bool_Exp>;
}>;


export type VariantsQuery = { __typename?: 'query_root', variants: Array<{ __typename?: 'variants', id: any, name: string, slug: string, manufacturer_link?: string | null, vehicle: { __typename?: 'vehicles', id: any, name: string } }> };

export type Variant_ColorsQueryVariables = Exact<{
  distinct_on?: InputMaybe<Array<Variant_Colors_Select_Column> | Variant_Colors_Select_Column>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variant_Colors_Order_By> | Variant_Colors_Order_By>;
  where?: InputMaybe<Variant_Colors_Bool_Exp>;
}>;


export type Variant_ColorsQuery = { __typename?: 'query_root', variant_colors: Array<{ __typename?: 'variant_colors', id: any, name: string, hex_code?: string | null }> };

export type VariantsListQueryVariables = Exact<{
  distinct_on?: InputMaybe<Array<Variants_Select_Column> | Variants_Select_Column>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  order_by?: InputMaybe<Array<Variants_Order_By> | Variants_Order_By>;
  where?: InputMaybe<Variants_Bool_Exp>;
  contributions_where?: InputMaybe<Contributions_Bool_Exp>;
}>;


export type VariantsListQuery = { __typename?: 'query_root', variants: Array<{ __typename?: 'variants', id: any, name: string, slug: string, manufacturer_link?: string | null, short_description?: string | null, colors: Array<{ __typename?: 'variant_colors', id: any, attachments: Array<{ __typename?: 'variant_colors_attachments', id: any, attachment: { __typename?: 'attachments', id: any, url: string } }> }>, vehicle: { __typename?: 'vehicles', id: any, type: { __typename?: 'vehicle_types', id: any, name: string } }, contributions_aggregate: { __typename?: 'contributions_aggregate', aggregate?: { __typename?: 'contributions_aggregate_fields', avg?: { __typename?: 'contributions_avg_fields', total?: number | null } | null } | null } }>, variants_aggregate: { __typename?: 'variants_aggregate', aggregate?: { __typename?: 'variants_aggregate_fields', count: number } | null } };

export type VariantDetailQueryVariables = Exact<{
  slug?: InputMaybe<Scalars['String']['input']>;
  contributions_where?: InputMaybe<Contributions_Bool_Exp>;
}>;


export type VariantDetailQuery = { __typename?: 'query_root', variants: Array<{ __typename?: 'variants', id: any, name: string, launch_date: any, transmission: string, fuel_type: string, description: string, specifications?: any | null, vehicle: { __typename?: 'vehicles', id: any, type: { __typename?: 'vehicle_types', id: any, name: string } }, colors: Array<{ __typename?: 'variant_colors', id: any, name: string, attachments: Array<{ __typename?: 'variant_colors_attachments', id: any, attachment: { __typename?: 'attachments', id: any, url: string } }> }>, contributions: Array<{ __typename?: 'contributions', id: any, total: any, upvotes: number, downvotes: number, items: Array<{ __typename?: 'contribution_price_items', id: any, price_item: { __typename?: 'price_items', id: any, name: string, type: string, category: string } }> }> }> };

export type VariantContributionsQueryVariables = Exact<{
  where?: InputMaybe<Contributions_Bool_Exp>;
}>;


export type VariantContributionsQuery = { __typename?: 'query_root', contributions: Array<{ __typename?: 'contributions', id: any, total: any, upvotes: number, downvotes: number, items: Array<{ __typename?: 'contribution_price_items', id: any, price_item: { __typename?: 'price_items', id: any, name: string, type: string, category: string } }> }> };


export const CurrentUserDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"currentUser"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"users"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"username"}},{"kind":"Field","name":{"kind":"Name","value":"first_name"}},{"kind":"Field","name":{"kind":"Name","value":"last_name"}},{"kind":"Field","name":{"kind":"Name","value":"avatar"}},{"kind":"Field","name":{"kind":"Name","value":"has_contributed"}},{"kind":"Field","name":{"kind":"Name","value":"email_verified"}},{"kind":"Field","name":{"kind":"Name","value":"google_id"}},{"kind":"Field","name":{"kind":"Name","value":"passkeys"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"credential_id"}},{"kind":"Field","name":{"kind":"Name","value":"created_at"}},{"kind":"Field","name":{"kind":"Name","value":"updated_at"}},{"kind":"Field","name":{"kind":"Name","value":"description"}}]}},{"kind":"Field","name":{"kind":"Name","value":"tokens"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"client"}},{"kind":"Field","name":{"kind":"Name","value":"expires_at"}},{"kind":"Field","name":{"kind":"Name","value":"created_at"}}]}},{"kind":"Field","name":{"kind":"Name","value":"city"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"state"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}}]}}]}}]}}]} as unknown as DocumentNode<CurrentUserQuery, CurrentUserQueryVariables>;
export const MembershipTypeByEmailDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"membershipTypeByEmail"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"email"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"membershipTypeByEmail"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"email"},"value":{"kind":"Variable","name":{"kind":"Name","value":"email"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"message"}},{"kind":"Field","name":{"kind":"Name","value":"data"}}]}}]}}]} as unknown as DocumentNode<MembershipTypeByEmailQuery, MembershipTypeByEmailQueryVariables>;
export const LoginDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"login"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"email"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"password"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"login"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"email"},"value":{"kind":"Variable","name":{"kind":"Name","value":"email"}}},{"kind":"Argument","name":{"kind":"Name","value":"password"},"value":{"kind":"Variable","name":{"kind":"Name","value":"password"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"data"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"refreshToken"}}]}},{"kind":"Field","name":{"kind":"Name","value":"message"}}]}}]}}]} as unknown as DocumentNode<LoginMutation, LoginMutationVariables>;
export const LoginWithMagicLinkDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"loginWithMagicLink"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"email"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"loginWithMagicLink"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"email"},"value":{"kind":"Variable","name":{"kind":"Name","value":"email"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"data"}},{"kind":"Field","name":{"kind":"Name","value":"message"}}]}}]}}]} as unknown as DocumentNode<LoginWithMagicLinkMutation, LoginWithMagicLinkMutationVariables>;
export const RegisterDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"register"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"RegisterInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"register"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"data"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"user"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}}]}},{"kind":"Field","name":{"kind":"Name","value":"tokens"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"refreshToken"}}]}}]}},{"kind":"Field","name":{"kind":"Name","value":"success"}},{"kind":"Field","name":{"kind":"Name","value":"message"}},{"kind":"Field","name":{"kind":"Name","value":"errors"}}]}}]}}]} as unknown as DocumentNode<RegisterMutation, RegisterMutationVariables>;
export const SendEmailOtpDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"sendEmailOtp"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"email"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"sendEmailOtp"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"email"},"value":{"kind":"Variable","name":{"kind":"Name","value":"email"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"data"}},{"kind":"Field","name":{"kind":"Name","value":"message"}}]}}]}}]} as unknown as DocumentNode<SendEmailOtpMutation, SendEmailOtpMutationVariables>;
export const VerifyOtpDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"verifyOtp"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"OtpInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"verifyOtp"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"message"}},{"kind":"Field","name":{"kind":"Name","value":"data"}}]}}]}}]} as unknown as DocumentNode<VerifyOtpMutation, VerifyOtpMutationVariables>;
export const AuthCodeExchangeDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"authCodeExchange"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"code"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"type"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"authCodeExchange"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"code"},"value":{"kind":"Variable","name":{"kind":"Name","value":"code"}}},{"kind":"Argument","name":{"kind":"Name","value":"type"},"value":{"kind":"Variable","name":{"kind":"Name","value":"type"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"message"}},{"kind":"Field","name":{"kind":"Name","value":"success"}},{"kind":"Field","name":{"kind":"Name","value":"data"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"refreshToken"}}]}}]}}]}}]} as unknown as DocumentNode<AuthCodeExchangeMutation, AuthCodeExchangeMutationVariables>;
export const ForgotPasswordDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"forgotPassword"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"identity"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"forgotPassword"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"identity"},"value":{"kind":"Variable","name":{"kind":"Name","value":"identity"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"data"}},{"kind":"Field","name":{"kind":"Name","value":"success"}},{"kind":"Field","name":{"kind":"Name","value":"message"}}]}}]}}]} as unknown as DocumentNode<ForgotPasswordMutation, ForgotPasswordMutationVariables>;
export const ForgotPasswordConfirmDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"forgotPasswordConfirm"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"input"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"ForgotPasswordConfirmInput"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"forgotPasswordConfirm"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"input"},"value":{"kind":"Variable","name":{"kind":"Name","value":"input"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"data"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"refreshToken"}}]}},{"kind":"Field","name":{"kind":"Name","value":"success"}},{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"message"}}]}}]}}]} as unknown as DocumentNode<ForgotPasswordConfirmMutation, ForgotPasswordConfirmMutationVariables>;
export const PasskeyRegisterOptionsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"passkeyRegisterOptions"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"name"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"passkeyRegisterOptions"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"name"},"value":{"kind":"Variable","name":{"kind":"Name","value":"name"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"data"}},{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"message"}},{"kind":"Field","name":{"kind":"Name","value":"success"}}]}}]}}]} as unknown as DocumentNode<PasskeyRegisterOptionsMutation, PasskeyRegisterOptionsMutationVariables>;
export const PasskeyRegisterVerifyDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"passkeyRegisterVerify"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"credential"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"passkeyRegisterVerify"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"credential"},"value":{"kind":"Variable","name":{"kind":"Name","value":"credential"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"data"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"passKey"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"credentialId"}},{"kind":"Field","name":{"kind":"Name","value":"userId"}}]}},{"kind":"Field","name":{"kind":"Name","value":"tokens"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"refreshToken"}}]}}]}},{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"message"}},{"kind":"Field","name":{"kind":"Name","value":"success"}}]}}]}}]} as unknown as DocumentNode<PasskeyRegisterVerifyMutation, PasskeyRegisterVerifyMutationVariables>;
export const PasskeyAuthOptionsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"passkeyAuthOptions"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"passkeyAuthOptions"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"data"}},{"kind":"Field","name":{"kind":"Name","value":"message"}}]}}]}}]} as unknown as DocumentNode<PasskeyAuthOptionsMutation, PasskeyAuthOptionsMutationVariables>;
export const PasskeyAuthOptionsVerifyDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"passkeyAuthOptionsVerify"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"credential"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"credentialId"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"passkeyAuthOptionsVerify"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"credential"},"value":{"kind":"Variable","name":{"kind":"Name","value":"credential"}}},{"kind":"Argument","name":{"kind":"Name","value":"credentialId"},"value":{"kind":"Variable","name":{"kind":"Name","value":"credentialId"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"message"}},{"kind":"Field","name":{"kind":"Name","value":"data"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"accessToken"}},{"kind":"Field","name":{"kind":"Name","value":"refreshToken"}}]}}]}}]}}]} as unknown as DocumentNode<PasskeyAuthOptionsVerifyMutation, PasskeyAuthOptionsVerifyMutationVariables>;
export const Delete_User_TokensDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"delete_user_tokens"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"user_tokens_bool_exp"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"delete_user_tokens"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"returning"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"client"}}]}},{"kind":"Field","name":{"kind":"Name","value":"affected_rows"}}]}}]}}]} as unknown as DocumentNode<Delete_User_TokensMutation, Delete_User_TokensMutationVariables>;
export const Delete_User_PasskeysDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"delete_user_passkeys"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"user_passkeys_bool_exp"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"delete_user_passkeys"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"returning"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"credential_id"}}]}},{"kind":"Field","name":{"kind":"Name","value":"affected_rows"}}]}}]}}]} as unknown as DocumentNode<Delete_User_PasskeysMutation, Delete_User_PasskeysMutationVariables>;
export const CitiesDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"cities"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"cities_select_column"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"cities_order_by"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"cities_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"cities"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"state"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}}]}}]}}]} as unknown as DocumentNode<CitiesQuery, CitiesQueryVariables>;
export const MyContributionsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"myContributions"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"query"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"myContributions"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"query"},"value":{"kind":"Variable","name":{"kind":"Name","value":"query"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"code"}},{"kind":"Field","name":{"kind":"Name","value":"data"}},{"kind":"Field","name":{"kind":"Name","value":"message"}}]}}]}}]} as unknown as DocumentNode<MyContributionsQuery, MyContributionsQueryVariables>;
export const ContributionsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"contributions"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_select_column"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_order_by"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"contributions"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"created_at"}},{"kind":"Field","name":{"kind":"Name","value":"updated_at"}},{"kind":"Field","name":{"kind":"Name","value":"quoted_on"}},{"kind":"Field","name":{"kind":"Name","value":"dealership_name"}},{"kind":"Field","name":{"kind":"Name","value":"remark"}},{"kind":"Field","name":{"kind":"Name","value":"city"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"variant"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"variant_color"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"upvotes"}},{"kind":"Field","name":{"kind":"Name","value":"downvotes"}},{"kind":"Field","name":{"kind":"Name","value":"total"}},{"kind":"Field","name":{"kind":"Name","value":"items"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"serial_no"}},{"kind":"Field","name":{"kind":"Name","value":"price_item"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"type"}}]}},{"kind":"Field","name":{"kind":"Name","value":"value"}}]}}]}}]}}]} as unknown as DocumentNode<ContributionsQuery, ContributionsQueryVariables>;
export const ContributionsBriefDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"contributionsBrief"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_select_column"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_order_by"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"contributions"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"created_at"}},{"kind":"Field","name":{"kind":"Name","value":"upvotes"}},{"kind":"Field","name":{"kind":"Name","value":"downvotes"}},{"kind":"Field","name":{"kind":"Name","value":"total"}},{"kind":"Field","name":{"kind":"Name","value":"variant"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"variant_color"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}}]}}]}}]} as unknown as DocumentNode<ContributionsBriefQuery, ContributionsBriefQueryVariables>;
export const Add_Update_ContributionDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"add_update_contribution"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"object"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_insert_input"}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"on_conflict"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_on_conflict"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"insert_contributions_one"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"object"},"value":{"kind":"Variable","name":{"kind":"Name","value":"object"}}},{"kind":"Argument","name":{"kind":"Name","value":"on_conflict"},"value":{"kind":"Variable","name":{"kind":"Name","value":"on_conflict"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"created_at"}},{"kind":"Field","name":{"kind":"Name","value":"updated_at"}},{"kind":"Field","name":{"kind":"Name","value":"quoted_on"}},{"kind":"Field","name":{"kind":"Name","value":"dealership_name"}},{"kind":"Field","name":{"kind":"Name","value":"city"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"variant"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"variant_color"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"upvotes"}},{"kind":"Field","name":{"kind":"Name","value":"downvotes"}},{"kind":"Field","name":{"kind":"Name","value":"total"}},{"kind":"Field","name":{"kind":"Name","value":"items"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"serial_no"}},{"kind":"Field","name":{"kind":"Name","value":"price_item"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"type"}}]}},{"kind":"Field","name":{"kind":"Name","value":"value"}}]}}]}}]}}]} as unknown as DocumentNode<Add_Update_ContributionMutation, Add_Update_ContributionMutationVariables>;
export const Price_ItemsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"price_items"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"price_items_select_column"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"price_items_order_by"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"price_items_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"price_items"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"type"}}]}}]}}]} as unknown as DocumentNode<Price_ItemsQuery, Price_ItemsQueryVariables>;
export const Delete_Price_ItemsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"delete_price_items"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"price_items_bool_exp"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"delete_price_items"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"returning"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}},{"kind":"Field","name":{"kind":"Name","value":"affected_rows"}}]}}]}}]} as unknown as DocumentNode<Delete_Price_ItemsMutation, Delete_Price_ItemsMutationVariables>;
export const Vehicle_TypesDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"vehicle_types"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"vehicle_types_select_column"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"vehicle_types_order_by"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"vehicle_types_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"vehicle_types"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"code"}}]}}]}}]} as unknown as DocumentNode<Vehicle_TypesQuery, Vehicle_TypesQueryVariables>;
export const MakesDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"makes"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"makes_select_column"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"makes_order_by"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"makes_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"makes"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"code"}}]}}]}}]} as unknown as DocumentNode<MakesQuery, MakesQueryVariables>;
export const Price_FilterDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"price_filter"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"contributions_aggregate"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"aggregate"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"min"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"total"}}]}},{"kind":"Field","name":{"kind":"Name","value":"max"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"total"}}]}}]}}]}}]}}]} as unknown as DocumentNode<Price_FilterQuery, Price_FilterQueryVariables>;
export const Update_Users_By_PkDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"update_users_by_pk"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"_set"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"users_set_input"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"pk_columns"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"users_pk_columns_input"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"update_users_by_pk"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"_set"},"value":{"kind":"Variable","name":{"kind":"Name","value":"_set"}}},{"kind":"Argument","name":{"kind":"Name","value":"pk_columns"},"value":{"kind":"Variable","name":{"kind":"Name","value":"pk_columns"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"email_verified"}},{"kind":"Field","name":{"kind":"Name","value":"username"}},{"kind":"Field","name":{"kind":"Name","value":"first_name"}},{"kind":"Field","name":{"kind":"Name","value":"last_name"}},{"kind":"Field","name":{"kind":"Name","value":"avatar"}},{"kind":"Field","name":{"kind":"Name","value":"city"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"state"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}}]}}]}}]}}]} as unknown as DocumentNode<Update_Users_By_PkMutation, Update_Users_By_PkMutationVariables>;
export const VariantsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"variants"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"variants_select_column"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"variants_order_by"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"variants_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"variants"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"slug"}},{"kind":"Field","name":{"kind":"Name","value":"manufacturer_link"}},{"kind":"Field","name":{"kind":"Name","value":"vehicle"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}}]}}]}}]} as unknown as DocumentNode<VariantsQuery, VariantsQueryVariables>;
export const Variant_ColorsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"variant_colors"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"variant_colors_select_column"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"variant_colors_order_by"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"variant_colors_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"variant_colors"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"hex_code"}}]}}]}}]} as unknown as DocumentNode<Variant_ColorsQuery, Variant_ColorsQueryVariables>;
export const VariantsListDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"variantsList"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"variants_select_column"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"limit"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"offset"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"Int"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}},"type":{"kind":"ListType","type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"variants_order_by"}}}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"variants_bool_exp"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"contributions_where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"variants"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"Variable","name":{"kind":"Name","value":"limit"}}},{"kind":"Argument","name":{"kind":"Name","value":"offset"},"value":{"kind":"Variable","name":{"kind":"Name","value":"offset"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"slug"}},{"kind":"Field","name":{"kind":"Name","value":"manufacturer_link"}},{"kind":"Field","name":{"kind":"Name","value":"colors"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"attachments"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"attachment"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"url"}}]}}]}}]}},{"kind":"Field","name":{"kind":"Name","value":"vehicle"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"type"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}}]}},{"kind":"Field","name":{"kind":"Name","value":"short_description"}},{"kind":"Field","name":{"kind":"Name","value":"contributions_aggregate"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"ObjectValue","fields":[{"kind":"ObjectField","name":{"kind":"Name","value":"created_at"},"value":{"kind":"EnumValue","value":"desc"}},{"kind":"ObjectField","name":{"kind":"Name","value":"upvotes"},"value":{"kind":"EnumValue","value":"desc"}}]}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"IntValue","value":"5"}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"contributions_where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"aggregate"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"avg"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"total"}}]}}]}}]}}]}},{"kind":"Field","name":{"kind":"Name","value":"variants_aggregate"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"distinct_on"},"value":{"kind":"Variable","name":{"kind":"Name","value":"distinct_on"}}},{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"Variable","name":{"kind":"Name","value":"order_by"}}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"aggregate"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"count"}}]}}]}}]}}]} as unknown as DocumentNode<VariantsListQuery, VariantsListQueryVariables>;
export const VariantDetailDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"VariantDetail"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"slug"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}},{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"contributions_where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"variants"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"ObjectValue","fields":[{"kind":"ObjectField","name":{"kind":"Name","value":"slug"},"value":{"kind":"ObjectValue","fields":[{"kind":"ObjectField","name":{"kind":"Name","value":"_eq"},"value":{"kind":"Variable","name":{"kind":"Name","value":"slug"}}}]}}]}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"IntValue","value":"1"}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"launch_date"}},{"kind":"Field","name":{"kind":"Name","value":"transmission"}},{"kind":"Field","name":{"kind":"Name","value":"fuel_type"}},{"kind":"Field","name":{"kind":"Name","value":"description"}},{"kind":"Field","name":{"kind":"Name","value":"specifications"}},{"kind":"Field","name":{"kind":"Name","value":"vehicle"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"type"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}}]}},{"kind":"Field","name":{"kind":"Name","value":"colors"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"attachments"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"attachment"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"url"}}]}}]}}]}},{"kind":"Field","name":{"kind":"Name","value":"contributions"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"ObjectValue","fields":[{"kind":"ObjectField","name":{"kind":"Name","value":"created_at"},"value":{"kind":"EnumValue","value":"desc"}},{"kind":"ObjectField","name":{"kind":"Name","value":"upvotes"},"value":{"kind":"EnumValue","value":"desc"}}]}},{"kind":"Argument","name":{"kind":"Name","value":"limit"},"value":{"kind":"IntValue","value":"1"}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"contributions_where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"total"}},{"kind":"Field","name":{"kind":"Name","value":"upvotes"}},{"kind":"Field","name":{"kind":"Name","value":"downvotes"}},{"kind":"Field","name":{"kind":"Name","value":"items"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"ObjectValue","fields":[{"kind":"ObjectField","name":{"kind":"Name","value":"price_item"},"value":{"kind":"ObjectValue","fields":[{"kind":"ObjectField","name":{"kind":"Name","value":"serial_no"},"value":{"kind":"EnumValue","value":"asc_nulls_last"}}]}}]}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"price_item"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"type"}},{"kind":"Field","name":{"kind":"Name","value":"category"}}]}}]}}]}}]}}]}}]} as unknown as DocumentNode<VariantDetailQuery, VariantDetailQueryVariables>;
export const VariantContributionsDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"VariantContributions"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"where"}},"type":{"kind":"NamedType","name":{"kind":"Name","value":"contributions_bool_exp"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"contributions"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"ObjectValue","fields":[{"kind":"ObjectField","name":{"kind":"Name","value":"created_at"},"value":{"kind":"EnumValue","value":"desc"}},{"kind":"ObjectField","name":{"kind":"Name","value":"upvotes"},"value":{"kind":"EnumValue","value":"desc"}}]}},{"kind":"Argument","name":{"kind":"Name","value":"where"},"value":{"kind":"Variable","name":{"kind":"Name","value":"where"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"total"}},{"kind":"Field","name":{"kind":"Name","value":"upvotes"}},{"kind":"Field","name":{"kind":"Name","value":"downvotes"}},{"kind":"Field","name":{"kind":"Name","value":"items"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"order_by"},"value":{"kind":"ObjectValue","fields":[{"kind":"ObjectField","name":{"kind":"Name","value":"price_item"},"value":{"kind":"ObjectValue","fields":[{"kind":"ObjectField","name":{"kind":"Name","value":"serial_no"},"value":{"kind":"EnumValue","value":"asc_nulls_last"}}]}}]}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"price_item"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"type"}},{"kind":"Field","name":{"kind":"Name","value":"category"}}]}}]}}]}}]}}]} as unknown as DocumentNode<VariantContributionsQuery, VariantContributionsQueryVariables>;