Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538860;
	b=EEzCjvV4dieIFyJ0cRhgvSceL2X5vFC9k2n3DSGFb2wXPWY4iZrolbtxpQXuuhD7WVdN
	 BlVwVa4OFabV5pev7u+APLrFizfZWZGM+ikONPzuFhwmqizSXMrqT0FMi/7LiOL7hL/mK
	 fX1ZWT0v9OaaKSqCf1eZPiiYH6QybXEeKfqJyz0BNv90Og3oiipBNPuJge4LYqBfu6/hI
	 +NkgHwM03NZrAi6DGJBkXbRZVqZvSrzi2+j678dVSF0tOpidIFUJKGOjCJxYNn7SC5sn8
	 ND+Y0bQ23JiAqIIhGUaEyE+Tm19HwuF7T3gCaAmMMgmfUGgDyQTpPp78AmFgTL3wXoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=gJF0lTJAQJ039BwujcWG7eT8CFSLQY2LIYRtsZwL2wI=;
	b=Jo4z7vr1dVd/Zlx9u5cnjvQHMmproPgRvXeUSCLSu+iVT3THscZK7gSGu4BZxHUG88Zu
	 WWW3i7HaBIqSRpsJAXXWrSa5fCdRfIfPD8M81bv2V5q1+d1lQxJQ+us4UrUnnimhv2KQm
	 Jkh9uPbd+i1A0/rB/tOsb1+izZ72fYtw1neLtk7VBf4mTncBkzH3NBOlVgPBGYoLvDofw
	 fqLrxlRFcX6OQK/blqbH+dfwdZjPyB7RmnGIKhxX6HXtI8U5xyTnM+m2Zxb/FZNX6xTPt
	 5feZ/ePfyIRLAN81C4qEd3v/aYfKsN+gG/ONjFwUWlFIUMX4il/pI477/HBQEmbjTag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKiexYw8;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5102606A337
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 16:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5102606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKiexYw8
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso2304160a91.0
        for <damon@lists.linux.dev>; Tue, 24 Nov 2026 08:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795538859; x=1796143659; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gJF0lTJAQJ039BwujcWG7eT8CFSLQY2LIYRtsZwL2wI=;
        b=aKiexYw87iYIFlHLVc3w7xtS6hMSanIDXYPQm4dZq5x5qKBCPby3bd1kfaRy6Tv7kq
         6XWONsD9R+/t1af3ANKdTh52c0Y4kaqKnqWLS2WRFJXADVzKM6Zw4WcLj5Lp3mR/iIaA
         mledz3DR7MmC1MQr+WSrlTlz3eUWKKtkt0+4Z44KvFRnPOInnrNkohVh1pBccDR0KplL
         ed7o9EKhV/grkYOUwEWlzzNLv983/WvYZ+jphg0Sx/3/naBeInjfNbdGBXKEqInnTCP1
         T76gRaERCI26HFga8snipec+z3lY8+cvPJfdM8xMayt6CvR7jAAV3OXZPKSofiBPa+Rn
         0W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538859; x=1796143659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gJF0lTJAQJ039BwujcWG7eT8CFSLQY2LIYRtsZwL2wI=;
        b=raeNClr7rsc6BWZQMoxUfcYVS/LMs7WinHcHY3opTU8GGqGuCUkfLAu6oN/Y6MMSss
         O6t3wHBVePOiVsli2Rp2RySZ9uEd8Itj7M0xtOC6SFGcZIZGRV6/p3oxnbTmko9YO8ud
         dp/UEIQWodXL9RnlT7igEgz3N58CGlvJVYAB2PzA1qf4FQxu/TGAuny761KSPJ8vPzb4
         fGYcPuZatFXgtiAmnuYiuRWdSUqMgZa/dLO8Q5O/fscxSZ6sxH7v6nwmC9RQAk8MgUdC
         hsNanMntbBCEw01XK3GzA6O2fo6PKHt/RLr0jSDZY8LudwYx10+aOOWVqVeo583/cytK
         FZOQ==
X-Forwarded-Encrypted: i=1; AL+hErG4CjKDemUn69A2UkTnIyHuU9u3k1OYjW+R/sLjB3dcMGeakTuMYMPMYpZz7z9S5UXxSkCcog==@lists.linux.dev
X-Gm-Message-State: APuU4Z9bctgxi7y0GWyCZzYj4FOyHoQ8VFu1HPWIpWUkXjuWEDpcaRnR
	4uwjegTq6sxxOI/B/IJOSuIeX3qDww0IuQjVg2qsnVprq2xSqWf72Ob3
