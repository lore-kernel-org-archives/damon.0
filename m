Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541362;
	b=IkvFi8QChk+gd1+10vdEvUK/cvBXHDRFcjODZN3z3kUw31x39XVXpCetJUurRmR5F/4D
	 qXkZPgpsH+8qBpx4dv7XPF+02SGvzYgpK37hCxe0L2wod2hrSfCGYdB+Go4cYhWYEcmaV
	 81tH+gZQQmzs32IZKORNfOEwZMtsszvJutxqEH2KnWIljnhre5TqhTiYCSjxEL7Gklgk4
	 Jx7pQyknRZMfWL2rK92BQBZ/uH6TvYSTGZijfh/UQHQWGygFkOyevTIGsTVPbv3qnOlaU
	 wnWmw/qSavvpP6C1Bm42gBYa6Q7UWYNC125vP1ak1gOHkZI/16GGu0hlfOgJHhcLowA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Gh6CqnsQ+4Kge1Ge1wt7W5gV069TsTISbQWwZdpvMuU=;
	b=1duUvAuuwisNgb6yVRuKSmP/pewbhNRQQBl+gkcVHsdDTDpA7T7y9gcx4GfigRN7Valf
	 V6piAVXJvjLFPkkaSvQBxWTa1O7KN/T43RZOtj1U9QY1WlgQNb4VzEk2UXGP4OW8P1POR
	 gHp/rRsRp1W86wJ7/2ZaCYg3GHgT7zrUjoci2T+x6c0m8jOnSuFsUN+R0RtgQecqXxtw8
	 0wKiIOIGEED9VQ6n9dEz5VIBHAIMXN6tXMJdST83nTiw6Xbvqc7CSY5uIo1ta0TariUlH
	 JFsSoqrOmdDF63e6Riqxeu6oh3E8y9QdubxGdyQd1nZcwZwW2achWJvDjBjQA81cMoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KgWQ+Snl;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F41606A32A
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 17:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F41606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KgWQ+Snl
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so2070892a12.0
        for <damon@lists.linux.dev>; Tue, 24 Nov 2026 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795541361; x=1796146161; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gh6CqnsQ+4Kge1Ge1wt7W5gV069TsTISbQWwZdpvMuU=;
        b=KgWQ+Snl23iI+YDhnvgoUWJ5veeOqMst+6IpQcFbqW+/sMZn4BDVIFsVeBEiRjlYEZ
         oUCoQgx22WmQrwAu43K3KJUTCKxaC4KSQAXjfhRfN3HLXDAJ5GJZrKLRb/yMjf0UWzF1
         /hLdiFy1LSPOHmxu6L7PTwXniu6c6kVr2I4s9GxtztFwVbWH1iB5QFOywwZCVeRYVeKw
         A4r2VqMXpJOpc9p/UwaysxPqxoVksHp2tSmvqAwAe7Hhik3CXs5PmjTDJ52xepc+4rfx
         w10/EKuQg6EA30ItcufhMv5fHuc+Z8BROuMoqQR6e1YA9XhM9ST9PKlW3i+n5YnvEekM
         sEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541361; x=1796146161;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gh6CqnsQ+4Kge1Ge1wt7W5gV069TsTISbQWwZdpvMuU=;
        b=Z1IGtw4bzGP23MCQ+VoUnGgW1BR8W1UAqS9KQynJZXSiRB3T/hiHhfOCG3lWBNvIID
         Mk/iO6oSxoWV1065IBRkHua9xhtdYeRwqxx3CzTmD6+kZ1YVw71waxxgrhGBBGq3ni6B
         uYP7uQQi4WgokyASM6sSz9v5l6wN4zbkSESHR5Q+nwqThKqQ8WvTRkbdrhc4S/42x+Fv
         pIPW48bTkaBS1HkSq/RdGtqBVlcVlwR8yHQOjZCOh3eAOYG/y92G2gQgncuw9fAB1jKh
         EVDtKJ6m+vE9hbfe8+wMQoxWbEWJAMd+CDW6folsr/VmhXKu2Dg2lKjv0tIM7wcwbVxk
         Jq3g==
X-Forwarded-Encrypted: i=1; AL+hErFI/GfsDjc7V7uqqtTc4qUPflFTCdNreg5FNSEDrBcfVifIgnlDkQd/8iPfL8QNyv95LwalZw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/6tBU5hqYRoAA+xqWZStCTmdKPG1McB0y9UTfL4C6OF5pccxeJ
	eSDgUjdCn5v95wsLHaGMV3HhCVUiQGRJFEe4YPAOLtpFdN8A7p44PZqW
