Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795367030;
	b=X2yKsJ1HzJ5dMvL+46zP/L/ApkdvMsO1mL6+F+JGsUvfrli9ARW6hZ2itN4w/zfiOUVk
	 AmIVKgnqBYcJa9wVDIbDU8xzJu3bmXMmDtfF3juU9CuzY5NLV56oTtFK+zUb4/keOVAYL
	 /Zs8cqpGsX+ohcMj4i3niycpkgUzdbmbrLxICjImWPe17Ji0vLqM1K6Hm5009t3K9KO8H
	 4oq3x9nb+hPCJRWjsvbBEQxwIm7jD7mvCzVlqF7MI3u4nEEdNElGqTt24vVHgJ25X6k7u
	 v/F5SzLExez0BN9h/l7khdzeSnXY7V/ip8ew/v5FtIuqhQDMqXXNhguchVo/M/cUgIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pmTrwXa44wNwYeC7jaSDYKhs1kagM9vZS4uaKGYPdVA=;
	b=IqEADIblRLbnJ3uj5auvNMCaOaX0Uwg2ZcaRV+cgF0HSLfw7jdUZXPscFxf+lcnAjFs/
	 HC+KRw3q4WTQRqbtuMYSk6/lEFc184yVbTMCrILKu9Sy0gYOByT+7LBTxje1vgIAhulor
	 EpcqeAIEtaoEZh6buWzikN685vQ0ix/Mr3NC2Q2mfTr62Ow7xiLMJXRmtylwktYV5Rt/b
	 jyyZXzuoLj5abiP9lsl7qUQF7stXCNGkhrXgEMDb1FnXHUE736kFxvBI+j2+ZbAREzi0I
	 XMac6aEIWIJ1SYWKf9SLAmjdXG8FJeeaL8HD3gIuSzV/OtsEUlJbbhZF29KU0q+YlYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rQnhyL/6";
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB1606A32C
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 17:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FCB1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rQnhyL/6
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f00fc215f9so17092485ad.0
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 09:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795367029; x=1795971829; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmTrwXa44wNwYeC7jaSDYKhs1kagM9vZS4uaKGYPdVA=;
        b=rQnhyL/650+c+bFeIFGM6CW4pljA31GO6lM3DEPfblX9zrvkEfVCRS8c/P1yXiW8eb
         yXgh99Bc3Da9Ixz00y8eYYEoJiYksNmj0m9mpHsBXR7QnOENJ5rrUwgmWEQs7itcHsew
         lpQB1lZogiGajYqUUGOT2f55aSv1ViY6FH9MvZwxkS3hh4RT+mXUmYh80aQFKdSTR3qd
         gTARBV9S2+Jv3ygVmkkW4IStiFirvg/NMn76gKHV651U6xM8Fbtu3yzHWVvmdlrfU8F3
         pshNZnH6OMkjHUnOcQxGNwWPoLiguF5CNX3qIxYQBYcNbI3yJWm0i5QaxS4u4ooX/4Z3
         GkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795367029; x=1795971829;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmTrwXa44wNwYeC7jaSDYKhs1kagM9vZS4uaKGYPdVA=;
        b=qf2GzLmOCg/8QRVUT1L5SfNCv6bed37HpVM2Nf4FJiZNen3VJottp9znjUFcvayTPx
         oyUc4QfhNR0HOVxg/sDPsbSqYCYs/PimYcy/N8FbwBI5+AL3+SzHWSyJnecTxH4qJA0X
         cYMSzL25rKe6K0DZTYiP7JvbtLgeR78ARsVem4mQ8vNge70AnPtWu1aXK1hyuL2W0o7e
         LZ+UrIrATppVBfa/VHE8e+YZPOjQZGUKjK5EgTGf5oJN+D5AS/Hc5o/IOpwMOvEt05WB
         0zzxKqPn3pnOXk14uQrQX7F0YN6CzYPK2KCHmhnqm9k/De1FXtAWMNxryS3kagDkLFoz
         GoHg==
X-Forwarded-Encrypted: i=1; AL+hErH2woXRpcVDS3IZIlXXprXBzvUUwnRm83K4T+2BMZ/OfUmV4IKlIMs1HhIXm/yuiHMxM5a1UQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+98hW/gTYXINqZv5XVnOyxETWqp5+GNVSZXg6QZ+TaXGL2ewNA
	q12KHszxxteMjbE3d0Y7pIWW/lBRTP9n9lrY6/L++N8m5nyAIE9RlUKH
X-Gm-Gg: AZFdTZeiRUY1HFeWM75EbKalv5gWmLf6c1/Duy5HNHSfmpkwpdxmRJUwk5RwzD1J/pd
	6zaSFcKMG84uRfdkmTeTz2dB/fAdWDbynH+7u75djDg3ijlCtgmFwGiU5YEM50Oib4rJWtkOuDW
	u0AH0JHyICLStzFlRC4+Y2XF2BLoHYI70W9X2XKv0BjPEEEFkJFu4IBlD1Ohytd1pkUl5WkBvgS
	UXKqn9xG24sQy0wp5oeVV20Si1/XvSTFHGNE10AvLdBV3CgLTbAT8xF2CybgSLSvkppPep6tOfZ
	z4kqb/dyqqLntQP9YdnkH+E1VTP9sSvG0PS8QCOap147edPtV6T3A1QbkcFnXRwmfA7eZ8h0gA3
	fhZUNir6DYSbH6FJ6WiqmXmkZzE2iGwkUU/z2lHqV76k/rprZ1JT1x9c61V5N3g4R4Eii72+AHh
	T/jEdxvY9L4868ObdVPY7/qNzGjvUt/KE7VX8Co3LO4wyrAwmJMegoNTbSQD//fxVNTZJSKa+NQ
	/DnZoU+GJEJSY6hgrIwDm7lIE/tJiexvjGigBNVYJ1joBxRnB5CwLJAbXlOTnKeg1+irZ7+MnZQ
	bfCw7/zY5kuT/dk07/eGo7Dkq54gzfKsNUqz1V1vRn5wI6zrB6zTlBmetTll+rS93iuwIXk=
