Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162854;
	b=VjPx82OvIryP8QwaqzgdWrxYwFMHS9i70x1SfIJ/hTvZSK5kfA6MOe9zR27EPLh5xIq+
	 VaUuPOTP2HgtBBJUJOsnllI+3t64Sy85O+2/jh740JWOriBNCFJEE7zUWAiJRZRFhOG7P
	 y2qhwvg6kgCr5ATEDYRWLZB0ee5yaVsaZcr33IeQWR3BQs2/LYD+uc65HaPWMe1198zwV
	 KxWzDUkZtEAOLZBbLjMeSE32iTWnSRRwQA+Rgw74o7G8G+jqiPDg4WePordAE5DwTN/68
	 QUnHXc7aUYDfN6pPtu9up5/pVuzxsHpjDt0Sqx/rGyUxlE1bEU5FK96nJ6mtysOqJNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dg/jopXxk1E9Yu4E4faWsNPyyS6g9t3vWRabNCt8U08=;
	b=tnpdYo73Dz92SuLx3R44ynXBgFDJRpQ1+YJWwjv4j4YBFoh31JTiMeAs+JWkDUIBWaVb
	 8sIeHA3IoKnlmfInT5vmIWfshc5JpopQJQYDjZ6Qa2gtAOKx9tFVPIPZ/3AzTkDV2uOQG
	 m2uczjd6X6OfpTOsX8wfQ2+ROj0GDtncksgAL/duTT6TDdAn0BKdmDfRkAkcCYxc1nsQ4
	 j/JS+QsqqAu/xu0y6VdRHlla3O7ld2Ye77IPJwBgrtECKi2UtYDuZDJGY+s1okb24d9Pc
	 qMo14xxbk+qpoeSE6dF/siRSubIoBe23RS2caxwlyzbHC9XDaQbYEQG6dqRbR5KGO8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z2vvzpsB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65157606A339
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 08:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65157606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z2vvzpsB
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so5336215e9.2
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:20:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795162853; cv=none;
        d=google.com; s=arc-20260327;
        b=bn5yE74j3zEV8CID103z3W1zfjM9xrao19lEu5gE6vebHwuAgvpUf+m0szSidtSjOk
         s2DVYUqOPHvbJizIFsVUsf/IHN3XLelTPArhhrrN1DWTtmBW0sCznkf5vqeVF4LZHIky
         yDL1tIKI0Ehskrh0wUc1oM5+kI2JGiUJkocDD8yOw/gQ2yDyMaB6SEL3M4dpDd0O7QcS
         xA+5roAUumXLZlocbEpyUuF7SKZ9NkPhmbnBaBbeTg+RU7Lumg3+DMqzlpFsKWfkLmQp
         rqcSC1v+ym8KKLK2yEWOtHTaVlbmYk7z6BRMzByya01D93VbsBtnV+u7znIZqOy3sUDn
         A5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dg/jopXxk1E9Yu4E4faWsNPyyS6g9t3vWRabNCt8U08=;
        fh=w3PkElNHQdB8vZbeg/z/+EKo80+Uotr5ADY1S/tMfWw=;
        b=PCpRf5Dv0p6EQh6SHCcGfdvEyUiS/8E20I1aIlPjlGsW9C9W8ED6GASlg4KB/0CjmF
         /OO0lfED29E8w90SVZ1DmEoLQguzK3gXJD8baa1nv4HDdGeQdAna0TeCG4aAGaDPLCh9
         xz7SXJwSVoafsf6SRi7lND9NxiAzpnckOX5HiBqIOhseoGcWaR8nAtXHLTysGSzPeI2Q
         0cVL/5TdtBYF5DQV1gcSW214ndudGhv7MjEY4nO6QrNE5Jv6wXeAt3H2WNu2OHdcaeZ0
         sFYP8NJBUPynsq5jfxMuHUIO1c2dmJEaaGHbFnzJRsa6G6UpnF7Ev/Xkpl9rP5mWXgA4
         FccA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795162853; x=1795767653; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dg/jopXxk1E9Yu4E4faWsNPyyS6g9t3vWRabNCt8U08=;
        b=Z2vvzpsBj3KTAAsA3dqAlkhIAwBWFxesGyDVK9wmULMFJLx43NfZTCMPgqb5KkRKKg
         sM+UogUAmqSatmDyh9fPxXuxSvN8iqtcLAb5JoG9wh/LqFfwD29PsV11KImZejF7nEoa
         wtLo4WGuHRJtNS+0gg87Z+5BanIaXKm1B5PT2JN34NgxG4DP0IEwMILtoihlIoN8OHbX
         W79M2FX9ZyuvVF/yPjw60kH02vz7S/lmg+rJRzOCq6ppzPHtPXKawxf+T25DCu2KNUsP
         +W7ZWekVSw/neeA5bpGRiyenwLLy7OUlu25aR7bi/ujKj6hRpAZZJ3CR4F9bqi3HrcZL
         FqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795162853; x=1795767653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dg/jopXxk1E9Yu4E4faWsNPyyS6g9t3vWRabNCt8U08=;
        b=bSpRVXPABF4t9UPgps+M8U4y75pinuwv6hdeKlO/iVVv+AqwD9WJtEey+GYkxoMBXk
         UNoZ3JyAuF3+Xus5v3DfZi+NgmfGCfg2n+kleCNUhDK7T1NC5qI+KFcVSVYruqFOtBK6
         M8FdL9UFuf7pqlXnuZAaJLdRcLRD3xIxQsLe+4zHTW1srlEbRTAeWF+sXAurwD6L8IQ9
         uk98BBAuHORhgiJtzDa0uE/vkPxblvO8+qIiTkzv/pYA87a3RHTuRvhV+sjoDv4tdYdB
         4K7tr0gg4Osk59Jo+9m7LM/OFN46M4/39rtD+lWK5QQJ2u/xiSiQC6/WnWOrBvQQKEht
         zE+Q==
