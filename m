Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614460;
	b=bWtMM2OVzSuPMCURkcoskFYW7KgUyGasFrvEHViAxY6HZKM4Y4tfgODSb4tYt+EhD2ME
	 JOqfSlkrF8Qs2kWQBTU5li5CKC/UiOsJnb8RtFtnKEwaB/klZsMWso3BOxY2lpg5q0RIo
	 A5Z7y+BYPUd0sp3r/gULS20O0U1+o0niqI4Wr6H2JAXNzh8FOOpRF3rPOlgSTrvfQdGmb
	 qnmzHeqzUFXV7/WR+ka83OUX+ILsRmCvVb+d22khbMgdjFKlC0S+Pp8lVUTv0QDyaIxbi
	 RLD2yjBUxiWQpSNE7LeXz3lD1ubsVe4lek2xcs6yszSvit25F3GESAHPgo8sQL8apxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tNd0IbaZQFJuxJS+R9ayDKLW68Bcl2zYZx6i5ipU+qg=;
	b=twH2e2d+ePBpEb2OhS+gmRkzpfJhE+wJJ6jUhFFoGHKVF1s5e9JYR4xY9cJgWFFaNNi0
	 +qo12YqHjyfNhmprJ3Q34Nf05H7DlJtXRMJUymNFfOgEkUDvz5IrF9zEVz4wS5cP0SWzc
	 UzszVFJfwYT64AaNZqf112Z9M3bqdp3sYsTAnAFPusrpEqgVHSL9PZuG0znURonzaI6GW
	 0x52QukSxQFm5zav3/PqmzYdgK3Jg3nYxxxwjA2h3iUGD17l3OItP+XnfyixtKOskZxeh
	 vRyDq37j/mEoHChwOchg7Z9g6pgSfmbUVIsAesR3sTlWnxsAHUMf7NuJ0k97CrFOsmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shqN1e9b;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26660606A327
	for <damon@lists.linux.dev>; Wed, 25 Nov 2026 13:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26660606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shqN1e9b
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso3162634a91.1
        for <damon@lists.linux.dev>; Wed, 25 Nov 2026 05:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795614458; x=1796219258; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tNd0IbaZQFJuxJS+R9ayDKLW68Bcl2zYZx6i5ipU+qg=;
        b=shqN1e9bBChhYg+27RgllV/Z8OJK7siQ7KR/S1B/DBd7rplQQiGfiSgBEfC4Ed5yBq
         e+f0y7QkGv5iVKwqHcshgKNlWluS6CwH3uS3Awo/YteUdiuKeyHgMP3TCv3JAlC6QIWk
         jThyKCIjLDizObwbyPiVISh3YQBRe98OQxoXltB3J4MAuzynEqkX96SWpW6FgClFI+C9
         b99FP7UAtPHB4B6QTHMVjldMsttMe+3T4ZCaz5QVYDJfKYxRVekJxZVmk8REkMsW7NlF
         8kPU8jQzA/Q46O5UtH2q8kmy5ssYTRsMs9s/dt9eqQF7tGRH6TNSfca997uiXOAeEQ/X
         /LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614458; x=1796219258;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNd0IbaZQFJuxJS+R9ayDKLW68Bcl2zYZx6i5ipU+qg=;
        b=HH85V5COza24Pm280CYH1dRDKboZ6dqoPo7J4j9g0seBi170GdTC4khmzGXog3aB8j
         kR+RFzFUUbBvtm+nXTNT1HutuK48s6AH17qdtutpqX3DM2Ca5Rsgaun1wPAWqSz/aBQi
         U2SNdVgcljRvdSxzzNGD9+OanD0hgtkNWPZKJXTmGIt9NrHtDMOLJ5HprQNwujUhFdfA
         kBNPt1MGk00k5h24l4Ufms1qTq2OR3pfLfaTtKmHMwCWyqnPDUKAUqbvI9Ib0lCksMXx
         53wlzbZpKuOGW4MMio7cv4o45JVsYk2DrJDcmHZRZBMfRtakcIC9yMbTAOGJkcbfl6e3
         jemA==
