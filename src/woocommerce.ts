// ✨IntelliCommerce✨ Woo MCP - WooCommerce API Client
// Made with 🧡 in Cape Town 🇿🇦
// Powered by Xstra AI✨ | Enabled by IntelliCommerce✨

import axios, { AxiosInstance } from 'axios';
import * as https from 'https';

let client: AxiosInstance;

export function initWooCommerce() {
  const baseURL =
    process.env.WOOCOMMERCE_API_URL || 'your_woocommerce_store_url.com';
  const consumerKey =
    process.env.WOOCOMMERCE_CONSUMER_KEY || 'your_consumer_key';
  const consumerSecret =
    process.env.WOOCOMMERCE_CONSUMER_SECRET || 'your_consumer_secret';
  const isInsecure = process.env.WOOCOMMERCE_INSECURE_HTTP === 'true';

  if (!baseURL || !consumerKey || !consumerSecret) {
    throw new Error(
      '❌ Missing required WooCommerce configuration. Please check your environment variables.'
    );
  }

  client = axios.create({
    baseURL: `${baseURL}/wp-json/wc/v3`,
    httpsAgent: isInsecure
      ? new https.Agent({ rejectUnauthorized: false })
      : undefined,
    timeout: parseInt(process.env.API_TIMEOUT || '30000'),
    auth: {
      username: consumerKey,
      password: consumerSecret
    }
  });

  console.log('🔗 WooCommerce client configured with basic authentication');
}

// Initialize WooCommerce when this module loads
initWooCommerce();

// Add a helper to make authenticated requests
export async function makeWooCommerceRequest(
  method: 'GET' | 'POST' | 'PUT' | 'DELETE',
  endpoint: string,
  params?: any
) {
  try {
    const response = await client.request({
      method,
      url: endpoint,
      ...(method === 'GET' ? { params } : { data: params }),
    });
    return response.data;
  } catch (error: any) {
    console.error(
      `WooCommerce API Error (${method} ${endpoint}):`,
      error.response ? error.response.data : error.message
    );
    throw new Error(`WooCommerce API Error: ${error.message}`);
  }
}
