Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419265;
	b=yMBpi+K7SMJCuowVqpPFi6xsepGIWJjpPW81l2YjA9e2PYz/GDBRuEdbmDFRuafvgU+x
	 9R22Qh6BLjvoU14fvaAXOxmRfMRXV0f7mQlfny3o5hBEY+PnZEfkEUUc+VDjNHDupEcca
	 gOPIGAn4e3O40sb/4UGpWQSCm+pUdfHrppK4mKbmZBm9FGSJV76BQ/fuji7XB9ZxzECDI
	 eSOe/7sOmW17DHN4JUnMfK0HX1kXAwGFF3zlywtgh1hyrDgo5lfooKmbCThx2geSZJX8Q
	 m0mVTvsjzgdJH1ASYYbMZ/vZWP1yQxqWE3u5YXr2F0X/hBHeaJ3PdZx3O9b5D2DFu7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Cavo6rumtYx83DhhSgHjGqxw295JLU9mSeXiMoOdbTo=;
	b=esiNsawjxjkSEi94qwGcFzWF2DnV6GZKZZjAVvagDAxaGXDv+/zXISUrSSXWiFoiDr5g
	 zZqX6duejpYGB9eCMQWgrCyluFg4XpxNcnvdP/IUtAuBrYcwB9EcOI7kvdyBE/hbSSRoN
	 rLYgAIBfBgYYSL7Jp5nBctRY8zdIixg3v61mbkO2XYq8bsfwdZu2NG/TvoTYDeVB+E1na
	 Hk45MIeE7mn2yf/bVhr97bRKN0/i+ckxx7QbYtx2uABgsSyUtWawEXzzCKIbPPXsxPFzL
	 ZEn/tJwRXXu2dpcUc6s3mEC0WuYa1MCKwHEANqqrLL/ajRZIzzCj2FFjxJDBTZjF/gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TKN7zRdl;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D63606A32D
	for <damon@lists.linux.dev>; Wed, 11 Nov 2026 17:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22D63606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TKN7zRdl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so25624345e9.2
        for <damon@lists.linux.dev>; Wed, 11 Nov 2026 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794419263; x=1795024063; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cavo6rumtYx83DhhSgHjGqxw295JLU9mSeXiMoOdbTo=;
        b=TKN7zRdlOfiykSTNykGzbhoNDaAWDHod0hE3D5kokwbJFexSxX02GXKwNf/nOW4Vuy
         CzIrxKLQhxryYg/zic7n04zUE1xBKV9/cvEQd51/WqWFb6oBYiRMNspzqeuA8nflH9Y3
         jKBwLNinxEUZjoiI0rhtYJ2B4jT9nA4zh37BQ5/LvqGejhZxs8DtdvmA+BJfaK3IAlKP
         ghxOxvyVojRLK71zymNR1plL09lvWuig6KvonRqiyVMTCi0ouNEPbWp+z8v+Dvn8xSmK
         obTwrCQst1BLtkPzei2zdWhUInTC6ZOCrjo03jnkY57mD1P3UWx81UuW06R3fL1RwpPF
         6mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419263; x=1795024063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cavo6rumtYx83DhhSgHjGqxw295JLU9mSeXiMoOdbTo=;
        b=kSICIJHklWpOkFNXCL+Px+hEu2HuEK3jeohqK4cA1HhK9HDm4ZXXykf0z3Kss5e5j5
         L/a3+CEnmkEU4KwuqZdC/6gsza1n8bA6jhjqETXz4SNS8QU3OaW18aYHkNFT/IXwleqc
         knAehoUczHoKfrDmVQqSCvvibNomCXwlCrxyX2zQzKLZwQXdnk9zNr1mMj0on1rfd8oN
         KovIBBQ6hMSDe4rnbIaGd7Iajz4qM7AeerZgo3YbD8yqqYT5V4eSaAq6VSgy3G1pnHqA
         J1imQmqr7sOYrAYC85cne+/mb100SGwopwsegSLI6/qVbFEN9nLbD5ezXVrb5/XXVVrt
         8F+w==