X-Gm-Gg: AZFdTZeeC4oVH5PU/Dcyeyt8/ZUAgI4VTxBeqoGLdyN4qGjKCFERWOydIiNw8jgnrtO
	Oo/mEXdrglUvbSCVGTlqEaUjDeYY/5w7xOZycS/CZ0iovHvvwr0Wbp9vEFFPSFtN/ByuWVOj5Na
	3OIHJaalflchiKmoD5X5skmeZcBwHzRGFs8zRrSLHyzzm3XQmTxrArnpHTKjGuhB/4QFdfboKnh
	L3q1CPCuu+lHazMPu6ujilHIPgU42R/qN7Fy1mr+m2pqo05qLCZ6qRbv16xHPzC0Z+lnFExPlXh
	R0HZDlOZvHU3YnV6UNYXEPgIWa9wfe9HRRVUjTKxhchG4LblAm0eTFgcE4MXDCfBy/tKPDrGnDd
	IgqXKHnE6RoCgG8+oxsNMdFFsoCQWgr9LdIkQn7IiWYm3Y6N7bByS+lr759EpqPe/0aF39gUoft
	FK6ASm/5ADMi/9YjeIj6TwlfK+EW4sY94qv5PF0nAQmzKR6W0xsiP7fxKP4w1t/iKvzb7YWVGzD
	weM0WEnS7Yb2dW7pa8ilQOP+/XwHTiy1STMc5O9rw5cjLdwSudqf1Gdz1wbsMwWw6O/old+OibO
	BMFXnLlH0XConRaBSQIVTwfWtKptLc3a9mhQZqxEgr2O6kFfuso0N7YKuCFrynfVsi4TfA==
X-Received: by 2002:a17:90b:4a4f:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3b41c8e0c68mr9566976a91.7.1795538858850;
        Tue, 24 Nov 2026 08:47:38 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcafe0sm25206556a91.16.2026.11.24.08.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:47:38 -0800 (PST)
Date: Wed, 25 Nov 2026 00:47:22 +0800
From: Kairui Song <ryncsn@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
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
	Yu Zhao <yuzhao@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	Zicheng Wang <wangzicheng@honor.com>, Tal Zussman <tz2294@columbia.edu>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, damon@lists.linux.dev, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>, tj@kernel.org, mkoutny@suse.com
Subject: Re: [PATCH v6 17/18] mm/mglru: folio LRU refs based active/inactive
 number accounting
Message-ID: <awWvabJGg2A_rS_s@KASONG-MC4>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-17-8ffea39934a6@tencent.com>
 <sashiko-outbox-229933@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-229933@kernel.org>