X-Received: by 2002:a17:903:41cd:b0:2e9:8bd4:577d with SMTP id d9443c01a7336-2f03f1bfa6fmr95419565ad.37.1795367028759;
        Sun, 22 Nov 2026 09:03:48 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42b1sm39111735ad.17.2026.11.22.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:03:48 -0800 (PST)
Date: Mon, 23 Nov 2026 01:03:34 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: kasong@tencent.com, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Hugh Dickins <hughd@google.com>, SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, 
	Yu Zhao <yuzhao@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	Zicheng Wang <wangzicheng@honor.com>, Chen Ridong <chenridong@xiaomi.com>, 
	Tal Zussman <tz2294@columbia.edu>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 04/17] mm/memcg: add folio-based lruvec live helper
Message-ID: <awMX9W-Ykjw4maRg@KASONG-MC4>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-4-9eee2fe97a2d@tencent.com>
 <42207e26-ba7f-4df5-8c80-71fa1b84d26e@linux.dev>
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
In-Reply-To: <42207e26-ba7f-4df5-8c80-71fa1b84d26e@linux.dev>

On Sun, Nov 22, 2026 at 03:53:44PM +0800, Muchun Song wrote:
> 
> 
> On 2026/11/19 05:03, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> > 
> > Add a helper that resolves a live lruvec for a folio under RCU
> > without taking the lruvec lock.  It takes a folio directly so the
> > lruvec lookup happens inside the RCU read-side critical section,
> > which a lruvec-based interface cannot guarantee.  The first user is
> > the lockless folio_inc_lru_refs() path later in the series.
> > 
> > Factor the ancestor walk out of lruvec_live_lock_irq() into
> > __lruvec_get_live(), so that both entry points share it, and spell
> > out why the walk is enough while only the RCU read lock is held:
> > reparenting of a memcg that starts dying waits for a grace period,
> > so it cannot race with the caller until the lock is released.
> > 
> > Move memcg_is_dying() up in memcontrol.h, next to the other memcg state
> > predicates, and use it for the walk rather than repeating the open coded
> > css_is_dying() test a few definitions away from where it is explained.
> > 
> > No functional change for existing callers.
> > 
> > Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> 
> Reviewed-by: Muchun Song (ByteDance) <muchun.song@linux.dev>
> 
> Some nits bellow:
> 
> > ---
> >   include/linux/memcontrol.h | 71 ++++++++++++++++++++++++++++++++++++----------
> >   1 file changed, 56 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 980358bc6f49..441a5d57e723 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -571,6 +571,11 @@ static inline bool mem_cgroup_disabled(void)
> >   	return !cgroup_subsys_enabled(memory_cgrp_subsys);
> >   }
> > +static inline bool memcg_is_dying(struct mem_cgroup *memcg)
> 
> Let's make it const for @memcg along the way.

Good idea, but css_is_dying isn't constified, maybe we can do it later I think.

> > @@ -1510,28 +1520,41 @@ static inline void lruvec_lock_irq(struct lruvec *lruvec)
> >   	spin_lock_irq(&lruvec->lru_lock);
> >   }
> > -static inline struct lruvec *lruvec_live_lock_irq(struct lruvec *lruvec)
> > +/*
> > + * Reparenting moves a dying memcg's LRU state to its parent at any time,
> > + * so anything added to that LRU afterwards would be lost.  This helper
> > + * walks up to the nearest live ancestor while the caller must hold the
> > + * RCU read lock: reparenting of a memcg that starts dying waits for a
> > + * grace period, so it cannot race with the caller until the lock is
> > + * released.
> > + */
> > +static inline struct lruvec *__lruvec_get_live(struct lruvec *lruvec)
> 
> Cound @lruvec be const as well?

The argument is fine, but tricky for the return value: when nothing is dying it
hands back @lruvec unchanged, so a const argument means a const return (which
isn't right) or a cast dropping it again.

> > @@ -1561,6 +1584,34 @@ static inline bool folio_matches_lruvec(const struct folio *folio,
> >   	       lruvec_memcg(lruvec) == folio_memcg(folio);
> >   }
> > +/**
> > + * folio_lruvec_live_get - get a live lruvec for a folio under RCU
> > + * @folio: the folio
> > + *
> > + * Same as folio_lruvec(), except that a folio whose memcg is dying is
> > + * accounted to the nearest live ancestor, which is where reparenting
> > + * would put it anyway.
> > + *
> > + * Return: the live lruvec, with rcu_read_lock() held.  Pair it with
> > + * folio_lruvec_live_put().
> > + */
> > +static inline struct lruvec *folio_lruvec_live_get(struct folio *folio)
> 
> const folio?

This is doable, will do!

Thanks for the review!
