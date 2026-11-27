Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795744932;
	b=nvZFwOLsUQTBSgbhd/A3r/dFkKif6sQ2kIk3d6Co/9KhpolUUVpVmCIGQiPPe0WBYAzd
	 Hy3rJxFH1rMXg7dwfPVbNXL6LgQDpmmOGBi+BDqleCcouHUSaZb3A4111prG3l2Y6UHGF
	 gXTb+KvnJnpHAMKvpik/Ilph+3T1f4NMo7BGdaRR+IjjTZrNUj32engzJiEMTy59Fqqfd
	 8tMfhzNBH2d7DgLEJTnCwk+9UqnbvcmhqY6/pvHmP3d7qDcwwQvlvNkpmvGAFBNur6RPb
	 rzxnduVsmbTGXJ+wKUfeyyMJK401gyK8vpZ7J66SPplXTiejbP11Ew+r8PkmYONUkMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CD6edFGqmU8n4mTR3UtP0gostgp/pYDUUVhaESpICv4=;
	b=5cTkuaAydAhfOli+gpwIA9pKwR+SWKRPhQxESO1pUtimcdufKtnrhe8uMJO4V/4PeXHC
	 SsrC+byydPfkW8J3bFXUD4UkF0dK09xHzrY2X3TIQGWUFdF3Q16w3GL7yfJOLWJiJXxLI
	 GMo6mCbypuBg7ndQEARLJGnd0GlWWRIbSqlHTQvn2Nas06cl5cHKmzvsFs1u7rwZoJc5J
	 36U+7fZWWuWME+rDt4wYpjIPkCrIBCO0z3R0yuSTNPTEnDkm/rfKRbovfLTAtcVx1a/Bl
	 6WCztm84QrHpe0TmXBwCGC1msIcQTiFQ/7FhwExhpWKBQmtVAHFY6tSKNXWCaotdCOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rHF/+li0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8A606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 02:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB8A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHF/+li0
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c511c0e2826so867560666b.0
        for <damon@lists.linux.dev>; Thu, 26 Nov 2026 18:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795744929; cv=none;
        d=google.com; s=arc-20260327;
        b=IWa71zK1ODkDOj7LcAogZxUTI4d5rCyJP6m8pBAA0w2Q3hA71hqV5cpi+/KiSAz0vE
         bmvAJdtSN6RkgBLpnGPvZMDKuxxLQI81kjiR0SJtU7bl47u+FXWkeZVmXJfRyHDU8FOv
         ah0AduMWv6oMtap36PdgiDWYzHye3otKUmFVrk8be2hNK5cOvry6h88TlbuJEONPR/96
         50vyrCpcd4tEf4NMYeOcdZZmrlSFfvvQPYUUFB8tcg/MDKbS4ZKwHiTXDqtqHj9sjTnb
         Y+LRWGhf91pYf+knl/kv/xY3q3lExxuLTWBud3dAvBPThBhApYLyXl5ra5HMB0HPznWf
         5v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CD6edFGqmU8n4mTR3UtP0gostgp/pYDUUVhaESpICv4=;
        fh=BIfYU2NBE2v/fGWZRzoMsyoRVPiDDLU3qkMgP5bGS+k=;
        b=Hsgd19RwSSivSGj3Bdgb5R3Tjh9fBn3fpJ/g6/V0mToo8bZ8m21SMifRfORvIdY9/B
         n1j1e4gqv5oC0hdeVkMHp5yrfopee790O5LU0q9RBCs1+o/Rs6xmlDIpXFh5JzbWHkLS
         eHJYznkh7l2VLO4UBGjAMYmKMavZ5Rt2SaC1g3X5fvaoQd4jZipAFWjSkqKhhmKQWte1
         S8oB+dVTslsJ8jZ1S4Wr/lHxgjjQ4VwIcbXDtjO9vcjb0FxCueryrQcYyuhSYGdcbXCY
         c7+DewDJhBhnfYxv0oay1t2AoFvz2LFTd5jVP7tPu1VQmXAj6t5DzO9+6Jgeq/e3Xm6n
         ZzJw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795744929; x=1796349729; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CD6edFGqmU8n4mTR3UtP0gostgp/pYDUUVhaESpICv4=;
        b=rHF/+li0lJXK80mXZY+ghxDP6b7Xz1ImRc+jGi8Kwp4k6Nqn+F5xJezHDn3Fe918mr
         BJfNK7OmpxyKKnRKUTPKwZxmWU6IdSao4ZcvhWfISYMeBBuDjLG0r49DjLL7fFUidLeu
         RSQRiKOo8x1EBunWT5y1oRH+kQ0Fwv6nZ49AIlMIviXOooZ3M1pTiWKj3nfENQ1L7Hkn
         PYl1Gwqqx7/bhyPv1ayIXhFo3ty8KjnQfRZK4TCexn1IS3mUgUD+BBX2+S0seJ9FS+Jf
         KOs/3Or2pXUEOp/Vmzx58I96f5snG0y6TssY/P8RTrLvEipxJd0yZ5ql5lqBljiqExru
         0Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795744929; x=1796349729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CD6edFGqmU8n4mTR3UtP0gostgp/pYDUUVhaESpICv4=;
        b=wHE0D+p626vCfonkFHrfNm6mBOfRI3wr4MF22IZSIoubnnibptmkSqvpxcC5Qs7ffu
         fePOJZrQG9R7ML6Zuxlmfb6XWMCRP4C2GmLBbLBt601WZePis3aAj+meSlBqm5gaD9tv
         jHn3vMAa5Ewy3rhhi2anBB9Ah5ySMbB74JFxEyEAT54UjcpFAMe0kWeieqGjDmxCBBzE
         +8W4WcJjQCP1j2sm8nkxD8uLx6pxX9JCnIN4RTPNbzAmlNbSdyKgjkUzzQ19XxE4mNo/
         fj2PCbRX6DyUk8C9T+8ETwrCx5d7BT177+Rl+9tHwZAPBQLD07n+UE6jwTC7HIHybQFv
         WgbA==