X-Forwarded-Encrypted: i=1; AL+hErH1zLhdKof5DlbZVPT7jtOo43qg0EPE1M9nQnreLZ3a74eFXrYJUiUfRS0Nei+PIQ3U2KGkhg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/rsfojkFeKJYMeMSY68g0X1bp0j9dh2fhoptO4pg1DKBjBHcAn
	lNM+UUB3Ve+RUmrd87AgSNmQN5lP7kPO3SDvQB8PwI/P8gBojvFzQ/FLRt9gpYTibt0=
X-Gm-Gg: AYBFou29hx+DhjSjE5yPujnPLrFuPRI3O12VtuH15n0FOABUg+I39U+oyuyw5rFj1sm
	vlqJBb0Isc2ghezgFKumSUtDULxnjDPlEvRkkFwzAJlluuak8cMA6+04IB8nnaOw1kcisWiIIfv
	FYJiQ94+E5Xb29qwbOpX3j4nlgpxsAjJYUytGvAFtQ2wlE3Bl09lrSZLQkwh8Mv4BqCLHpSzAO+
	U3rYcfwBvhHR+cx0YNzLlKC2k/d0KpjQ/r3XB1pJcjVkjwFN09HmAafVRhwJvrgkrvOlwcrAkey
	aAiKsDMOY3FnAL/3wXs8QRmrwi699FoIkFSFV+wVOPdnNh0aB0s4BWk47+2jZ1H0m0E0nQw54dB
	tFyCRH1eKi/Si25+Bj9PVeacc50/VmV5P7Jh1Foj7Kj36/iIFQ1zY2QPG4It2+z3Q1yZX0RVInt
	z52QaSULfAXiaeNpJYJMKbt2j/grlaEey3N5atoPCLHStNP+RnH9wgPU8JPYe9U88wZCJh1RJJr
	EFePf3v0iXTNZAn/HgpTCuDbg2v6eanWKoBXmR4ynr5qaTtw/066AACGrmTDH9sjnVh/4WJiRM9
	9Zp0tLQ4d01o/FqkTFxY2crVzMmWEEiLlmgYMr3OipppoEzwEOHx0A==
X-Received: by 2002:a05:600c:3f07:b0:4a5:87a:50ba with SMTP id 5b1f17b1804b1-4ba0938a6a7mr55235815e9.33.1794419263442;
        Wed, 11 Nov 2026 09:47:43 -0800 (PST)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm5375895e9.5.2026.11.11.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:47:43 -0800 (PST)
Date: Wed, 11 Nov 2026 18:47:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, akpm@linux-foundation.org, 
	yosry@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, sj@kernel.org, david@kernel.org, ljs@kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev, tj@kernel.org
Subject: Re: [PATCH v2 2/4] mm: memcg: read root lruvec stats from the node
 counters
Message-ID: <avSqMxGjwYPrQLlV@localhost.localdomain>
References: <20261110015321.611093-1-joannelkoong@gmail.com>
 <20261110015321.611093-3-joannelkoong@gmail.com>
 <sashiko-outbox-206041@kernel.org>
 <CAJnrk1aQrRE78wqd2yZWS2Sk8MiCHd9x0dveZBh5LHE5w75nkg@mail.gmail.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aQrRE78wqd2yZWS2Sk8MiCHd9x0dveZBh5LHE5w75nkg@mail.gmail.com>

