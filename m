Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462086;
	b=Y5K+UunfsGGNDnYjWy+WpPhloIpyERJKaMGrVTtgCVD9dhUBRhHQFUdVcQo/ksnE07ln
	 9YBpdsipt/HfaCC381R1e3ZlenrWz6ziHU60Gp0YgW8qHMO1kskhKEGYxfzGjL8Rl7Kkc
	 awqNCUyk8DdLGUBVO6BPg6lekg31Mog8LrlXGA8T/fPCKlEBs7m429pc2r7b0AzEOPR0b
	 UB4vXicNzKGY/l7kDw9wbW/erTpZBksBsnlMLb0MIg/duq2y6pVJnV/CqoCMArGhJGNhC
	 YR8miLNWwcoq06KofgVLzPq5uTVh75QEDwR/fUbTEXtLB79cIbt5R9ow+3YrGlf9Uhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462086;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CANnW+hAEMIUmX34omHKhF3VfiVjx1PL/iyRq31vyR0=;
	b=G/pNcwEkgt0rl5MHODZQlxgns4C9eqvpmuXx412L7oN1cDs1P5Ed3Ue6mVLA0719iaIe
	 W/UEsKGzw6Y6WtWCsdGEVqzGkk4uZj1LYjJqimSL1oOn3fabx9E24C1BNKdu2szN+Ywuo
	 VGz876DHItt63HNLw8afM19xIC7I1r8Il2KRNNMQE6r1iwRy0mp1pklHFdOq8FuVEUbHu
	 KcI24kfJCtvrJQJd18n7IzpNNUy3SX+T79PCElqnlhX0WQljIrhBVZaGWD3Axav5czXIQ
	 cBcgseMzDUoBetmzh3VGz8iL7X6Pvrxh4TcY7XNyRZ9RqVxJVqDdkxEXlO2Fh+KjU9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HfT0zD/j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624C606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfT0zD/j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BC81F000CF;
	Mon, 23 Nov 2026 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462085;
	bh=CANnW+hAEMIUmX34omHKhF3VfiVjx1PL/iyRq31vyR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HfT0zD/juyN6xv5uFFkYHlcPwpyemnxygXuuBV69fH5F93NiuC3S5nsi04gtls2Kf
	 aDwMi/wwTRBUijC4Yj5di034UazCkmIwMKzpaLwAVamywYicfgQi54V1A2UvUbhtbn
	 tP6CZfccI6yTmwywI6uV95nsr84xPKBKPEKCiENE6J0tPrCS7xmW5VoupAkyGtOMtz
	 AAEpXf3bP6XJvN5hisL8AECJkcmxQ9CrdBZ4BLCBfslCUPoRIF2Cq0CQiokQ0A0voZ
	 gv77Gw8JWZLYQ8U7Vkrqg67+jp+6XN7Wy9ZcrUN8Ff93G9pykYZBgWuALhiQzLnOpL
	 4Ch7p+ulS3D3g==
Message-ID: <sashiko-outbox-229933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/18] mm/mglru: folio LRU refs based active/inactive
 number accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>, linux-mm@kvack.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>, "Muchun
 Song" <muchun.song@linux.dev>, "Qi Zheng" <qi.zheng@linux.dev>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Chris
 Li" <chrisl@kernel.org>, "Baoquan He" <baoquan.he@linux.dev>, "Nico Pache" <nico.pache@linux.dev>, "Usama
 Arif" <usama.arif@linux.dev>, "Michal Hocko" <mhocko@kernel.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Barry Song" <baohua@kernel.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>, "Wei
 Xu" <weixugc@google.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Nhat Pham" <nphamcs@gmail.com>, "Youngjun
 Park" <youngjun.park@lge.com>, "Zi Yan" <ziy@nvidia.com>, "Gregory Price" <gourry@gourry.net>,
 =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev
 Jain" <dev.jain@arm.com>, "Lance Yang" <lance.yang@linux.dev>, "Hugh
 Dickins" <hughd@google.com>, "SJ Park" <sj@kernel.org>, "David Rientjes" <rientjes@google.com>, "Yu
 Zhao" <yuzhao@google.com>, "Vernon Yang" <vernon2gm@gmail.com>, "Zicheng
 Wang" <wangzicheng@honor.com>, "Tal Zussman" <tz2294@columbia.edu>, "Kairui
 Song" <ryncsn@gmail.com>, "Xiang Liu" <liuxiang.277@bytedance.com>, "Ehab
 Ababneh" <ehab.ababneh@intel.com>, "Zhao Zhenzhuo" <zhaozhengzhuo@uniontech.com>, "Lian
 Wang" <lianux.mm@gmail.com>, "Joanne Koong" <joannelkoong@gmail.com>, "Kunwu
 Chan" <kunwu.chan@gmail.com>, "Hui Zhu" <hui.zhu@linux.dev>, "Maxim
 Muzafarov" <maxmuzaf@gmail.com>, damon@lists.linux.dev, "Tianyi Chen" <hi@tychen.cc>, "Ridong
 Chen" <ridong.chen@linux.dev>, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <20261124-mglru-fg-v6-17-8ffea39934a6@tencent.com>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-17-8ffea39934a6@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:28:02 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm/mglru: extra atomic RMWs on folio->flags in
  lru_gen_del_folio()
