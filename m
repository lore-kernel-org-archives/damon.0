Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162830;
	b=Zl75m+BOZkP8/KbvTAO8OGGxczeKRp7FD8pVYizOLJmF1DkCwR5uUuMrTBT3UaHqNnUb
	 wAjVv1krZU7+ALt0jJrTionWxexhxcQ9h3rrjuz0lRDdcwjUVz/Oe6CktShEtArRkWK84
	 iWnVZjL2j3TorOefzqoZd0M2JjlP5ZWrkuAMEBav6wvzEnLOlFYPuFHZvth21ti9+wIEt
	 s2TY3q9cNRQfiS3xcM2qLaMKyERNvNEyYr8wJNV8eirl2wU6eBtoxoSU1MG3NL2bLei/I
	 LKXtA+fZhOkIl5081IFaMrBXrQqX9Cijp8uDqz2psk2tEjMgtfPS1x8f+zNJCB7b9Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ud3dyyf/JEY/R/2fhpQWVjOi5aq4aTlLAjlkAINyk4c=;
	b=G5XPz2DVoP4tsEAntjRnlc1LEO5xJr30bR9EXFWWeAvbRY9eYjlYHsJBQXiwh8EfixmU
	 c/aJ25MBs2dy3U4OlvxihrwIjG4X+m/tq3dYspg5JbUFefiLEOjc8WyUaGpD/y9R6e3FU
	 FkpU0HBkRXVlKQ1kr2BX/Xx3b35JTMo/9k72bFE15t6KXp9LHneZ6DNqoiZmVzO3gShNM
	 4V8GVL8ps2NUdvlqAH0AavFkF+yO7liXr09Sxf8A7PhvJ/zcxoy7+UilPE/RrBVZvW1Rg
	 2TWkCHR63soBaJddsmYC2T2x6BnC4JhUS/fD1ifbTjLxH1em2qimMFSUhuPYQnUlBwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfpoCA2I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93EA60A2602
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 08:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D93EA60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfpoCA2I
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso15944745e9.0
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:20:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795162827; cv=none;
        d=google.com; s=arc-20260327;
        b=ROK4rgpzSgOTybFMrK8qTWFrXPArzX0cnDMHuJnWNslcB5Aaz+2DwGDBa4nyID4bP/
         gg1zlWQ/rhJ4OmZgQbPzdbq8hymYCp/xj3melDPO66rKsUTy1YpzQKiiro7VGl486aj6
         lzK00wDI4muVkxiS6Wow0cI6WdP1kWGLhgZTmGoxOvTf7WdLkS3cqS9HElZ5vj4nSuFN
         DT7EIAJ9TPXNoZrfa1kTN28adAqUMKT93yxOtyFq6SMJ7Ay76ReoB3vzS/yPB4wqNeUH
         yqrWSkh9GhscoszmjMQH5fUEJ3cUw0EygsgjbC1fbIPGX6KJws4/tE7ZgdBYwGasny78
         CAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ud3dyyf/JEY/R/2fhpQWVjOi5aq4aTlLAjlkAINyk4c=;
        fh=sMSzmgecFneHWgO+BtFjA2PhWZ6HJ/WSwhspSNbbs5M=;
        b=Psrc6hzHI5mFLrD8woboitgqb+N/rXLB8xuo6tlSCoTLOq5n8vsulXCdN4TsZfqGfk
         KluYRVJpjB2YSG8GVH0cbWylM6cYGjzhhtZMAc8DVKeIUqotsDicuWYtL7eM20DsGVdU
         MqTzRFi06/NBM9hOU1W5z1EFOYoipVAz/L2YpHtPEawOPnB5R06InuPDseXyZHjqt8Wg
         0UpP0C4BtZtwrxKV4ZzqnWqBtffom/cwStjE57En6iztenSYiNPCmrt61pHLBz1eJ7wN
         z/BkZ0kjH+uRB4kAELGRTRVvsTHUeNsjiYOpHKKJj64wx/BIko1ZyWDp8PBlndDEh/NC
         o1xw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795162827; x=1795767627; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ud3dyyf/JEY/R/2fhpQWVjOi5aq4aTlLAjlkAINyk4c=;
        b=qfpoCA2IxtcVeoL4QTMGEK9+f0QTbULQkMp2fBV1GF8YOkVvZ1B8GtuJ1suLh0CwkB
         pQVgqETOtiiTZT2k7HJpQehZKSK8ncIq4YBzXs3t3IZkkYjvkdu5uwSC/rnYt/a476MS
         oXh6ZhMug+C0yEwoEUtw4azD3R9aZUK4xfKuJ/9JsELVt1CKo8Sz8qveZrDf7npFBmdb
         TE1NBaiQD75XsyAaqU5TPupbwx9YgVbOJcFL5Qi1lYAATZP8CPj+yOfOclVt02O3McrQ
         MTclJeh51Rx6J7Mc3tjue9BX63gYHH2kqipA0bqnoIxnRHYHtn230zOkw3dsuG5rJVKm
         Sgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795162827; x=1795767627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ud3dyyf/JEY/R/2fhpQWVjOi5aq4aTlLAjlkAINyk4c=;
        b=TE6y5aK3d+az6Uj+jKemJXFR13dyDDaYCEe4Th5Ev2nmReWCWGFjMoLtbkVrMXIGhH
         /BPiceRlSq6Zn+8FGikvsoF/1s5xN/AsFQLkls1UdpDg4KHCAVvhkY601si8R150pWc4
         BIMzfax9FbUrJchGaj/vTxx/u+DlTMytdQqqF2MX6fOvmB/9MPWFGEWI850UoK7lTs9/
         5jKj9KYEB/WHEuPA+b6UqkYPSnDthXW4tvrlnzoNcXRm5aeu1qw5UKk2Jxfhaf2nfJa8
         aZK57YQIo/vsJ+YMfq4G3hX1d1BbWBx4SCwi7prvg1AvzD7Hgas3H1TPIoPu63McOmmh
         kH5w==