X-Gm-Gg: AZFdTZd4f1DF0HsZXu2WoZf4CNGze2QKGDZrRklztodfJ/4ohG42+W2PBwGa4qVf2GW
	vh7zc0GCCOoplswycxPwzp0pPnXlPpHd+ECL/iQA1TGMsU1Nc5AX2URjOaXBgUZvqxXEhOD5Jgv
	J2cynePeOmhpFhVbbsvaEjhSR+EOoC+Pw+/9cs2xUpFnJKuxJ+DeRxR2ayJtEIuUTCwpNeQmAQ2
	cv16WMRyl9r2xWOQ9ZAZ7Tlk45zXrZYvYpAE5nA8yT5tetkYgaRvEKRZ0pW+0N0sVlwxLCpmQ8e
	dxdH4LLuUFpAatqeMvvWrJ+BHQS+ulGoKZicYXO7OyqUfjO3lt2N/J02vYMHO5St2xjkIdRePwG
	92Ye3RZL3p31Yfa7x0n0+Z13FTEamM7ABbes/ywWm9oQo6Mxs/J832QY4Y6T39FgXvHNYO+svNI
	XsoV5gQkLUJZsR57kyuhZLeWweP1KUP2u6wXu+FXAfrJAPXsqqrmS8dpRWd4npffI7o3qKuVSaw
	qPoEToK1g7LZizGFlq4J6YpU23qbEWZj661EHyZJJPumOYTMj9P7LWWfEVyROCehfldWJAuexGi
	MElB4/8CrIvklnMEp4MYH/o8KUlSeDJLEGiA/AwnVrbF32ZkeNYuJtaiSijnTz9xxySqJP0=
X-Received: by 2002:a05:6300:404c:b0:3fb:35d2:645e with SMTP id adf61e73a8af0-4014a27e70emr13896715637.5.1795541361413;
        Tue, 24 Nov 2026 09:29:21 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4aca2sm7432265b3a.32.2026.11.24.09.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:29:20 -0800 (PST)
Date: Wed, 25 Nov 2026 01:29:04 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
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
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Hugh Dickins <hughd@google.com>, SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, 
	Yu Zhao <yuzhao@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	Zicheng Wang <wangzicheng@honor.com>, Tal Zussman <tz2294@columbia.edu>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Subject: Re: [PATCH v6 11/18] mm/mglru, smaps: convert to LRU refs based
 operations for MGLRU
Message-ID: <awXIalgUrVIf5VP9@KASONG-MC4>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-11-8ffea39934a6@tencent.com>
 <DN2UPVW6W83J.I1S5XXQ2DPLV@nvidia.com>
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
In-Reply-To: <DN2UPVW6W83J.I1S5XXQ2DPLV@nvidia.com>

On Mon, Nov 23, 2026 at 02:52:55PM +0800, Zi Yan wrote:
> On Mon Nov 23, 2026 at 1:53 PM EST, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > PG_referenced is only the lowest bit of the folio LRU refs count
> > (LRU_REFS_FLAGS) now, and MGLRU never kept it stable: promotion used to
> > clear it, and now it toggles as the count grows. But with the LRU
> > referenced count as a stable API now, we can use two helpers to provide
> > in-kernel users a stable and sane reading of the referenced status of
> > an LRU managed folio.
> >
> > Add folio_check_lru_refs() and folio_clear_lru_refs(), which use the refs
> > count when MGLRU is enabled and PG_referenced otherwise, and switch the
> > smaps paths over to them. The lru_gen_enabled() test stays inside the
> > helpers, so its static key is not splattered over the few call sites.
> >
> > Convert smaps as the first user of them. MGLRU now reports every folio
> > with a nonzero count, so the reading no longer flickers and clearing no
> > longer results in an ambiguous status.
> >
> > The classical LRU case is unchanged.
> >
> > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Tested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  fs/proc/task_mmu.c        |  6 +++---
> >  include/linux/mm_inline.h | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 3 deletions(-)
> >
> 
> <snip>
> 
> > +/**
> > + * folio_check_lru_refs - Test if an LRU managed folio has been referenced.
> > + * @folio: The folio to test.
> > + *
> > + * Returns true if the MGLRU refs count is nonzero, or PG_referenced is set,
> > + * which is also correct for the non-MGLRU case. Kept as a separate helper,
> > + * to avoid splattering the lru_gen_enabled() static key.
> > + */
> > +static inline bool folio_check_lru_refs(const struct folio *folio)
> > +{
> > +	if (lru_gen_enabled())
> > +		return folio_lru_refs(folio) > 0;
> > +	return folio_test_referenced(folio);
> > +}
> > +
> > +/**
> > + * folio_clear_lru_refs - Clear the referenced state of an LRU managed folio.
> > + * @folio: The folio to clear.
> > + *
> > + * Reset the MGLRU refs count to zero, or clear PG_referenced, leaving
> > + * PG_workingset alone for the non-MGLRU case. Kept as a separate helper
> > + * just like folio_check_lru_refs().
> > + */
> > +static inline void folio_clear_lru_refs(struct folio *folio)
> > +{
> > +	if (lru_gen_enabled())
> > +		folio_set_lru_refs(folio, 0);
> > +	else
> > +		folio_clear_referenced(folio);
> > +}
> > +
> >  static __always_inline
> >  void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
> >  {
> 
> I assume this mean people should stop use folio_*_referenced() directly.
> Are you planning to remove PG_referenced helpers to achieve that?

They are still there for CLRU, but yeah, and actually there is an earlier
RFC where we can remove PG_referenced and PG_workingset, just like this:
https://lore.kernel.org/linux-mm/20260502-mglru-fg-v1-31-913619b014d9@tencent.com/

And this:
https://lore.kernel.org/linux-mm/20260502-mglru-fg-v1-32-913619b014d9@tencent.com/

It doesn't really reduce the flags usage but make the code cleaner.

The co-exist of MGLRU & CLRU makes it looks weird, hopefully we
can solve that soon, let's do it step by step.

> Other than that, LGTM.
> 
> Acked-by: Zi Yan <ziy@nvidia.com>

Thanks.
