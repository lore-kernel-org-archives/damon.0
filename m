Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065278;
	b=ECLDahiL0sJ+vqQqaU3LuafF72zbNhbUDiGZZNP/23J1ow2vXtp/WHXWJb1wtTTFcAS/
	 fQySYywNvCaj5TLdBpJrYVwXusQ+RccEgqDWmUvE0G+kar0d66qOuiZSM6x4FEsQQg12b
	 +6cpguV7jy3waE/xOpKcM3Nu9ui9oS5iWQeDXvqdjLGf4KM3bpUo/jDsVGgYYSOtjqrP9
	 nfSwUMZyND/GACYlMWeFoAQOvWt84R+c4+sHhaZt4YmIFDQCfu0wvpus8+Jfh7R+RNXk1
	 iprtdvr0fPUApJre9irBITVk5hYoHpUesrEEdLtulpxelzjQicSXnY6VT+IrESraosg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wyxiWuQSWhgvdEtewWdluvJTi3FrncODBevXsHd/xk4=;
	b=DPNq4Fm0EmP+ZD4yN1rMAmNMvvT9MnYPNNcZhqkOSDJKjIg0QvDtlc8pMya0cfx6QSVf
	 jQ/W1Fgged8oCBibnWULIHBBi0YyzNrXlzwmO4uW0DDScHYqYemO0mqYZgvP6kmqX3mAf
	 8lHWi0FHqwsIIuG90bf+jYiEOaBZjiqLKttAnN6LA7QX6hEFOHZyn670A0qH7CY6TTx0o
	 Nfw/qNm8l54Vvg6j5JJ8UyE6LEqN+CmFP9EJIvfJNhJ/HsRKMvXfrG758llYZT6c44bV6
	 PlCg6if6WY/MUEiV5QowSfsKyWwfousKRNHIxTfyvGgZFZ1cljlPSc5pkJHLpGdKILA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ElcCNTAW;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE0606A32A
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 05:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BE0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ElcCNTAW
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso1303027a91.2
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795065277; x=1795670077; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wyxiWuQSWhgvdEtewWdluvJTi3FrncODBevXsHd/xk4=;
        b=ElcCNTAWs8Up+hYPSrwLKosAu19MUbFJ8LdkrXBQic0OCgDBKPOxaTTWmA5iDwodRs
         apreaolv6VdmzUOXnigaZjKqL7i7WsVPULpfv8TYAB+QWtc4Uci0V6H1uLLf05QHr7Ah
         SpvLbBDz1DHfBZxsXy0vQn5S9FC4kVt7ncWe0ogaZdFpIxmnrLQD96wo4DAAsyJCz1vJ
         jGbxkbnPeTX7TpWqG1U5aHbKSiCniEAdA43FQAElt8mYPyqFWpklAqpZMlFI2dhUHTxo
         gwiWgXWnGf+b8zdndXb3sbgzgh08Ln0NtLgI/LoHcjNG5TjOKy7y3+Ez1aNQeufPXQqw
         EKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795065277; x=1795670077;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wyxiWuQSWhgvdEtewWdluvJTi3FrncODBevXsHd/xk4=;
        b=zNrVojg744vbcLGHGONK59S+uAmWjNmkl8ueekHIkyZbo7HLmUdvsZqRItiKv1l1Oc
         DXB3V73pIuRLH/YDlOmukmx9RrKfLuYW+hB+94QoZh6vdh6SM5hsCwlj/FuHDzhuklN+
         /5VTIQAIVflSv1SlNCBuVokVtbkcH9C7v5/U+JSC0Ah0amQnUO9X/ZbodLGJC+BkaAnn
         mD8DNEwY73spLWPpfkZOIECXw6z0MLZDjRyZBMIpMILw6+mUzF1CtUh5hYBx/sCjZvSn
         aAX9hahr8mTkfO/1TEOIlYCzZx25z7o4dUsjvn2ovQRpjA1ME++R7QgrZC3gXggx9dcx
         vaLw==
X-Forwarded-Encrypted: i=1; AL+hErEaBSqQlfOiO0NZacC6A14ptySUT6JuXAyxfySuzychNR1KrFAsdHUiQTGLgwKSk3Pnpp7+Fw==@lists.linux.dev
X-Gm-Message-State: APuU4Z92eRe+R5ktvkV3umNUlgrNmqa9HjeSTPs6g8YyDKqV0SdhBVP+
	qk2KkbsE79jr9d74wWA7BoP3wf4axoKIdrZ9LoqDWR0WbyhzGsiFQU8e