X-Forwarded-Encrypted: i=1; AL+hErF6cR2fkcVxeuoohr7E80VOsEdQ0iVQwfcaOkBVX2VY/iIw2qwP2AUYnAfgHBnZGCIy7HYPRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+GuhU8L6n/SXMwyWICF2Gx/+89q+fbYgEdSckAkoF1le9DAIHk
	7ionhb+1bFUu8/38s9PveUv8cTIrX0NTO+DV1TYJ+OUecIjuvjpqWieS51PnCR13tRwpVpA/k+y
	0iLkNdFe0HN3YQ45AaaNhISl9jruYrCk=
X-Gm-Gg: AYBFou2FioWjY6vNva9O4Us6W+3I02NSQYM9ZdAnAw26w0zZCojOzRsOB0vNcijIRFS
	a/U/o3pfycmTNi/CXiaW+pcQhhHgnVaPOmh020B1yzrd2DU8kDeadbjjUS6O0eSMGYgVfaKx7m+
	O/5Y+YCd7MrMISyMh/JYknRy5tQTMR6VMi9nbFwb6ELxnXwPFLphLoc22KY/aXiI2b6ThaqYnjf
	lJj5j71PGkMzwyP0axyagMieiPgzMcwcczsEQPamrtsw+1FGiTpMuBPDIIATj+ynjiLejY+OdSZ
	3xNWjnsCZmM31tdBeAyCMB0fkWHe6jCmRnKSMgB9wouwcoTaMOX5eZo8BJ2/ZkqdkP5FAkpwbJo
	P8JAsf9Qq2REJ0Op3t4D5Bx18rfDb+hpllf9BlZpWJv9SpRXYpVj4dY3aeNCLQS6q
X-Received: by 2002:a05:600c:4504:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4bb887fc396mr47908935e9.3.1795162826538; Fri, 20 Nov 2026
 00:20:26 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-8-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-8-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 16:20:12 +0800
