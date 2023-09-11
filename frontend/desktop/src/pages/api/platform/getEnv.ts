import type { NextApiRequest, NextApiResponse } from 'next';
import { jsonRes } from '@/services/backend/response';
import { enableGithub, enableWechat, enablePassword, enableSms } from '@/services/enable';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const wechat_client_id = process.env.WECHAT_CLIENT_ID || '';
  const github_client_id = process.env.GITHUB_CLIENT_ID || '';
  const service_protocol = process.env.SERVICE_PROTOCOL || '';
  const private_protocol = process.env.PRIVATE_PROTOCOL || '';
  const needGithub = enableGithub();
  const needWechat = enableWechat();
  const needPassword = enablePassword();
  const needSms = enableSms();
  const callback_url = process.env.CALLBACK_URL;

  jsonRes(res, {
    data: {
      SEALOS_CLOUD_DOMAIN: process.env.SEALOS_CLOUD_DOMAIN || 'cloud.sealos.io',
      wechat_client_id,
      github_client_id,
      callback_url,
      service_protocol,
      private_protocol,
      needPassword,
      needSms,
      needGithub,
      needWechat
    }
  });
}