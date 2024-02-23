import { useCurrentUser } from '@/authentication/AuthContext';
import {
  DELETE_USER_PASSKEYS,
  DELETE_USER_TOKENS,
  FORGOT_PASSWORD,
  REGISTER_PASSKEY,
  VERIFY_PASSKEY_REGISTERATION,
} from '@/graphql/auth.gql';
import signinWithGoogleLink from '@/utils/signinWithGoogleLink';
import {
  ActionIcon,
  Button,
  Divider,
  Flex,
  PasswordInput,
  Stack,
  Text,
  TextInput,
} from '@mantine/core';
import { notifications } from '@mantine/notifications';
import { startRegistration } from '@simplewebauthn/browser';
import { IconBrandGoogle, IconCheck, IconEdit, IconKey, IconUserScan } from '@tabler/icons-react';
import dayjs from 'dayjs';
import { useMutation } from 'urql';
type AccountDetailsType = {};
const AccountDetails = ({}: AccountDetailsType) => {
  const { data: uData, fetchUser } = useCurrentUser();
  const [{ fetching, data }, deleteUserTokens] = useMutation(DELETE_USER_TOKENS);
  const [{ fetching: pFetching, data: pData }, deletePasskeys] = useMutation(DELETE_USER_PASSKEYS);

  const [{ fetching: fFetching }, forgot] = useMutation(FORGOT_PASSWORD);
  const [, register] = useMutation(REGISTER_PASSKEY);
  const [, verify] = useMutation(VERIFY_PASSKEY_REGISTERATION);
  return (
    <Stack>
      <Stack>
        <Text fw={500} c={'gray.7'} size="xl">
          Email & Password
        </Text>
        <Stack gap={'xs'}>
          <TextInput
            description="Email is just a way of reaching you, feel free to use any proxies if desired"
            readOnly
            label="Email"
            value={uData?.email}
          />
          <PasswordInput
            readOnly
            value={'**********'}
            label="Current Password"
            visible={false}
            rightSection={
              <ActionIcon
                loading={fFetching}
                onClick={async () => {
                  if (!uData?.email) return;
                  const { data } = await forgot({
                    identity: uData.email,
                  });
                  if (data?.forgotPassword?.success) {
                    notifications.show({
                      message: data?.forgotPassword?.message,
                      color: 'green',
                      withBorder: true,
                      autoClose: 9000,
                    });
                  }
                }}
                variant="white"
              >
                <IconEdit />
              </ActionIcon>
            }
          />
        </Stack>
      </Stack>
      <Stack>
        <Text fw={500} c={'gray.7'} size="xl">
          Social Login
        </Text>
        <Stack gap={'xs'}>
          <Flex justify={'space-between'}>
            <Flex gap={'sm'}>
              <IconBrandGoogle />
              <Text>Google</Text>
            </Flex>
            {uData?.google_id ? (
              <Button leftSection={<IconCheck />} variant="light" color="green" size="xs">
                Connected
              </Button>
            ) : (
              <Button
                component="a"
                href={signinWithGoogleLink(uData?.email)}
                variant="light"
                color="blue"
                size="xs"
              >
                Connect
              </Button>
            )}
          </Flex>
        </Stack>
      </Stack>
      <Divider />
      <Stack>
        <Text fw={500} c={'gray.7'} size="xl">
          Sessions
        </Text>
        <Stack gap={'xs'}>
          {uData?.tokens?.map((token) => {
            return (
              <Flex key={token.id} justify={'space-between'}>
                <Flex gap={'sm'}>
                  <IconKey />
                  <Text>
                    {token.client} (expires {dayjs(token.expires_at).format('D MMM YY hh:mm a')})
                  </Text>
                </Flex>
                <Button
                  loading={
                    data?.delete_user_tokens?.returning?.find((idx) => idx.id === token.id)
                      ? fetching
                      : false
                  }
                  onClick={() => deleteUserTokens({ where: { id: { _eq: token.id } } })}
                  color="red"
                  variant="light"
                  size="xs"
                >
                  Revoke Session
                </Button>
              </Flex>
            );
          })}
        </Stack>
      </Stack>
      <Divider />
      <Stack>
        <Flex gap={'sm'}>
          <Text fw={500} c={'gray.7'} size="xl">
            Passkeys
          </Text>
          <Button
            variant="light"
            size="xs"
            onClick={async () => {
              const { data } = await register({ name: 'MalikBagwala' });
              const registrationOptions = data?.passkeyRegisterOptions?.data;
              const credential = await startRegistration(registrationOptions);
              const { data: vData } = await verify({
                credential: JSON.stringify(credential),
              });
              const tokens = vData?.passkeyRegisterVerify?.data?.tokens;

              if (tokens) {
                fetchUser({ requestPolicy: 'network-only' });
                notifications.show({
                  icon: <IconCheck />,
                  message: vData?.passkeyRegisterVerify?.message,
                  color: vData.passkeyRegisterVerify?.success ? 'green' : 'red',
                });
              }
            }}
          >
            Create New
          </Button>
        </Flex>
        <Stack gap={'xs'}>
          {uData?.passkeys?.map((passkey) => {
            return (
              <Flex key={passkey.id} justify={'space-between'}>
                <Flex gap={'sm'}>
                  <IconUserScan />
                  <Text>{passkey.description}</Text>
                </Flex>
                <Button
                  loading={
                    pData?.delete_user_passkeys?.returning?.find((idx) => idx.id === passkey.id)
                      ? pFetching
                      : false
                  }
                  onClick={() => deletePasskeys({ where: { id: { _eq: passkey.id } } })}
                  color="red"
                  variant="light"
                  size="xs"
                >
                  Revoke Passkey
                </Button>
              </Flex>
            );
          })}
        </Stack>
      </Stack>
    </Stack>
  );
};

export default AccountDetails;
