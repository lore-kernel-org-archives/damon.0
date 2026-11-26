Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696725;
	b=Ypp4mvVn5JtThHCoKB477SUEu2W4CmfPV9RyRU2XbOmjHvh6DlUE8CcwYmOB+UkFXxeR
	 +hyIHlZDO5En4RjMIkRGiWCJIsTYVEXiNCZXVJEBmwUC6tDCiFrVKfl+G9DvlUhievgEG
	 KxtSIX0Ti6Amy9+KFY+U7atrMdf0HgzUQA/C65pK4Ds0Fxmz2KPOoT0FSSAGzXkPNujSz
	 z/RXfT15Fszvo7oRziejBT2eBWC3VTwVUNiiDXMfnINfBDFgUluHr2xdTJgVWYvLymdNj
	 Kxb3T52xdclyaWjTaeiut+LsjsGzGasC3VX8BGicGSs+BshaZmPYsR73f1YHKx5+ONA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=C/AbZhSvVAtAuxRzfiAolPI8iaF2YFQe3pPvY/yniKU=;
	b=oPwbRsPhJNWbUHEO5uybfFnYgv8derKivDCDhYf4cS+fv2lbiQfX4mL3/4Ss/6xakO8e
	 g8RS6zXMQ/M7MscOnkYFyiUasqkCv3mz5TjJtNwmOXoayRegxZxelMK4iYTWt/voOYHDl
	 G0B0j3qy+UcYY4S4iU7QjEm1GeHwmE09uoU5Eq5AvzepENPvuys5aQtoKAxBE+Gw98IdY
	 ijeQRJi9jdzxEYR75eEsWLD06PEjkLZTqek3CtswRtuXxGkod8p5ykJaOVnptAu5jOePD
	 gCdJSgve9+sIpoXcM3qN+xYc5t2vCVDNdRr8sbNbUuvGSnot//plY5xwAOnyGBtgNlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ghbVqfJi;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B110606A31E
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 12:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B110606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ghbVqfJi
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so4702553a91.3
        for <damon@lists.linux.dev>; Thu, 26 Nov 2026 04:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795696724; x=1796301524; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/AbZhSvVAtAuxRzfiAolPI8iaF2YFQe3pPvY/yniKU=;
        b=ghbVqfJimQH2AOcR1AWYMGSeBzUmItPm8FyFJ5hlCBrtM8yQ5HiA3IMhMQEbPRTBDd
         XNPVdxI/WIvJ75NC6wD7z6NkpPCY9140rVvZnbyHQVDjLZySLAIYTpN7klCTwbugLA6b
         LsLY5ZMf/H4MZImnIyG47cJO1Jnby3vFxxLD8rS/Av3AYsIvaxuIJNQshaUF1Nq6jAKk
         eYNO1KhEc/DhLmkm2gbawtkju8bFivGemRaJxdDPdjNQ4E3ws+tEzQrkjbeD8HGvTiz8
         bxFMWvvHztXJwzX/aZRsGNB7bYlKNTQX1l3PJfsuaMUB3+xfHLDQWolZiuTqNJjISPYS
         AkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795696724; x=1796301524;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/AbZhSvVAtAuxRzfiAolPI8iaF2YFQe3pPvY/yniKU=;
        b=oDAsw4H8kEBMzbC7wHqg+Y0//tthv/2BAHtvBZjF/BuioEIduTLXTDn9rimzIUkYx3
         9nP0BxjgdGfav0SLDWiwoqqlKX3krzQXu0Q+bt4bLI7VesKV5OpAOnOM8Xffd6g+VEch
         94J2tmQ+iw5pdWc4UVjiW/2DFGhKj4BioxzW+OV2byLS6+iXh1tcaL9Qm5GFtKfcPN2J
         UmoF5jJ+sGlrUIjMeQUyQTo/LGxMew6eQp13jzIns+25k9hADcbQ2EqJq/oV0LilEUbk
         S7bJ2mYXi4evl6lFFwIR4wWcFivKvhDjDFLFDT3lVfoZgCK//4UZlZE5grIN5sDq0c6N
         BegA==
X-Forwarded-Encrypted: i=1; AL+hErFk7s9Qek2WZDPp9vuepQtcmgp3ew+pP5PRlu9OgY2HcMpC7BLLJvLiMhyGiUxBAJiKlegGww==@lists.linux.dev
X-Gm-Message-State: APuU4Z/HEJrRuMvOtki6uR+c8C2LMQN+wZCg4zHqrbZILQukfx/aszUl
	0i8ZTZZL4vlffsoiT5ylx/LDUeY3hw88qxO1Mb0is4roLulAzhQ2PH2B
