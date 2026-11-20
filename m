Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167730;
	b=0YSztuVWR4jQGt/DWh/qm8tZTJWVjqwyL89AGt9tq5GXwUY8nShSeIbI8HwOqwqDB1i8
	 smvdP5539uRHE2wGkjJVtC4F4pPN3+4H9shN/5yyxUa0ryHi971j49SRQR3LYskwttO55
	 AqEQmiexniwzn8uD76HvwyUyakLM6Os6EDzUW2rQxXS72cs8ccfVzW/Fj4WgW/2aqNEHl
	 5cm1zEKFX8tW6FS8ciB1HQNsD4vAoV6YCVgffp74DQraZ26ZbsfNGAEHdWI0P2zq89RRI
	 J1nHm79LGS05Q3WJefr3+dC30pqCiTTJ8nXlZ42FsmKI25uCrzcKORNQrg67fFcjefQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nJLDjnNZ35RdFcdsO967xBDkpagvrglUg9dZPRYG/C8=;
	b=1l15vNLsC/LkYt0HsjovdAP14yTTqgYj+gY6XoYCKuarb/q8x/X+mUlAN9Af3Azm1FPB
	 Pl73c+SOt61/FB6NuvRXp6kmx7F0VinIzyuiMEClllvWBWyf9zCxMCaJV/4mCm8Ix9odW
	 LLWvmhaA8T9dMJMSrzSRTV8CMBsnBlSIujKlgI9iLiN7lplHjOkP+zqXtm8IYDR6iPTsl
	 ZXnN65rEs7qJWdy8r/1bAkz/w2CS4E8kBOz1p2lO2He3wbdGwZMbi4d89MunIRbdb+rwH
	 Y1s/xqZO6f5caZXmDqpdUk+uXxPOJ6e3WtMdFckM5EmxP0doiE1PNAltvSL+H6Og4GQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcQBGFS6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5587606A325
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 09:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5587606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcQBGFS6
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49465892f7bso534942f8f.1
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 01:42:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795167728; cv=none;
        d=google.com; s=arc-20260327;
        b=fZ0V/5iq3zcsE/96ee5Hp/n/p3SLc4JF5xaiBLwlkZeaDs1qkQX9IuSyi3qF+IWQdF
         AHzG+Rdy2Y34VJwfHrZ2s1UDsPxXrq5+9JFSPDWV6Dw9QBW7s3gHPZ1oyJQuqWpEtlGu
         YSFTRahTNema7EmM/nUKUVv1Z+w8QDy+dWYMLwFUPgTyYV24e9zFEUMDbARpbv/fVxbR
         syZa7FAhZsQBTmIPiJre9v8i6titmk8Y6FxA2JSXFnjwPfV+87dHoqd2JE70yriy2ov/
         tSqR8yV3lN8OwIm3nuczw0ArvxyuBMCvHtT3PLqieoirJYglbE6Toe71Q1k9qXrIyRz5
         hMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nJLDjnNZ35RdFcdsO967xBDkpagvrglUg9dZPRYG/C8=;
        fh=LM41CiQFAAOk2spHuhaBe47L/ihmP5Pg957obcH7i5E=;
        b=XVIEyOR2gC7Cr3bWaFdH45eMahdsLkkmF8O7A+DV2O2En6Bot2/SxI6k7/b8vF0MMW
         x1dF1xLqvne1sFv0JfnpdvFuTwcOrQc1Y1pvgrtkhy4YAc+cLQS1JwPESl14cJ0odWe0
         n8AnBk/DKWAf0ho0vjUjUbPSrcSeD15ezFNQnjdt8UCmIjQfYdt1i4ymuByKvNZ1ydJS
         NQfDX5/sRGvsiMdEwLr0Ce0QNEaYbizHxQdT5ZzPMFNO1/+hDhZnkTWQU+nB2Byl/gNS
         mb7SAR6CejSo0LjQnGNMnNfbNAVynOtb11ZLdAkLheACJmYDBqCh8LATfWXln1JnGDql
         IVdQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795167728; x=1795772528; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nJLDjnNZ35RdFcdsO967xBDkpagvrglUg9dZPRYG/C8=;
        b=OcQBGFS68BblFrb2yYyTNZFRwqIbqwPjCnbbLhlnJGW/opDvSbswDZYvp9hq1fSHPG
         UxW4koTomsY6tFaQ2YG3KKcDqaAMp3vZUXHOQuiJTy5EweQGhFIQWVZmyudhh1f5Q8/s
         uA2L9ZH9No+VqMrmaaxBpTjWSMqqBDNRdXMHMARdISbETR/8NPaZUFjwFiYOWC+RiiKE
         jt/QndGdaSsov2PTnjA8oW5PcnxsJ4NQOwAtPKwmPJaHV8mZfP5U1C6BCRla/8kxMF5c
         NIONT6aqMa2jq55PZ9bVHLLuCVxBALJmehMvsr8bARH/RCPv8usEhmI18O9hmLLMO9cZ
         nLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795167728; x=1795772528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nJLDjnNZ35RdFcdsO967xBDkpagvrglUg9dZPRYG/C8=;
        b=wHwSxufPRy3F9IfrEGVz6kTk0i/3Oz2IcYdqPFKwEpyMsH0LkWyczstdKzshiSMfQv
         5LvaN7bJM759EkuL6PM1AyMvPf3wr7dvQv2Ub/2DTKckfC7aqKa7hOSGi6rKrW5TTMej
         biCE9h+GcRHHjDt8WCscvCdHwl1hBVSs6CJbNAJ122QgJj56OANiM7lYAscpNK1gPzAe
         tlWSZB/g3vIW2Di9P9qGvDArh2a7+04bpUyb3guIVzbyiz2OJ2iy8WnJ6u/a6WLAiZrN
         YToX+UQBNASkCFQlgfEuTesEH8yIHZKJKzm6i3vfgjJCdYk/Ii7sxHsp/ICQW9MT+mmP
         Nthw==
