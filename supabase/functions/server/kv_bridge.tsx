import { createClient } from "jsr:@supabase/supabase-js@2";

const client = () => createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

export const get = async (key: string): Promise<any> => {
  const supabase = client();
  if (key.startsWith("wallet:")) {
    const userId = key.split(":")[1];
    const { data } = await supabase.from("ippoo_market_wallets").select("balance").eq("user_id", userId).maybeSingle();
    return data ? { balance: data.balance } : null;
  }
  if (key.startsWith("order:")) {
     const parts = key.split(":");
     const { data } = await supabase.from("ippoo_market_orders").select("*").eq("id", parts[2]).maybeSingle();
     if (!data) return null;
     return { ...data, userId: data.user_id, shippingAddress: data.shipping_address, paymentMethod: data.payment_method, total: data.total_amount, escrowStatus: data.escrow_status };
  }
  if (key.startsWith("user-kv:")) {
     const [_, userId, type] = key.split(":");
     if (type === "addresses") {
        const { data } = await supabase.from("ippoo_market_user_addresses").select("*").eq("user_id", userId);
        return data ?? [];
     }
     if (type === "preferences") {
        const { data } = await supabase.from("ippoo_market_profiles").select("preferred_language").eq("id", userId).maybeSingle();
        return { language: data?.preferred_language || 'fr' };
     }
  }
  if (key.startsWith("pin:")) {
     const userId = key.split(":")[1];
     const { data } = await supabase.from("ippoo_market_profiles").select("metadata").eq("id", userId).maybeSingle();
     return data?.metadata?.pin;
  }
  if (key.startsWith("groups:public:")) {
     const id = key.replace("groups:public:", "");
     const { data } = await supabase.from("ippoo_market_groups").select("*").eq("id", id).maybeSingle();
     if (!data) return null;
     return { ...data, organizerId: data.organizer_id, priceNormal: data.price_normal, targetQty: data.target_qty, maxParticipants: data.max_participants, expiresAt: data.expires_at };
  }
  if (key.startsWith("devis:")) {
     const id = key.replace("devis:", "");
     const { data } = await supabase.from("ippoo_market_devis").select("*, responses:ippoo_market_devis_responses(*)").eq("id", id).maybeSingle();
     if (!data) return null;
     return { ...data, buyerId: data.buyer_id, targetVendorIds: data.target_vendor_ids, acceptedResponseId: data.accepted_response_id };
  }
  const { data } = await supabase.from("kv_store_cc347259").select("value").eq("key", key).maybeSingle();
  return data?.value;
};