X-Forwarded-Encrypted: i=1; AL+hErHG5aY/ihfCQcZeuqgBrQ/1V5tOikLd7HKLK9HK3rCAQ56vmgWBZeyGkF1ujIPonjmaKOqlow==@lists.linux.dev
X-Gm-Message-State: APuU4Z8evyJVNihY1uzcu7zrScO7+1J3PCqPpualnLwSAnR9uS9O8fcN
	5HZ+3hnP28TYFSC3eINzgDaF6Chs/0Y2VE1NlTRKc+Wr9wuWuh7StbM4/ZjBvJZi3lLO0sU59Do
	bT1ntGN1Mq75xUKBWG7RvzZs3aMjocNs=
X-Gm-Gg: AYBFou3SSU9f1hl1jzia69iap1uYPHI6JuO9ntaVX0Z+YRn6dW+Jp1mZy8flWWqBqQ+
	bTIbddO3Xm0UZfOhIRG9R7bxaX5XmIRKcxWrcaU5+NIuKq6WxfIXqkGvTosRJ0UbDxTfiSUI7hp
	DdaC+iufVsUhFb6VD27aefbww1+CO7W+r6LmPHZnn1uIUJlzVXUQ1gPdkoNsFtMvRZh1W0kWNW8
	8KQMvEtCesk4RjvDOIfDBJawBUq0A6UsqKLd+TQzsUrcdFRJuPPRjFfsOfVHX1sS3bZbZ+s/kyx
	0X1h4d/rfWQUJ+OH1ayKDn0Z4MxSDNtbf8bkX3fqRXKKUAd9ifkh0to8J4kfhegf76biBopkMUB
	+kJO6pNzb+5WTSs9Fw6OWmDpld9slDQRtHR9mAXbc0aPxGF/4tQBBBJNqnZ7VDglhT9loXCjBfa
	6WnIOvKrzF