X-Gm-Gg: AZFdTZck5Ax699ZIjaRRCOLf2SqR9mqnvzTL6JoPbUwze+MO/s7mB0GaX1UpaObXlsk
	MsKE69T9SxQj391NFrMtJ9h+05UqgdfvUs1KcwFqxrC9b+RmsjA9I/nCjINMjOnOVk9bsfR0pit
	5KOy/L5aj54oNBdtojLYBoCrs2JntURoyZ+OSpqhJ8ldlVjuowDQHwZgng9QNQHlhZHrX23KhnH
	A8t7Up2uBTWTqEqU96EVxwgwN44w+xe9TG2xg+U9a2Rrit47+gXt3PbD4Nh4lcY3RNhFEry29ob
	+Wzu3UlNMuUHLGGNZL78F3FH02MdAqFRvwB8qtmWcqhAtM+Y6lA1DpqfsEy8ywL951dg5mVKPG2
	aIjzbw9nYd0povEVpnHIX2FCdnD4QLfDzssfb/N7uYqRhFHHmSd4wr+NrpGr2Eh+OJumOA85oPV
	KmkoQuJo5AFVW7tlZPyGNwfVIxdHd365mYZATdzI8CnnJrqC3+VAAaWAy5R9vp+nTRJwHcSYDRN
	RU+TOD/m36KOGOxb4Jcm8sK9T+ZvJAcJQxcCiswQireJdt2hUSUvxJ1Coxup+nJ1n0LqWtlTSTD
	F+iNCoM88liYaLLD1fE1WIbXXqdaVCNLz7OB8y9W9mF8KilqSFpAR6D4DGeTfiR4LDebdd4=
X-Received: by 2002:a17:90b:4b86:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3b3d06a487emr5255430a91.6.1795065277522;
        Wed, 18 Nov 2026 21:14:37 -0800 (PST)
Received: from localhost.localdomain (vmi2317697.contaboserver.net. [85.239.239.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff628b4ddsm23497315ad.62.2026.11.18.21.14.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 21:14:37 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: Kairui Song <kasong@tencent.com>
Cc: wang =?utf-8?q?lian=EF=BC=88ByteDance=EF=BC=89?= <lianux.mm@gmail.com>,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Nico Pache <nico.pache@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregory Price <gourry@gourry.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	SJ Park <sj@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Vernon Yang <vernon2gm@gmail.com>,
	Zicheng Wang <wangzicheng@honor.com>,
	Chen Ridong <chenridong@xiaomi.com>,
	Tal Zussman <tz2294@columbia.edu>,
	Kairui Song <ryncsn@gmail.com>,
	Xiang Liu <liuxiang.277@bytedance.com>,
	Ehab Ababneh <ehab.ababneh@intel.com>,
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Hui Zhu <hui.zhu@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 00/17] mm/mglru: frequency guided promotion (MGLRU-FG) and flag cleanup
Date: Thu, 19 Nov 2026 13:13:33 +0800
Message-ID: <20261119051404.14533-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit

From: wang lian（ByteDance） <lianux.mm@gmail.com>

Hi Kairui,

On Thu, 19 Nov 2026 05:03:32 +0800 Kairui Song <kasong@tencent.com> wrote:

> I also retested the LevelDB benchmark from the cache_ext paper [4].
> Interestingly, mainline MGLRU already beats CLRU on this one after a
> recent change in lru_gen_folio_seq that bumps new folios with refs == 1
> to the second-oldest generation as discussed. That change accidentally
> gave random reads a higher hotness level while making sequential reads
> much colder as described before [13]. However it's unreliable and
> incorrect because it depends on LRU drain timing, and hurts some workloads
> as reported, or where the sequential part is actually hotter (any workload
> involving hotter large file and many small cold files will be affected)
> which is reproduced below.
> 
> This series improves it while covering ordinary workloads too and fixing
> more regressions:
> 
> LevelDB Scan / Get, Throughput Total:
> CLRU:         4708.3 ops/s
> MGLRU:        5026.9 ops/s (faster than CLRU, but hurts other workloads)
> MGLRU After:  5179.2 ops/s (even better in all cases, and no regression)
>

We did observe a LevelDB regression in our earlier tests on our
machine. The fixes and results discussed in your cover look promising,
and may address our case too. I haven't retested v5 locally yet, so I'll
rerun the workload on the current base to check whether the regression
is resolved. I'll also look more closely at the access patterns and how
MGLRU behaves with them.

The results on file-backed workloads have been especially encouraging.
Next, I'd like to discuss some anonymous-memory workloads and potential
fixes with you.

> Others
> ======
> 
> Additionally, PSI, smaps, and readahead should all benefit from better
> accuracy since this series unifies the flag usage between classical
> LRU and MGLRU.
> 
> Other tests such as MySQL are looking fine, with no regressions. There is
> also community test report [7].
> 
> Refault distance is not included yet, so MGLRU may respond more slowly to
> workingset shifts. That can be added later, as previously demonstrated
> [8], [9].
> 
> Extra note about future development: this series is actually highly
> compatible with ideas like workingset reporting [10]. The "gen climbing
> folio" design may appear to conflict with workingset reporting's idea,
> but it doesn't. The solution is simple and straightforward: once we can
> extend the generation number to a larger value (e.g. 64 or 128), the
> refs-driven promotion can stop at a lower gen (e.g. oldest_gen + 16),
> leaving the remaining newer generations as perfectly time-gap-separated
> bins. These older gens can be considered as expiring gen.
> 
> The tier count is not fixed either, we'll need to find a way to tune it
> if tiers go beyond 4 though, but that shouldn't be hard, not a blocker
> either.
> 
> More details are in the individual commit messages. LLM is used to help
> improve the comments and tests, all results are double checked.
>

Thank you for this outstanding work! We've seen some really exciting
gains in our tests, and we're very happy with the results. From our
earlier private conversations, I know how much time and effort you've
invested in this. You deserve all the praise for that dedication.

I'll continue reviewing and testing the series and work with you on
further improvements. I'll go through the patches one by one, and I'll
share the workload scenarios and requirements from our side as we go.

Thanks,
Lian