export const set = async (key: string, value: any): Promise<void> => {
  const supabase = client();
  if (key.startsWith("wallet:")) {
    const userId = key.split(":")[1];
    await supabase.from("ippoo_market_wallets").upsert({ user_id: userId, balance: value.balance, updated_at: new Date().toISOString() });
    return;
  }
  if (key.startsWith("order:")) {
    await supabase.from("ippoo_market_orders").upsert({
        id: value.id,
        user_id: value.userId,
        shipping_address: value.shippingAddress,
        payment_method: value.paymentMethod,
        total_amount: value.total,
        status: value.status,
        escrow_status: value.escrowStatus,
        updated_at: new Date().toISOString()
    });
    return;
  }
  if (key.startsWith("user-kv:")) {
     const [_, userId, type] = key.split(":");
     if (type === "addresses") {
        await supabase.from("ippoo_market_user_addresses").delete().eq("user_id", userId);
        if (Array.isArray(value) && value.length > 0) {
           await supabase.from("ippoo_market_user_addresses").insert(value.map(v => ({ ...v, user_id: userId })));
        }
        return;
     }
     if (type === "preferences") {
        await supabase.from("ippoo_market_profiles").update({ preferred_language: value.language }).eq("id", userId);
        return;
     }
  }
  if (key.startsWith("pin:")) {
     const userId = key.split(":")[1];
     const { data: profile } = await supabase.from("ippoo_market_profiles").select("metadata").eq("id", userId).maybeSingle();
     const metadata = { ...(profile?.metadata || {}), pin: value };
     await supabase.from("ippoo_market_profiles").update({ metadata }).eq("id", userId);
     return;
  }
  if (key.startsWith("groups:public:")) {
     const id = key.replace("groups:public:", "");
     await supabase.from("ippoo_market_groups").upsert({
        id,
        name: value.name,
        product: value.product,
        organizer_id: value.organizerId,
        price_normal: value.priceNormal,
        target_qty: value.targetQty,
        max_participants: value.maxParticipants,
        expires_at: value.expiresAt,
        status: value.status,
        participants: value.participants,
        updated_at: new Date().toISOString()
     });
     return;
  }
  if (key.startsWith("devis:")) {
     const id = key.replace("devis:", "");
     const { responses, ...rest } = value;
     await supabase.from("ippoo_market_devis").upsert({
        id,
        buyer_id: value.buyerId,
        products: value.products,
        target_vendor_ids: value.targetVendorIds,
        deadline: value.deadline,
        location: value.location,
        notes: value.notes,
        status: value.status,
        accepted_response_id: value.acceptedResponseId,
        updated_at: new Date().toISOString()
     });
     if (responses && Array.isArray(responses)) {
        for (const r of responses) {
           await supabase.from("ippoo_market_devis_responses").upsert({
              id: r.id,
              devis_id: id,
              vendor_id: r.vendorId,
              vendor_name: r.vendorName,
              price: r.price,
              lead_time: r.leadTime,
              notes: r.notes,
              items: r.items
           });
        }
     }
     return;
  }
  await supabase.from("kv_store_cc347259").upsert({ key, value });
};

export const del = async (key: string): Promise<void> => {
  const supabase = client();
  if (key.startsWith("groups:public:")) {
     const id = key.replace("groups:public:", "");
     await supabase.from("ippoo_market_groups").delete().eq("id", id);
     return;
  }
  if (key.startsWith("devis:")) {
     const id = key.replace("devis:", "");
     await supabase.from("ippoo_market_devis").delete().eq("id", id);
     return;
  }
  await supabase.from("kv_store_cc347259").delete().eq("key", key);
};

export const getByPrefix = async (prefix: string): Promise<any[]> => {
  const supabase = client();
  if (prefix === "order:") {
     const { data } = await supabase.from("ippoo_market_orders").select("*");
     return (data ?? []).map(d => ({ ...d, userId: d.user_id, shippingAddress: d.shipping_address, paymentMethod: d.payment_method, total: d.total_amount, escrowStatus: d.escrow_status }));
  }
  if (prefix.startsWith("order:")) {
     const userId = prefix.split(":")[1];
     const { data } = await supabase.from("ippoo_market_orders").select("*").eq("user_id", userId);
     return (data ?? []).map(d => ({ ...d, userId: d.user_id, shippingAddress: d.shipping_address, paymentMethod: d.payment_method, total: d.total_amount, escrowStatus: d.escrow_status }));
  }
  if (prefix === "groups:public:") {
     const { data } = await supabase.from("ippoo_market_groups").select("*");
     return (data ?? []).map(d => ({ ...d, organizerId: d.organizer_id, priceNormal: d.price_normal, targetQty: d.target_qty, maxParticipants: d.max_participants, expiresAt: d.expires_at }));
  }
  if (prefix === "devis:") {
     const { data } = await supabase.from("ippoo_market_devis").select("*, responses:ippoo_market_devis_responses(*)");
     return (data ?? []).map(d => ({ ...d, buyerId: d.buyer_id, targetVendorIds: d.target_vendor_ids, acceptedResponseId: d.accepted_response_id }));
  }
  const { data } = await supabase.from("kv_store_cc347259").select("value").like("key", prefix + "%");
  return data?.map(d => d.value) ?? [];
};

export const mget = async (keys: string[]): Promise<any[]> => {
  const supabase = client();
  const { data } = await supabase.from("kv_store_cc347259").select("value").in("key", keys);
  return data?.map(d => d.value) ?? [];
};