On Tue, Nov 10, 2026 at 03:10:54PM -0800, Joanne Koong <joannelkoong@gmail.com> wrote:
> On Mon, Nov 9, 2026 at 6:23 PM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue to consider:
> > - [Medium] mm: memcg: node_stat_includes_unaccounted() omits file and
> >   writeback stats
> > --
> >
> > commit d2ba314724a8ba015e3bf2a30f155f1beba25a8c
> > Author: Joanne Koong <joannelkoong@gmail.com>
> >
> > mm: memcg: read root lruvec stats from the node counters
> >
> > This commit changes lruvec_page_state() and lruvec_page_state_monotonic()
> > to read per-node vmstat counters instead of rstat values for the root
> > memcg when querying stats that only track memory charged to a memcg.
> >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 1ebc9330aeae5..2575bf2ba0ea6 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> >
> > [ ... ]
> >
> > > @@ -504,13 +511,52 @@ struct lruvec_stats {
> > >       long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
> > >  };
> > >
> > > +/*
> > > + * Whether the node counter for @idx can also count memory that isn't charged
> > > + * to a memcg (eg kernel memory that isn't accounted). For these stats, the
> > > + * node counter can be larger than the root memcg's value, so the root memcg
> > > + * has to read its rstat value instead.
> > > + */
> > > +static bool node_stat_includes_unaccounted(enum node_stat_item idx)
> > > +{
> > > +     switch (idx) {
> > > +     case NR_SLAB_RECLAIMABLE_B:
> > > +     case NR_SLAB_UNRECLAIMABLE_B:
> > > +     case WORKINGSET_NODERECLAIM:
> > > +     case NR_VMALLOC:
> > > +     case NR_KERNEL_STACK_KB:
> > > +     case NR_PAGETABLE:
> > > +     case NR_SECONDARY_PAGETABLE:
> > > +#ifdef CONFIG_HUGETLB_PAGE
> > > +     case NR_HUGETLB:
> > > +#endif
> > > +             return true;
> > > +     default:
> > > +             return false;
> > > +     }
> > > +}
> >
> > [Severity: Medium]
> > Should node_stat_includes_unaccounted() also include NR_FILE_PAGES,
> > NR_FILE_MAPPED, and NR_WRITEBACK?
> >
> > For NR_FILE_PAGES, swapcache operations such as __swap_cache_add_folio(),
> > __swap_cache_del_folio(), and __swap_cache_alloc() update NR_FILE_PAGES
> > only in the node counter while accounting swapcache in the lruvec under
> > NR_SWAPCACHE:
> >
> > mm/swap_state.c:__swap_cache_add_folio() {
> >         ...
> >         node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
> >         lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
> >         ...
> > }
> >
> > Reading node_page_state(pgdat, NR_FILE_PAGES) for the root lruvec
> > therefore includes all swapcache pages, which inflates the "file" counter
> > in the root cgroup's memory.numa_stat (double-counting swapcache alongside
> > "swapcached") and causes it to diverge from memory.stat even after a
> > flush.
> >
> > Similarly, __folio_mod_stat() -> lruvec_stat_mod_folio() updates the node
> > NR_FILE_MAPPED counter without updating memcg rstat whenever an uncharged
> > folio (folio_memcg(folio) == NULL, such as a driver mapping or a
> > root-cgroup __GFP_ACCOUNT kernel folio) is mapped into userspace, and
> > nfs_folio_mark_unstable() and nfs_folio_clear_commit() update
> > NR_WRITEBACK only in the node counter for unstable NFS pages awaiting
> > server COMMIT.
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20261110015321.611093-1-joannelkoong@gmail.com?part=2
> 
> Thanks, this is a good point about the folio stats.
> 
> Hmm... I wonder if we should go with an allowlist instead of a
> denylist. The allowlist is longer (31 stats vs 11) but would be more
> resilient to failures (a stat missing from the allowlist just reads
> the rstat value whereas a stat missing from the denylist will silently
> report the wrong value) for any stats added in the future. Any
> thoughts?

I agree the opposite predicate would be more robust and potentially
easier to review (review only the _listed_ cases, not the "unknown"
complement).

Also, instead of

       if (something && !mem_cgroup_is_root(eviction_memcg))
                mem_cgroup_flush_stats_ratelimited(eviction_memcg);

I'd consider

       if (something)
                mem_cgroup_flush_stats_ratelimited_opt(eviction_memcg,
		1UL<<NR_ACTIVE_ANON|
		1UL<<NR_INACTIVE_ANON| ... );

and collect the exceptional handling in memcontrol.c:

        void mem_cgroup_flush_stats_ratelimited_opt(struct mem_cgroup *memcg, unsigned long needs)
        {
                if ((needs & ~node_stat_equivalent) == 0 &&
                        mem_cgroup_is_root(mem_cgroup))
                        return;
		...

This way in-kernel flushers will be expicitly annotated so that
potential mismatch is more obvious to spot (and it adds possibility of
future optimizations).

(This is all only a concept, it may turn out uglier when worked out to
details...)

HTH,
Michal
