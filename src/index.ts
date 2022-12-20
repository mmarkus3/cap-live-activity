import { registerPlugin } from '@capacitor/core';

import type { LiveActivityPlugin } from './definitions';

const LiveActivity = registerPlugin<LiveActivityPlugin>('LiveActivity');

export * from './definitions';
export { LiveActivity };