X-Received: by 2002:a05:600c:5303:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4bb88785d2fmr48529755e9.0.1795162852274; Fri, 20 Nov 2026
 00:20:52 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-9-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-9-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 16:20:40 +0800
X-Gm-Features: AclHuK--KpLypcFnORd8WwLwhQcGdUQKeMSvpl7k7o-cD-MnrCJ80Uob7th_vPU
Message-ID: <CAN_Opa9CuEB4NiE_+c=033ziMxqo243Ev3JB0_ctgk27kD-GsQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/17] mm/mglru, gup: mark folios referenced via a fast helper
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
> Introduce folio_inc_lru_refs_fast(): raise refs from 0 to
> LRU_REFS_REFERENCED via cmpxchg, or just set PG_referenced for the
> classical LRU as before. No counter update or promotion is needed,
> nonzero refs are left unchanged.
>
> This helper only aims to be fast, it exists so the gup fast path can
> stay a fast path. The new helper doesn't account refs above
> LRU_REFS_REFERENCED but that's fine for now as GUP never used that
> or anything similar for CLRU either.
>
> Convert the gup fast-path sites. No behavior change for classical LRU.
> There isn't any regression for MGLRU either.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h | 25 +++++++++++++++++++++++++
>  mm/gup.c                  |  6 +++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index b15c3618a1f2..3323a3c7336b 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -483,6 +483,31 @@ static inline bool lru_gen_del_folio(struct lruvec *=
lruvec, struct folio *folio,
>  }
>  #endif /* CONFIG_LRU_GEN */
>
> +/**
> + * folio_inc_lru_refs_fast - Bump folio refs count without promotion.
> + * @folio: the folio
> + *
> + * Raise refs from 0 to LRU_REFS_REFERENCED and leave hotter folios
> + * untouched. For the classical LRU, a plain PG_referenced set.
> + */
> +static __always_inline void folio_inc_lru_refs_fast(struct folio *folio)
> +{
> +       unsigned long new_flags, old_flags;
> +
> +       if (!lru_gen_enabled()) {
> +               folio_set_referenced(folio);
> +               return;
> +       }
> +
> +       old_flags =3D READ_ONCE(*folio_flags(folio, 0));
> +       do {
> +               if (lru_get_refs_flags(old_flags))
> +                       break;
> +               new_flags =3D old_flags;
> +               lru_set_refs_flags(&new_flags, LRU_REFS_REFERENCED);
> +       } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flag=
s));
> +}
> +
>  static __always_inline
>  void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
>  {
> diff --git a/mm/gup.c b/mm/gup.c
> index 2b405cce2ca5..596e62954659 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2911,7 +2911,7 @@ static unsigned long gup_fast_pte_range(pmd_t pmd, =
pmd_t *pmdp,
>                         gup_put_folio(folio, 1, flags);
>                         goto pte_unmap;
>                 }
> -               folio_set_referenced(folio);
> +               folio_inc_lru_refs_fast(folio);
>                 pages[nr_pages] =3D page;
>                 nr_pages++;
>         } while (ptep++, addr +=3D PAGE_SIZE, addr !=3D end);
> @@ -2980,7 +2980,7 @@ static unsigned long gup_fast_pmd_leaf(pmd_t orig, =
pmd_t *pmdp,
>
>         for (i =3D 0; i < nr_pages; i++)
>                 *(pages++) =3D page++;
> -       folio_set_referenced(folio);
> +       folio_inc_lru_refs_fast(folio);
>         return nr_pages;
>  }
>
> @@ -3022,7 +3022,7 @@ static unsigned long gup_fast_pud_leaf(pud_t orig, =
pud_t *pudp,
>
>         for (i =3D 0; i < nr_pages; i++)
>                 *(pages++) =3D page++;
> -       folio_set_referenced(folio);
> +       folio_inc_lru_refs_fast(folio);
>         return nr_pages;
>  }
>
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
