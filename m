Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157212;
	b=0JschYEk/tmgcrLSLjM+4cEx7TpF1axC3sNuoEkdoGYG2LJ67MQVVbreHYWaopEYfqbQ
	 xu8fzErQEpvV8tRI1nrji44WAbdtEakniXOnA+LQg6c2d0zrQf+FWk7R2bRz18G/fEaX9
	 yH31Kayxq64tPvoscwkW5b/CYB76SqBWi898+YFPQt0KZf8xtDJlKqApVo512AFlYz+ve
	 L54NcQPK+6FmH7rPagYV+JsxkRFbea8OlJt4k8qqkL+EaHVMzdyvXRfBIR3Vth1da+TD/
	 uQ/X/BqlGh+37ll49cv+3+8D72bE4zB3vYBkWXprbt8F4lYOlVxsuORDJk8FLk/UdYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yh5Pw6Ns7Cwi6C95SoPvU5P8PiEbr6Awtt6kTXpPyU8=;
	b=knu7i8/ctqveR4lm0Iu0+K3xavk0DKJlFc8WMFuluo/nPOiryC25bQR0KS/Z+poQy2Xb
	 ZncrkV/G9Tw8ffa/Pfk/Tx4l9fcnOErOXiKET+IPCxiVYei0ODyJLIjMaJW2xaejSpD5z
	 3N+9dHj8rrVu+fe1BXOKrkOK8qDVP7UMlyoxM9R+Z/V8Z3+2NIXECrL7rdb7bpSwHQbMY
	 Xasn5tMClJrJGTng4NvFth/qhlukIx7kQZPmr77gYMzIIpcilwzOMFnX4/fs/HowTt+Oc
	 svVICk+86Qkv+64x/ui1TRJE0CklSvOl3YCgG2dQAskGtLUS6AzyQDEhtpWtqz4+8Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="L+V/AJ/E";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A1606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E42A1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L+V/AJ/E
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso5581255e9.0
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 22:46:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795157210; cv=none;
        d=google.com; s=arc-20260327;
        b=TnKg/4S3L0Ihrt+cKOD1odlS5F7cbVTYCiebC1tP4bTrRbydUuIjeheA+ac2erJFVx
         9j+akqEIc6rCW7ljQJQ9MnWvIZjQuK5vBjj8HcSg6OvpvWyifKFTCEOdZU8i/Zm/LvNe
         2eCOaQ12C42vXmjZxSIW4D7kvToUaiHPQ9ILgGgmtdoXhqEd4dUdhWlKuBRp+DblrqzY
         Wux6y4rUwKV+ej3xNUEREV3y2iKNSMHClmiPYXOt3nuSR8KetwyczRiam2WR9JglTsqG
         FghdgDqsC1HksVsw9feGQMsPHVSXt0AVfdiynvk4COxvABzQFS+TzGPaZmj7Xfg9NAXE
         Il2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yh5Pw6Ns7Cwi6C95SoPvU5P8PiEbr6Awtt6kTXpPyU8=;
        fh=1R6Z87pRD15aF4Hi3E2KsI0Msf8+u2mOeb3fGgbKksg=;
        b=LPGsrL8HeSAl7hMIhcy3QzV/Pcl6kfqEjJgfRrgFtM76DSH0JIWzwbLtuUehhU/v6G
         aSMGfeFBpdmnNFXqoQ1mt1/m7KtL9I3ZjidELSZHMx5bhvZdRTbbX4LrM2D3VnduOvAG
         x8ivOqFXKXi+J3s6t9yAnAKuQsOhjvohrC+kxUXPt4/MR2f+IO+pI/eoGhajRNX7z56t
         tU+b2lOW3GnMHvq3vuxCkV/bdDVl4iqleqjFWmbAwKApd1GvB/W0NkNcUh03PoPAJpdg
         cTfknFlMC+sB3NRtdTpWj9BobB8L9z+ZxKOZG0S7KXAdMCyLDy1gV5Y+AiJNvhwJL9tM
         l4/w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795157210; x=1795762010; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yh5Pw6Ns7Cwi6C95SoPvU5P8PiEbr6Awtt6kTXpPyU8=;
        b=L+V/AJ/EFin0GgCNE2sJTrJYdFKswUTuiM8htYLM1XH25OGKqBm56AhcWrCLHfeUJZ
         SPNUa9FwJNBY8vBufylZOraK+5KRLMUVN8wKaL6Znlbh4l0Nygq2yeEp5/mHQMf3g1ha
         bG0FGQtOb78l1FNXC06tSRd/0UskD8V3P3cb3cafVSUUjpsOI2jl717wO6/gaaStvojx
         6KwTMwaNF0HUDRayXSvriZygd/U05KZVt8WcTSjH+mfHR7IkfE/ahru/tBLkoWr6BOq/
         8DHaj4nBjVsrE0KOxqUxcWSe3g6BRKHUKXjg5kBZ0DP++jzSJ/VJuUoe+vc5OV6U+UeR
         gBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157210; x=1795762010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yh5Pw6Ns7Cwi6C95SoPvU5P8PiEbr6Awtt6kTXpPyU8=;
        b=W7roFL1a/fAjbmDIcFYN4Q2vKam86x/KeN0wvb31A/TNhaOCqjpV1xJ+cS9CpdyOuY
         xq1k1q6YeYjDJ39U4ZI2LG/IociTWC8fJWEQad9af3G3mhUWyldhdoZo42+iP0PqdUXp
         FXa+UvTeviBlGJZAD6b188IHjdwdYMO/z+HVrA6Af9wW8KYTpyoOLW40rTTgorLqmr6f
         icK50GnJ6WY7Kcq2fmujCUDu+VgKwSWh2KN6qEcWcEAGhvKQf4PiUUG/Evmzk2byegky
         7lYUfvcdRpkM2qrVQF8LkbSppPsLmeeq3/GQ+d6+hGoy1EST9UKSkFwK9Q/TkcS5O+Nb
         XPTA==