On Mon, Nov 23, 2026 at 07:28:02PM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/mglru: extra atomic RMWs on folio->flags in
>   lru_gen_del_folio()
> --
> 
> commit c2fa4ccd879e2b2e8e7542ec52e0fe26798b936c
> Author: Kairui Song <kasong@tencent.com>
> 
> mm/mglru: folio LRU refs based active/inactive number accounting
> 
> This commit switches MGLRU active and inactive LRU size accounting from
> the generation window to per-folio LRU reference counts based on the
> LRU_REFS_ACTIVATED threshold.
> 
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index a4daf366e6aa7..b0f062e3a1905 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> 
> [ ... ]
> 
> > @@ -440,24 +445,33 @@ static inline bool lru_gen_add_rejected_folio(struct lruvec *lruvec, struct foli
> >  static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> >  {
> >  	unsigned long flags;
> > -	int gen = folio_lru_gen(folio);
> > +	unsigned int refs;
> > +	int gen;
> >  	int zone = folio_zonenum(folio);
> >  	int delta = folio_nr_pages(folio);
> >  	enum lru_list lru = folio_is_file_lru(folio) * LRU_INACTIVE_FILE;
> > +	unsigned long max_seq = READ_ONCE(lruvec->lrugen.max_seq);
> >  
> > +	/* Keep LRU_REFS_FLAGS: refs carry access history across isolation */
> > +	flags = set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK, 0);
> > +	gen = lru_get_gen_flags(flags);
> > +	refs = lru_get_refs_flags(flags);
> >  	if (gen < 0)
> >  		return false;
> >  
> >  	VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
> >  	VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
> >  
> > -	/* for folio_migrate_flags() */
> > -	flags = !reclaiming && lru_gen_is_active(lruvec, gen) ? BIT(PG_active) : 0;
> > -	flags = set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK, flags);
> > -	gen = ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > +	/*
> > +	 * See the comment in lru_gen_folio_seq.  For migration, compaction,
> > +	 * or any other isolation of a hot folio, try best to retain its gen
> > +	 * info. Ideally we would keep the full gen info.
> > +	 */
> > +	if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_NR_GENS)
> > +		folio_set_active(folio);
> 
> [Severity: Medium]
> Does moving set_mask_bits() before the gen < 0 check and splitting out
> folio_set_active() add unnecessary atomic RMWs on folio->flags in
> lru_gen_del_folio()?
> 
> set_mask_bits() unconditionally runs a try_cmpxchg() loop even when the
> masked bits are already zero, so every lruvec_del_folio() call when MGLRU
> is disabled at runtime (or on unevictable folios) now performs an atomic
> RMW instead of returning after a READ_ONCE() check.  When MGLRU is enabled,
> non-reclaim deletions of folios in the two youngest generations (such as
> __page_cache_release() in folios_put_refs(), which immediately clears
> PG_active via __folio_clear_lru_flags()) also execute two atomic RMWs
> (set_mask_bits() followed by folio_set_active()) instead of combining
> clearing LRU_GEN_MASK and setting PG_active into a single try_cmpxchg()
> loop after checking gen < 0.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com?part=17

Yeah it's true, but the overhead is really trivial, far below the noise floor
for folio operations.

I did a few vm-scalability tests on this with MGLRU disabled, and faulting
shmem folios, overall, the performance seems about ~0.07% slower while the
noise floor is about 3%.  In theory we do have maybe dozens cycles per
folio overhead though.

But well, I can apply a few micro optimizations here, they are easy to do
and will avoid the unnecessary overhead in the first place, good for
both MGLRU and CLRU.

Let me just wait a bit more for other reviews and maybe send a v7 with
following changes squashed into it if needed:

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index b0f062e3a190..f30ff9af2506 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -444,7 +444,7 @@ static inline bool lru_gen_add_rejected_folio(struct lruvec *lruvec, struct foli
 
 static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
 {
-	unsigned long flags;
+	unsigned long flags = READ_ONCE(*folio_flags(folio, 0)), new_flags;
 	unsigned int refs;
 	int gen;
 	int zone = folio_zonenum(folio);
@@ -452,23 +452,26 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	enum lru_list lru = folio_is_file_lru(folio) * LRU_INACTIVE_FILE;
 	unsigned long max_seq = READ_ONCE(lruvec->lrugen.max_seq);
 
-	/* Keep LRU_REFS_FLAGS: refs carry access history across isolation */
-	flags = set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK, 0);
-	gen = lru_get_gen_flags(flags);
-	refs = lru_get_refs_flags(flags);
-	if (gen < 0)
+	if (lru_get_gen_flags(flags) < 0)
 		return false;
 
 	VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 
 	/*
-	 * See the comment in lru_gen_folio_seq.  For migration, compaction,
-	 * or any other isolation of a hot folio, try best to retain its gen
-	 * info. Ideally we would keep the full gen info.
+	 * Clear the gen and set PG_active, try best to retain its hotness
+	 * info while isolated.  The gen is the on-list marker, so setting or
+	 * clearing it needs the lruvec lock; a lazy promotion only moves it
+	 * between gens and can race with us here.  Refs must come from the
+	 * same snapshot, as they feed the accounting below.
 	 */
-	if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_NR_GENS)
-		folio_set_active(folio);
+	do {
+		gen = lru_get_gen_flags(flags);
+		refs = lru_get_refs_flags(flags);
+		new_flags = flags & ~LRU_GEN_MASK;
+		if (!reclaiming && ((max_seq - gen) % MAX_NR_GENS) < MIN_NR_GENS)
+			new_flags |= BIT(PG_active);
+	} while (!try_cmpxchg(folio_flags(folio, 0), &flags, new_flags));
 
 	lru_gen_update_size(lruvec, folio, gen, -1);
 	if (lru_refs_is_active(refs))