X-Forwarded-Encrypted: i=1; AL+hErGMIE3/Hv3YRvG0GwLr0hew7NhSWZD9XelcefFk0YD5Ox8dNwDbGDL1lATnUDorm728IFSsOA==@lists.linux.dev
X-Gm-Message-State: APuU4Z++BLYxh+1IUdOiLTFdAjF3ZZOuQrXJwbnpZUpLMUKZfogVf736
	tKplgrXpEqFO7t31oVFZN9Gc2gELNK+Ipy/6zCGeyrWGvsxfiG3CkNna
X-Gm-Gg: AZFdTZfaV6+ezAHq6/MQF4t+veL1mZAW89IObB93d9aXqU615mzkKK03ap51X+DWZKg
	qfp8dOsz20vq07Sy7tHTlLulhenANyje5sjOAqV26TbER2xOx/nTVLs9IorFnX2F9KAJtvwaUr3
	SHH2fSDLZGb1gf11iJvrThSL7doYaVGrFfu+PucGXUhabpDqKvs9SShNUCr1x/NS38MMtgeFTqZ
	PhJHszF5Zna8LU+mOZmWLk6vK62JZjCvMOGS7BxtviER33kAJfwr7fr4ID4188kCB5ceTj9EMd8
	GN6xVh55tVbQlvIEeoN1oo+YmE/XQr4Qv/8t1T/mRKavdujafLyVQZOWDcLBPl4fm6/nlslyYXB
	+fRiV9fZ+p27fJso0QEQpTqITrYrUIIyUSm0m2oxM+ydftVrvornh1zcAmlBzllXwH2vuFtCIiD
	1p820jJc76ap0fjXvY0N6DTYcMeIAEHZZvHM7wZ3XZZXno2I/NMkeSE4mS1G7sH9pAnBs3r1Qqy
	F90rv3QcNoc+gSNsucxqnC73F305Z9In0pPRApAXuX4YTgoURjvRcG6tPKmHj0+sW+FQsPS+0oC
	mmx4V6tqG4Sn3cvNO2w4hkq+GXyp+hZ7xNrIUBzTz0sA
X-Received: by 2002:a17:90a:d2cf:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3b41c8e0507mr11255737a91.8.1795614458296;
        Wed, 25 Nov 2026 05:47:38 -0800 (PST)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7d36bcsm11786323a91.3.2026.11.25.05.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:47:37 -0800 (PST)
Date: Wed, 25 Nov 2026 21:47:18 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Hugh Dickins <hughd@google.com>, SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, 
	Yu Zhao <yuzhao@google.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Tal Zussman <tz2294@columbia.edu>, Kairui Song <ryncsn@gmail.com>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Subject: Re: [PATCH v6 10/18] mm/mglru, gup: mark folios referenced via a
 fast helper
Message-ID: <6c3d32a9-3004-4a17-b854-7088e69f164a@gmail.com>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-10-8ffea39934a6@tencent.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-mglru-fg-v6-10-8ffea39934a6@tencent.com>