X-Forwarded-Encrypted: i=1; AL+hErEo+tVhUPTLTUrhQLHgA90lgIsc704souZrjLd7OnqqyHVrvnYl10cmRCtG6HsAWcmUGEElyw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/iDfWIK7f7cz5A5brCtb2liohxOoFg9w91jqHmmhwo9gof+VHj
	fZqJVndiHLJFB038m5Z0QJs0gPHbiwuYwCednv5WCnllqxcvP9aKJM5thTGniap56ji5voQLURq
	lJWBoSj/xrhzhmvXD5cjyW9wGgeXbAQ8=
X-Gm-Gg: AYBFou3yI3ZJE+MoAcGyfF3uENBWuse5XyiutXMJ7s0IJmSqQo0VUs9Z8+VFO8DQXTi
	FaC27+94qBz0XVhPJfpYcX/6tTepO6qQ+P//zRzKNwCZVY15lRIEZtojh4nLCe7kAbdUTPE+OaM
	o3fOXjWJjfLuHoyXFTKR2C6CGt1dPWwYLP9T6pEpEODZrJIF0fqccs+0KIz1o//kXw2MFBLuOTZ
	sEusSnSWTNZB4gQQLa5Xj8riEOEPhLCSdQMKfhkt1/KslSj6ifIhbYxQ1O0cxCF3F6UsIgnr8sv
	IMVVR7xYBWldKMdpmw6Jb6N9i5AvwY+YpoZHFXg/9UfUk1+4xJktCID31B1oWUmPJDs1JzGX7dQ
	F8jEyd/uGFosJ2qgr8UoPpVJGCEyF5WXo7rxWuRtQVY6MU6Ngjqf+pu9ty7OvQfBF
X-Received: by 2002:a05:600c:1c08:b0:4bb:7757:fe6d with SMTP id
 5b1f17b1804b1-4bb88804c5fmr50882955e9.11.1795157209745; Thu, 19 Nov 2026
 22:46:49 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 14:46:37 +0800
X-Gm-Features: Aa3M54q6diJBPt5X49YJ4xjQARO39_f1G-0YmFpyFCjvJebbL7DyzQ2TCjNUNR8
Message-ID: <CAN_Opa9Gu56Tdx2WVrYZU95BrHdGg0+gf2mpv25gM7WCRULJ0g@mail.gmail.com>
Subject: Re: [PATCH v5 01/17] mm/mglru: rename the generation offset in lru_gen_folio_seq()
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

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

On Thu, Nov 19, 2026 at 5:03=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> lru_gen_folio_seq() computes how many generations below max_seq a folio
> should be added to, but stores it in a variable named "gen". Elsewhere in
> MGLRU "gen" means an index into lrugen->folios[], i.e. seq % MAX_NR_GENS,
> so reusing the name for a relative offset is confusing.
>
> Rename it to "age", which matches what the value means: the newest
> generation is age 1, and a larger age is an older generation.
>
> No functional change.
>
> [kasong: dropped the comment table part, the series rewrites it]
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index f6f4bc9a704f..2395ca8ee305 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -302,7 +302,7 @@ static inline unsigned long lru_gen_folio_seq(const s=
truct lruvec *lruvec,
>                                               const struct folio *folio,
>                                               bool reclaiming)
>  {
> -       int gen;
> +       int age;
>         int type =3D folio_is_file_lru(folio);
>         const struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>
> @@ -319,17 +319,17 @@ static inline unsigned long lru_gen_folio_seq(const=
 struct lruvec *lruvec,
>          * |<---------------------------- MAX_NR_GENS -------------------=
--------->|
>          */
>         if (folio_test_active(folio))
> -               gen =3D MIN_NR_GENS - folio_test_workingset(folio);
> +               age =3D MIN_NR_GENS - folio_test_workingset(folio);
>         else if (reclaiming)
> -               gen =3D MAX_NR_GENS;
> +               age =3D MAX_NR_GENS;
>         else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(foli=
o)) ||
>                  (folio_test_reclaim(folio) &&
>                   (folio_test_dirty(folio) || folio_test_writeback(folio)=
)))
> -               gen =3D MIN_NR_GENS;
> +               age =3D MIN_NR_GENS;
>         else
> -               gen =3D MAX_NR_GENS - (folio_test_workingset(folio) || fo=
lio_test_referenced(folio));
> +               age =3D MAX_NR_GENS - (folio_test_workingset(folio) || fo=
lio_test_referenced(folio));
>
> -       return max(READ_ONCE(lrugen->max_seq) - gen + 1, READ_ONCE(lrugen=
->min_seq[type]));
> +       return max(READ_ONCE(lrugen->max_seq) - age + 1, READ_ONCE(lrugen=
->min_seq[type]));
>  }
>
>  static inline bool __lru_gen_add_folio(struct lruvec *lruvec, struct fol=
io *folio,
>
> --
> 2.56.1
>
>
