export interface LiveActivityPlugin {
  start(options: { name: string; start: Date }): Promise<{ value: string }>;
}