X-Gm-Gg: AZFdTZewk457S7w22bg1dwsHNSCmoGWP1qKtG9PMbZ/Shv84CU80YnR1YC8mTEcAHOk
	EPsj6Hb6+KGjjkpaYzVxeZNFY4LsSAALqYGaXWGyUI2nY7Y4v/9SkgxNhGkjIk78ojMwG30Lle4
	tfFODD8IU4HuG09OU1rx9fuR942iwoC9QnwBr1a/pOKDVlVEo7rePtdxIE4Ep+EthehAjByE7Ei
	qrFVWsWYt/kOMQ9eSoEaxht0W8XtRx9xRHBmSl0ZyJJaucbzd0ZRDb8c518eGwgp0bJB17buMDM
	UkgN+kgTrPDhr7oN4b/X+f3BdvwQFaKqOSIDKwxsKa7iX+rwxfZM6D96XZgq8ms5mid3XPDUMWE
	6rDCfo7aXhWLx4Hu6M9SIXdLGFK7hcZ1QUojplA1CMuyYIbT9ycf/Ax9w2krNY6aH1o7Ac3qUxf
	NYwq7hvNFf51zWZPFeUdax0yZF2BlGFdvIBj+A74Q8pyplslw4QZKuUeg86n2sW8ZHnUAfECUkK
	fts5athEI1WQmq4TWf1EMhe2noIo7HaSID4QF0kMBGVc2JsMcMo2/KrL1UWb4n9oq4QkkHp7wK6
	S7CwJdDh62KESUQXqEEoIuPj9et5sbbIyGE1sA/MUFaN1HYtRfexLTjoLZdiLDtwbuxW9Ak=
X-Received: by 2002:a17:90a:d2cf:b0:3ab:2737:3395 with SMTP id 98e67ed59e1d1-3b41cafd604mr18006258a91.42.1795696724285;
        Thu, 26 Nov 2026 04:38:44 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm33352174a91.6.2026.11.26.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:38:43 -0800 (PST)
Date: Thu, 26 Nov 2026 20:38:16 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Ridong Chen <ridong.chen@linux.dev>
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
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Hugh Dickins <hughd@google.com>, SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, 
	Yu Zhao <yuzhao@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	Zicheng Wang <wangzicheng@honor.com>, Tal Zussman <tz2294@columbia.edu>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>
Subject: Re: [PATCH v6 02/18] mm/memcontrol: allow update of LRU statistic
 without holding LRU lock
Message-ID: <awgnMVr6GHt0XKD0@KASONG-MC4>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-2-8ffea39934a6@tencent.com>
 <387237c3-c2f8-4782-9ba6-481f459cf7f2@linux.dev>
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
In-Reply-To: <387237c3-c2f8-4782-9ba6-481f459cf7f2@linux.dev>

On Thu, Nov 26, 2026 at 05:43:14PM +0800, Ridong Chen wrote:
> 
> 
> On 11/24/2026 2:52 AM, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> > 
> > To enable moving file pages in folio_mark_accessed directly and lazily
> > for MGLRU, allow updating the LRU statistic atomically without holding a
> > lock. It may cause temporary counter underflow, which should be fine as
> > the counter is eventually consistent and only serves as an estimate.
> > 
> > Reviewed-by: Barry Song <baohua@kernel.org>
> > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Tested-by: Andrew Morton <akpm@linux-foundation.org>
> > Acked-by: Muchun Song (ByteDance) <muchun.song@linux.dev>
> > Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >   include/linux/mm_inline.h | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 2395ca8ee305..2edb9beef6d3 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -47,12 +47,11 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
> >   {
> >   	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > -	lockdep_assert_held(&lruvec->lru_lock);
> >   	WARN_ON_ONCE(nr_pages != (int)nr_pages);
> >   	mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
> > -	__mod_zone_page_state(&pgdat->node_zones[zid],
> > -				NR_ZONE_LRU_BASE + lru, nr_pages);
> > +	mod_zone_page_state(&pgdat->node_zones[zid],
> > +			    NR_ZONE_LRU_BASE + lru, nr_pages);
> >   }
> >   static __always_inline void update_lru_size(struct lruvec *lruvec,
> > 
> 
> Hi Kairui,
> 
> Just a heads-up: this may conflict with Joanne's "mm: move LRU size stat
> updates out of lru_lock in folio batches" [1], which is in linux-next now.
> 
> That patch makes __update_lru_size() add to a batch attached to the
> lruvec by the lru_lock holder, and relies on lockdep_assert_held() there.
> Once this patch lets folio_inc_lru_refs()/folio_reset_lru_refs() call it
> without the lock, they could write into another CPU's on-stack batch.
> So the lockless paths probably need to bypass the batch.
> 
> [1] https://lore.kernel.org/20261029204157.117879-1-joannelkoong@gmail.com

Yes I'm aware of that, the fix is easy too, something like:

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 4ca8011bd288..fb5e3990402c 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -64,6 +64,30 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
 				NR_ZONE_LRU_BASE + lru, nr_pages);
 }
 
+static __always_inline void __update_lru_size_lockless(struct lruvec *lruvec,
+				enum lru_list lru, enum zone_type zid,
+				long nr_pages)
+{
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+
+	VM_WARN_ON_ONCE(nr_pages != (int)nr_pages);
+	mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
+	mod_zone_page_state(&pgdat->node_zones[zid],
+				NR_ZONE_LRU_BASE + lru, nr_pages);
+}
+
 static __always_inline void update_lru_size(struct lruvec *lruvec,
 				enum lru_list lru, enum zone_type zid,
 				long nr_pages)

---

And I think that batch design could be somehow improved too,
holding a stack variable in a global struct looks a bit odd, could
be simplified if we audit and update all users for update_lru_size
later.