X-Forwarded-Encrypted: i=1; AL+hErH1gbPFIkeerD9LAR0YpxotGOhzQ/2kmcKVaFCeqoweRdKO3wD602Vc+Pcjd53mNORVz2XRZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+gZ2PHgqrJfIHjV+QLUyvq0AfKBpnBeaHt8yBvJa1qw2r+X6WQ
	hYkc7N5RJxpbMs3GYDQ+0WXmm6MgI5E38TtDK7IbSgkz6dbXrrJmkqGQXchK+feIqhuNgpIRo3S
	hMJUnJJxTx5E304NwHKndk1AT1EZqykg=
X-Gm-Gg: AYBFou0RhsBH/qMdYQHACNVLIymx4WaMbrG6lrR0riadMoc5eX88V6Bgiak9WmJHV+9
	5LDQlTtFn9D5EHdo4zqGTzRTRkuuFBph5rkKSlU/O67porZAosuwP8YFXInhYxCPb8lGbDqCBEp
	o7oSDiHOehgvU2DUWe2ZrIHMor63U6tWZ4O/Vg+T5b02OdAXzGUmAxBQDHtEVAu95I3Ff5Smvho
	leUZ+1UeF+J4KrM9an+ZW85Yr7yc5DbN++8SJEe2/mv1vtbRGAPaPyp50ypEPSNbFq1dHAYqeQB
	/Nh3aMzrvjDO/5qDd344CumDHn8NiHmPzbansxw7ouKdziRIQ5VEelTF7WYsaUMKWg7Mo2w85vB
	CfW4zFaZ6F3zITXYksEXCXT2cyrH2/l8Iss4JmW4ijD0=
X-Received: by 2002:a05:600c:1d1d:b0:4bb:73ad:c1f0 with SMTP id
 5b1f17b1804b1-4bb88812b0cmr58328185e9.23.1795167727989; Fri, 20 Nov 2026
 01:42:07 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-16-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-16-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 17:41:54 +0800