X-Forwarded-Encrypted: i=1; AL+hErHMGhgQwRFEXoilVqy+vB9hSubWGSQTRzzTN+9miiDDY3uDoZNgqKMBh68YktDpb3Qwfqn7ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z8S0vYNLzWItnZcNmkyXnEktAKJrzC5twB8LEEMgf+JMFslEEyo
	L69J0WDFT6ZVWlaLhiCa2+GcSt+yzhYWElUyDrlL4zlUXtErQlHrZEy9iNeXV/X9PdKoXUY4Vcv
	hukPTKZPKnvuA9HwW+ghBKEJGb1IemXo=
X-Gm-Gg: AZFdTZeesQVMRi9JAXCiNp24lqFRn+UeP2fRKEClJ4rEEeRRcL4cU/XIGtmgTWEwBU+
	G8tZIQQKtQahzXctKCodqTbwDG4C3jUJKM4v9Vhdly6aNRj7x8Cmwp7mdIiTGGJIN9PUneG4/0W
	2B1KF4JjMYpZaf0kxBgLu4Ghe1aPzcsfxMnR+2cdPsEufSXzvHRszSkJ/nhaqb3IDHvbvB8Q5hC
	c0+K8paJFZxyg2gGcU2l8S+hzUPhakFHcsi336O8VgMcwrcUdokb6H05qSwk3tMa8yBvHKmARi+
	c/zIngjvZRoE8X8/48afXDfTrVXjwZVmdoW3Db/tXOKQALHO5msS7OTt1s2H+ha97jUMlKeSqyT
	v6cImpCshy9WdGqYsq2fMvO+nfDOHWQbmZIy/I121nQmc01DNMP2MUcFgRd1mlEgKdEgCiA==
X-Received: by 2002:a17:906:ad1:b0:c2d:d408:5d9c with SMTP id
 a640c23a62f3a-c513ac9c0d9mr1294611566b.48.1795744929390; Thu, 26 Nov 2026
 18:02:09 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-8-8ffea39934a6@tencent.com> <e85a2666-9722-420b-9a60-9d4251fc3d4c@kernel.org>
 <awa30hwg6x82REoo@KASONG-MC4> <8ec3f3e2-5d3a-4bed-a571-88f7ba473b00@linux.dev>
In-Reply-To: <8ec3f3e2-5d3a-4bed-a571-88f7ba473b00@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 27 Nov 2026 10:01:32 +0800
X-Gm-Features: Aa3M54rPWlNF1ipPnICVor68aKhcFmTtxDUbh6IGLENPtyVP2_2XjRG7xOmJZ1o
Message-ID: <CAMgjq7Ayu9H85wurRAUdmXEPWYi9BdLJW13BhK+LMYoBX_7fuw@mail.gmail.com>
Subject: Re: [PATCH v6 08/18] mm/mglru: make folio lru referenced times count
 a generic API
To: Ridong Chen <ridong.chen@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
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
	Tal Zussman <tz2294@columbia.edu>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 9:48=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