--

commit c2fa4ccd879e2b2e8e7542ec52e0fe26798b936c
Author: Kairui Song <kasong@tencent.com>

mm/mglru: folio LRU refs based active/inactive number accounting

This commit switches MGLRU active and inactive LRU size accounting from
the generation window to per-folio LRU reference counts based on the
LRU_REFS_ACTIVATED threshold.

> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index a4daf366e6aa7..b0f062e3a1905 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h

[ ... ]

> @@ -440,24 +445,33 @@ static inline bool lru_gen_add_rejected_folio(struc=
t lruvec *lruvec, struct foli
>  static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio=
 *folio, bool reclaiming)
>  {
>  	unsigned long flags;
> -	int gen =3D folio_lru_gen(folio);
> +	unsigned int refs;
> +	int gen;
>  	int zone =3D folio_zonenum(folio);
>  	int delta =3D folio_nr_pages(folio);
>  	enum lru_list lru =3D folio_is_file_lru(folio) * LRU_INACTIVE_FILE;
> +	unsigned long max_seq =3D READ_ONCE(lruvec->lrugen.max_seq);
> =20
> +	/* Keep LRU_REFS_FLAGS: refs carry access history across isolation */
> +	flags =3D set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK, 0);
> +	gen =3D lru_get_gen_flags(flags);
> +	refs =3D lru_get_refs_flags(flags);
>  	if (gen < 0)
>  		return false;
> =20
>  	VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
>  	VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
> =20
> -	/* for folio_migrate_flags() */
> -	flags =3D !reclaiming && lru_gen_is_active(lruvec, gen) ? BIT(PG_active=
) : 0;
> -	flags =3D set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK, flags);
> -	gen =3D ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> +	/*
> +	 * See the comment in lru_gen_folio_seq.  For migration, compaction,
> +	 * or any other isolation of a hot folio, try best to retain its gen
> +	 * info. Ideally we would keep the full gen info.
> +	 */
> +	if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_NR_GENS)
> +		folio_set_active(folio);

[Severity: Medium]
Does moving set_mask_bits() before the gen < 0 check and splitting out
folio_set_active() add unnecessary atomic RMWs on folio->flags in
lru_gen_del_folio()?

set_mask_bits() unconditionally runs a try_cmpxchg() loop even when the
masked bits are already zero, so every lruvec_del_folio() call when MGLRU
is disabled at runtime (or on unevictable folios) now performs an atomic
RMW instead of returning after a READ_ONCE() check.  When MGLRU is enabled,
non-reclaim deletions of folios in the two youngest generations (such as
__page_cache_release() in folios_put_refs(), which immediately clears
PG_active via __folio_clear_lru_flags()) also execute two atomic RMWs
(set_mask_bits() followed by folio_set_active()) instead of combining
clearing LRU_GEN_MASK and setting PG_active into a single try_cmpxchg()
loop after checking gen < 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-mglru-fg-v=
6-0-8ffea39934a6@tencent.com?part=3D17