X-Gm-Features: Aa3M54oYjUSUM675Gm3euCp0JmfduimCijFMBt2l5Ov01ZX35R428bhh5tZMXzI
Message-ID: <CAN_Opa-+nb0vxQ+HsENCG2fEEMZoxG9Sy_DBC4CLkWjNLzDWKw@mail.gmail.com>
Subject: Re: [PATCH v5 16/17] mm/mglru: make folio_inc_lru_refs lruvec lockless
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:04=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> The lruvec spinlock in folio_inc_lru_refs was only taken to keep
> concurrent aging from corrupting the size counters.  This is no
> longer needed: the per-generation counters are atomic, and the
> active/inactive ABI counters are updated per folio and linearized by
> the CAS on the folio flags, so concurrent aging can no longer corrupt
> them.  The same argument is what lets folio_reset_lru_refs() update
> the counters without the lruvec lock.
>
> Use folio_lruvec_live_get()/folio_lruvec_live_put() to hold the RCU
> read lock around the lruvec lookup, and drop the spinlock entirely.
>
> Without the lock, aging can advance max_seq while a promotion is in
> flight.  Generations are indexed by seq % MAX_NR_GENS, so the folio
> flags can return to the value read earlier and the cmpxchg succeeds
> with a target gen computed from a stale max_seq.  Recheck max_seq after
> a gen-changing cmpxchg: if it moved, account the committed update and
> retry with LRU_REF_FORCE, which promotes the folio to the newest gen.
> The retry may count the access twice, which is acceptable and avoids
> folio_activate(), whose LRU lock causes latency jitter.  smp_rmb()
> orders the flags read, including the one returned by a failed
> cmpxchg(), before the max_seq read.
>
> Also simplify the post-CAS accounting guards: gen is only assigned
> non-negative values after the old_gen < 0 early exit, so gen !=3D old_gen
> implies gen >=3D 0, and lru_gen_update_size() needs no explicit guard.
> The active/inactive ABI update keeps its gen >=3D 0 check because an
> off-LRU folio has no lruvec to update.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h | 10 +++++-----
>  include/linux/mmzone.h    |  3 ++-
>  mm/vmscan.c               | 51 +++++++++++++++++++++++++++++------------=
------
>  3 files changed, 39 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 77f514143266..2c6cbd0df686 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -317,10 +317,9 @@ static inline bool lru_gen_is_old(struct lruvec *lru=
vec, int type, int gen)
>                gen =3D=3D lru_gen_from_seq(min_seq + 1);
>  }
>
> -static inline void lru_gen_update_size(struct lruvec *lruvec, struct fol=
io *folio,
> -                                      int old_gen, int new_gen)
> +static inline void lru_gen_update_size(struct lruvec *lruvec, int type,
> +                                      struct folio *folio, int old_gen, =
int new_gen)
>  {
> -       int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
>         int delta =3D folio_nr_pages(folio);
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> @@ -399,7 +398,7 @@ static inline bool __lru_gen_add_folio(struct lruvec =
*lruvec, struct folio *foli
>         /* use the refs from the atomic snapshot to avoid raced update */
>         refs =3D lru_get_refs_flags(flags);
>
> -       lru_gen_update_size(lruvec, folio, -1, gen);
> +       lru_gen_update_size(lruvec, type, folio, -1, gen);
>         if (lru_refs_is_active(refs))
>                 lru +=3D LRU_ACTIVE;
>         __update_lru_size(lruvec, lru, zone, delta);
> @@ -429,6 +428,7 @@ static inline bool lru_gen_del_folio(struct lruvec *l=
ruvec, struct folio *folio,
>         unsigned long flags;
>         unsigned int refs;
>         int gen;
> +       int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
>         int delta =3D folio_nr_pages(folio);
>         enum lru_list lru =3D folio_is_file_lru(folio) * LRU_INACTIVE_FIL=
E;
> @@ -452,7 +452,7 @@ static inline bool lru_gen_del_folio(struct lruvec *l=
ruvec, struct folio *folio,
>         if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_NR_GENS)
>                 folio_set_active(folio);
>
> -       lru_gen_update_size(lruvec, folio, gen, -1);
> +       lru_gen_update_size(lruvec, type, folio, gen, -1);
>         if (lru_refs_is_active(refs))
>                 lru +=3D LRU_ACTIVE;
>         __update_lru_size(lruvec, lru, zone, -delta);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 2680e15b6de9..235fb04f8d78 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -540,9 +540,10 @@ enum lruvec_flags {
>  #define LRU_TIER_MIN           0U
>  #define LRU_TIER_MAX           (MAX_NR_TIERS - 1)
>
> -/* Access source flags for folio_inc_lru_refs() */
> +/* Flags for folio_inc_lru_refs() */
>  #define LRU_REF_MAPPED         0x1U
>  #define LRU_REF_EXEC           0x2U
> +#define LRU_REF_FORCE          0x4U
>
>  #define LRU_REFS_REFERENCED    0x1
>  #define LRU_REFS_WORKINGSET    0x2
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 78a1b4de7076..4576a7a369e3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -876,37 +876,35 @@ void folio_inc_lru_refs(struct folio *folio, unsign=
ed int flags)
>         long nr_pages =3D folio_nr_pages(folio);
>         struct lru_gen_folio *lrugen;
>         struct lruvec *lruvec =3D NULL;
> +       bool aged =3D false;
>
> +retry:
>         old_flags =3D READ_ONCE(*folio_flags(folio, 0));
>         do {
>                 new_flags =3D old_flags;
>                 old_gen =3D lru_get_gen_flags(old_flags);
>                 old_refs =3D lru_get_refs_flags(old_flags);
> -               file =3D folio_flags_is_file_lru(&old_flags);
>                 refs =3D old_refs + 1;
>                 gen =3D old_gen;
> +               file =3D folio_flags_is_file_lru(&old_flags);
>                 if (old_gen < 0)
>                         goto out;
> -               /*
> -                * Lock the lruvec if the folio is on-list. We are alread=
y
> -                * doing lazy promotion so in theory we don't need this,
> -                * but for now, concurrent aging would still corrupt the
> -                * size counters.  This is a temporary limitation and
> -                * will be lifted very soon, so the lock here is not a
> -                * performance concern.
> -                */
>                 if (!lruvec) {
> -                       lruvec =3D lruvec_live_lock_irq(folio_lruvec(foli=
o));
> +                       lruvec =3D folio_lruvec_live_get(folio);
>                         lrugen =3D &lruvec->lrugen;
>                 }
> +               /*
> +                * Read the flags before max_seq, paired with the store o=
f a
> +                * gen, which samples max_seq first.
> +                */
> +               smp_rmb();
>                 max_seq =3D READ_ONCE(lrugen->max_seq);
>                 max_gen =3D lru_gen_from_seq(max_seq);
>                 if (old_gen =3D=3D max_gen)
>                         goto out;
> -
> -               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC)) {
> -                       /* Promote second page table access or executable=
 */
> -                       if (refs > LRU_REFS_REFERENCED || flags & LRU_REF=
_EXEC)
> +               if (flags & (LRU_REF_MAPPED | LRU_REF_EXEC | LRU_REF_FORC=
E)) {
> +                       if (lru_refs_is_workingset(refs) ||
> +                           flags & (LRU_REF_EXEC | LRU_REF_FORCE))
>                                 gen =3D max_gen;
>                         /* First access only defers eviction of an old ge=
neration */
>                         else if (lru_gen_is_old(lruvec, file, old_gen))
> @@ -931,9 +929,19 @@ void folio_inc_lru_refs(struct folio *folio, unsigne=
d int flags)
>                         break;
>         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flag=
s));
>
> -       if (gen !=3D old_gen)
> -               lru_gen_update_size(lruvec, folio, old_gen, gen);
> -       if (lru_refs_is_active(old_refs) !=3D lru_refs_is_active(refs) &&=
 old_gen >=3D 0) {
> +       if (gen !=3D old_gen) {
> +               /*
> +                * Gen-index reuse can fool cmpxchg(). Retry locklessly, =
accepting
> +                * an extra reference to avoid folio_activate() latency.
> +                */
> +               if (unlikely(READ_ONCE(lrugen->max_seq) !=3D max_seq)) {
> +                       flags =3D LRU_REF_FORCE;
> +                       aged =3D true;
> +               }
> +               lru_gen_update_size(lruvec, file, folio, old_gen, gen);
> +       }
> +
> +       if (lru_refs_is_active(old_refs) !=3D lru_refs_is_active(refs) &&=
 gen >=3D 0) {
>                 enum lru_list lru =3D file * LRU_INACTIVE_FILE;
>
>                 __update_lru_size(lruvec, lru + lru_refs_is_active(old_re=
fs),
> @@ -941,8 +949,12 @@ void folio_inc_lru_refs(struct folio *folio, unsigne=
d int flags)
>                 __update_lru_size(lruvec, lru + lru_refs_is_active(refs),
>                                   folio_zonenum(folio), nr_pages);

Could this leave the parent's local active count too high?
Isolation can debit the child's active count after the refs
2 -> 3 CAS. If CSS_DYING is set before the stats update, the credit
can go to the parent. On SMP, reparenting can clamp the child's
negative local count to zero.

Thanks,
Kunwu

>         }
> +       if (aged) {
> +               aged =3D false;
> +               goto retry;
> +       }
>         if (lruvec)
> -               lruvec_unlock_irq(lruvec);
> +               folio_lruvec_live_put(lruvec);
>  }
>
>  /*
> @@ -3517,12 +3529,13 @@ static int __folio_inc_gen(struct lruvec *lruvec,=
 struct folio *folio,
>  /* protect pages selected by the tier PID controller */
>  static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, int=
 old_gen)
>  {
> +       int type =3D folio_is_file_lru(folio);
>         int new_gen;
>         bool gen_increased;
>
>         new_gen =3D __folio_inc_gen(lruvec, folio, old_gen, &gen_increase=
d);
>         if (gen_increased)
> -               lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> +               lru_gen_update_size(lruvec, type, folio, old_gen, new_gen=
);
>
>         return new_gen;
>  }
>
> --
> 2.56.1
>
>