>
>
>
> On 11/25/2026 8:36 PM, Kairui Song wrote:
> >> On 11/23/26 19:53, Kairui Song via B4 Relay wrote:
> >>> From: Kairui Song<kasong@tencent.com>
> >>>
> >>> Pure code shuffle, no behavior change.
> >>>
> >>> Make the folio LRU refs helpers available regardless of CONFIG_LRU_GE=
N.
> >>> Without MGLRU the extra bits are never set, so they are inert. Move t=
he
> >>> lru_gen_* helpers into the CONFIG_LRU_GEN section.  This prepares for
> >>> unifying the API for checking folio referenced and workingset status.
> >>>
> >>> folio_migrate_lru_refs() now migrates the complete refs count,
> >>> including PG_workingset (bit 1 of the encoding), bitwise identical to
> >>> the direct copy dropped from folio_migrate_flags().
> >>>
> >>> lru_set_refs_flags() skips the nonexistent mask bits when
> >>> LRU_REFS_WIDTH collapses to 0, preserving the two independent flags f=
or
> >>> !CONFIG_LRU_GEN builds.
> >>>
> >>> Tested-by: Zhao Zhenzhuo<zhaozhengzhuo@uniontech.com>
> >>> Reviewed-by: Kunwu Chan<kunwu.chan@gmail.com>
> >>> Tested-by: Andrew Morton<akpm@linux-foundation.org>
> >>> Signed-off-by: Kairui Song<kasong@tencent.com>
> >>> ---
> >>>   include/linux/mm_inline.h | 55 ++++++++++++++++++++++++------------=
-----------
> >> I'm starting to feel like all of these mglru/reclaim thingies should g=
o into a
> >> dedicated helper.
> > Hi David
> >
> > I saw your comment on other patches too, about the header mm_inline.h,
> > about ~690 / 860 lines of code in it is for MGLRU / CLRU only. The
> > rest ~200 are for VMA / TLB / MMU.
> >
> >> Can you do that as a prio cleanup in this series, so we don't have to =
mess with
> >> mm_inline.h in later patches anymore?
> > Perhaps we can instead move the non LRU helpers in it?
> > These helpers:
> >
> >    - anon_vma_name_get
> >    - anon_vma_name_put
> >    - anon_vma_name_reuse
> >    - dup_anon_vma_name
> >    - free_anon_vma_name
> >    - anon_vma_name_eq
> >    - pfnmap_track_ctx_release
> >    - init_tlb_flush_pending
> >    - inc_tlb_flush_pending
> >    - dec_tlb_flush_pending
> >    - mm_tlb_flush_pending
> >    - mm_tlb_flush_nested
> >    - copy_pte_marker
> >    - num_pages_contiguous
> >
> > All other helper in mm_inline.h are for LRU. So we rename mm_inline.h
> > to mm_lru.h?
>
> Moving the VMA/TLB helpers out looks good to me as a first step.
>
> For the LRU part, there is already mm/vmscan.h, added by "mm/vmscan:
> move struct scan_control to a dedicated header" in mm-new. Most LRU
> helpers are only used inside mm/, e.g. lruvec_add_folio(),
> lruvec_add_folio_tail(), lru_gen_add_folio() and the refs encoding
> helpers, so they could move there instead of staying in a public
> header. Barry also suggested moving lruvec_add_folio() and friends
> to mm/vmscan.h in another thread.
>
> A few are used outside mm/ and need to stay public:
> folio_lru_list() in include/trace/events/pagemap.h, and
> folio_test_workingset() in fs/btrfs and fs/erofs after patch 16. So
> maybe keep a small public header for those, and move the rest to
> mm/vmscan.h, or to a separate mm/mglru.h if it gets too large, as
> David mentioned.
>
> I can help with the mm/vmscan.h part if that works for you.

Good idea! Maybe you can send a series to do that which I'll rebase on
top of. Feel free to take the first renaming patch too since they
should all be zero-feature-change :-D

But please help keep some helpers in a public helper so when we are
able to get rid of folio_*_referenced and folio_*_workingset, there
wron't be some strange header inclusion issues. FS users quite often
need to call them, especially the folio refs related ones.

Meanwhile I hope we won't take too long to get FG merged because users
with swappiness 200 could experience serious regressions with the
recent swappiness change, and there are already several long standing
/ recent regression that are waiting to be solved by FG :/

(Considering MGLRU even used to try to completely ignore anon reclaim
at swappiness 200 about a year ago, maybe that isn't too much of a
problem, but it's still a problem).