On Tue, Nov 24, 2026 at 02:53:02AM +0800, Kairui Song via B4 Relay wrote:
> From: Kairui Song <kasong@tencent.com>
>
> Introduce folio_inc_lru_refs_fast(): raise refs from 0 to
> LRU_REFS_REFERENCED via cmpxchg, or just set PG_referenced for the
> classical LRU as before. No counter update or promotion is needed,
> nonzero MGLRU refs are left unchanged.
>
> The classical path is taken for a folio that is off the gen lists while
> MGLRU is off, not on lru_gen_enabled() alone: while MGLRU is being
> turned off, a folio can still be on a gen list after the static key
> flips, and setting PG_referenced there would bump its refs count.
>
> That check uses lru_get_gen_flags(), so move the helper out of the
> CONFIG_LRU_GEN block, it is now built with the option off, where
> LRU_GEN_WIDTH is 0 and LRU_GEN_MASK is zero. Keep the decoded value in
> an int so the subtraction of the offset-by-one encoding cannot fold to
> ULONG_MAX before it happens to avoid -Woverflow error with CONFIG_WERROR.
>
> This helper only aims to be fast, it exists so the gup fast path can
> stay a fast path. The new helper doesn't account for refs above
> LRU_REFS_REFERENCED but that's fine for now as GUP never used that
> or anything similar for CLRU either.
>
> Convert the gup fast-path sites. No behavior change for classical LRU,
> no regression for MGLRU either. Just prepare for the following changes
> by providing a helper that follows the new convention.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h | 62 +++++++++++++++++++++++++++++++++++------------
>  mm/gup.c                  |  6 ++---
>  2 files changed, 49 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index b15c3618a1f2..13c8b6bce349 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -105,6 +105,22 @@ static __always_inline enum lru_list folio_lru_list(const struct folio *folio)
>  	return lru;
>  }
>
> +/**
> + * lru_get_gen_flags - Return the LRU generation number from folio flags.
> + * @flags: folio flags
> + *
> + * Returns: A number between 0 and (MAX_NR_GENS - 1), inclusive. Returns
> + * -1 if the flags indicate the folio is off the list (e.g., isolated).
> + */
> +static inline int lru_get_gen_flags(unsigned long flags)
> +{
> +	int gen = (int)((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF);
> +
> +	/* The gen is stored offset by one, so zero means off-list */
> +	VM_WARN_ON_ONCE(gen > MAX_NR_GENS);
> +	return gen - 1;
> +}
> +
>  #ifdef CONFIG_LRU_GEN
>
>  static inline bool lru_gen_switching(void)
> @@ -168,22 +184,6 @@ static inline void lru_set_gen_flags(unsigned long *flags, int gen)
>  	*flags |= (gen + 1UL) << LRU_GEN_PGOFF;
>  }
>
> -/**
> - * lru_get_gen_flags - Return the LRU generation number from folio flags.
> - * @flags: folio flags
> - *
> - * Returns: A number between 0 and (MAX_NR_GENS - 1), inclusive. Returns
> - * -1 if the flags indicate the folio is off the list (e.g., isolated).
> - */
> -static inline int lru_get_gen_flags(unsigned long flags)
> -{
> -	int gen = ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> -
> -	/* Exclude the legal -1 from the unsigned MAX_NR_GENS comparison */
> -	VM_WARN_ON_ONCE(gen != -1 && gen >= MAX_NR_GENS);
> -	return gen;
> -}
> -
>  static inline int folio_lru_gen(const struct folio *folio)
>  {
>  	return lru_get_gen_flags(READ_ONCE(*const_folio_flags(folio, 0)));
> @@ -483,6 +483,36 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
>  }
>  #endif /* CONFIG_LRU_GEN */
>
> +/**
> + * folio_inc_lru_refs_fast - Bump folio refs count without promotion.
> + * @folio: the folio
> + *
> + * Raise refs from 0 to LRU_REFS_REFERENCED and leave hotter folios
> + * untouched. For a folio off the gen lists with MGLRU off, a plain
> + * PG_referenced set.
> + */
> +static __always_inline void folio_inc_lru_refs_fast(struct folio *folio)
> +{
> +	unsigned long new_flags, old_flags = READ_ONCE(*folio_flags(folio, 0));
> +	unsigned int refs;
> +
> +	do {
> +		refs = lru_get_refs_flags(old_flags);
> +		if (lru_get_gen_flags(old_flags) < 0 && !lru_gen_enabled()) {
> +			/* For CLRU, just do folio_set_referenced() */
> +			if (refs & LRU_REFS_REFERENCED)
> +				break;
> +			refs |= LRU_REFS_REFERENCED;
> +		} else {
> +			if (refs)
> +				break;
> +			refs = LRU_REFS_REFERENCED;
> +		}
> +		new_flags = old_flags;
> +		lru_set_refs_flags(&new_flags, refs);
> +	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
> +}

The implementation code of this function looks a bit convoluted.
Would it be better to simplify it into the following code?

	do {
		bool clru = !lru_gen_enabled() && lru_get_gen_flags(old_flags) < 0;

		refs = lru_get_refs_flags(old_flags);
		if (clru ? (refs & LRU_REFS_REFERENCED) : refs)
			break;
		new_flags = old_flags;
		lru_set_refs_flags(&new_flags, refs | LRU_REFS_REFERENCED);
	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));

--
Cheers,
Vernon