X-Gm-Features: AclHuK_oxtudcnoh95U_WO0vrwwpF-uDqqiNW6HAKd9dIMedRC4HEEVfEGFR52A
Message-ID: <CAN_Opa_3vb54=6pMeRfzBpTmXG0Bfprhjw8H1mzA8NZ4c51U-Q@mail.gmail.com>
Subject: Re: [PATCH v5 08/17] mm/mglru: move add/del LRU size accounting out
 of lru_gen_update_size()
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

On Thu, Nov 19, 2026 at 5:03=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Pure code shuffle, no behavior change.  lru_gen_update_size() now only
> updates the per-generation counters plus the promotion move; the
> addition and deletion active/inactive accounting move to
> lru_gen_add_folio() and lru_gen_del_folio(), which know the generation
> and can apply the active-window test directly.
>
> The unevictable case is untouched: unevictable folios never enter
> lru_gen_add_folio() and keep being accounted by lruvec_add_folio() as
> before.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 180db43c3a85..b15c3618a1f2 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -322,21 +322,9 @@ static inline void lru_gen_update_size(struct lruvec=
 *lruvec, struct folio *foli
>         if (new_gen >=3D 0)
>                 atomic_long_add(delta, &lrugen->nr_pages[new_gen][type][z=
one]);
>
> -       /* addition */
> -       if (old_gen < 0) {
> -               if (lru_gen_is_active(lruvec, new_gen))
> -                       lru +=3D LRU_ACTIVE;
> -               __update_lru_size(lruvec, lru, zone, delta);
> +       /* return now if not a promotion */
> +       if (old_gen < 0 || new_gen < 0)
>                 return;
> -       }
> -
> -       /* deletion */
> -       if (new_gen < 0) {
> -               if (lru_gen_is_active(lruvec, old_gen))
> -                       lru +=3D LRU_ACTIVE;
> -               __update_lru_size(lruvec, lru, zone, -delta);
> -               return;
> -       }
>
>         /* promotion */
>         if (!lru_gen_is_active(lruvec, old_gen) && lru_gen_is_active(lruv=
ec, new_gen)) {
> @@ -391,6 +379,8 @@ static inline bool __lru_gen_add_folio(struct lruvec =
*lruvec, struct folio *foli
>         int gen =3D folio_lru_gen(folio);
>         int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
> +       int delta =3D folio_nr_pages(folio);
> +       enum lru_list lru =3D type * LRU_INACTIVE_FILE;
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>
>         BUILD_BUG_ON(BIT(LRU_GEN_WIDTH - 1) !=3D MAX_NR_GENS);
> @@ -408,6 +398,10 @@ static inline bool __lru_gen_add_folio(struct lruvec=
 *lruvec, struct folio *foli
>         set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK | BIT(PG_active=
), flags);
>
>         lru_gen_update_size(lruvec, folio, -1, gen);
> +       if (lru_gen_is_active(lruvec, gen))
> +               lru +=3D LRU_ACTIVE;
> +       __update_lru_size(lruvec, lru, zone, delta);
> +
>         /* for folio_rotate_reclaimable() */
>         if (reclaiming)
>                 list_add_tail(&folio->lru, &lrugen->folios[gen][type][zon=
e]);
> @@ -432,6 +426,9 @@ static inline bool lru_gen_del_folio(struct lruvec *l=
ruvec, struct folio *folio,
>  {
>         unsigned long flags;
>         int gen =3D folio_lru_gen(folio);
> +       int zone =3D folio_zonenum(folio);
> +       int delta =3D folio_nr_pages(folio);
> +       enum lru_list lru =3D folio_is_file_lru(folio) * LRU_INACTIVE_FIL=
E;
>
>         if (gen < 0)
>                 return false;
> @@ -445,6 +442,9 @@ static inline bool lru_gen_del_folio(struct lruvec *l=
ruvec, struct folio *folio,
>         gen =3D ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
>
>         lru_gen_update_size(lruvec, folio, gen, -1);
> +       if (lru_gen_is_active(lruvec, gen))
> +               lru +=3D LRU_ACTIVE;
> +       __update_lru_size(lruvec, lru, zone, -delta);
>         list_del(&folio->lru);
>
>         return true;
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
