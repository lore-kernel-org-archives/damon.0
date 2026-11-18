Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037370;
	b=VaaJ9vaVrzPZUK12rMIsMKmkJoO5vTO9ubt7hCjILsQI2FZGF8V07aR/fuclk5ArXlE8
	 3HZCkeJ1wksW+6ZATAXSJOp8rNWJWIuISeMn2O/z4g0VTc/xQ1qMahSZunZVPT49DuF96
	 JZP2u+tD+4THHmMBft/zWH+vyFk+u2PN+RTGVRS8b1KM6X4eTcdioEdOzt85JbJmWoCwI
	 7VRWBh8M1KqFwWZotR0iPBiE6EFXyCO5GYysULVwkqITEsOzHASi1TTxNf60yFa1otM65
	 vAfYUFiNwfMqaKFamKP+w65dCejeIpgB/RP1cFSQrEc54U5n7IjZYVCPRkvWboXuRvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037370;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pDd6kQMiQ/fbUgeU7+jjKuq8JRpf7TlSBpFKWDVXLzs=;
	b=u8e4Yb8aa2K1uUw6ZDkGkrC/yroHVyavegjK1d1gv0n3potBm68ogFwUHKwDiX+fuy4B
	 O9KwIiu3cpOuZiOHwDaU2GFlB9KjTAaAKsmS/A4WJ4ceK8nwoiQy9y56IG4t2fWwS7Ppy
	 slt+pcPO7cS71E1KJ/qYIRq579lQK7GgfmJtV3aY0JOpfVb++8N6cfxXUQXEu3RBWQUAF
	 gUz/zPd8wF0Nvg4EigAzkDcAA0WbcPGWSbI76tiUeU0rU0MqDEoeCbsBmqgCYZFZPMuH2
	 4pWbfban6kWNNyx69ZOrRO8KIfntazzLEnalXSSQVDvfKqNiC1zevKOoXHlh+72zgVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdmHtrDo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5E60A2606
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdmHtrDo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E3A1F000C4;
	Wed, 18 Nov 2026 21:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037370;
	bh=pDd6kQMiQ/fbUgeU7+jjKuq8JRpf7TlSBpFKWDVXLzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QdmHtrDoX2PP3leUa2Bp/73mnyQb9l/q102FSOYmDz728P0nVzXV/ACL5vUHezaLD
	 Sx7/DURzJ0iHZ9Hn0xciVNDPhGkcVZCLEiUSWFlQCEwkC7ctLiAZnczdAlcYKlMFF4
	 RGXrn64Iub3NIBhMjDzbIjV7WXr0lK8uS29gc/Iadp8TFBayBAzCj+CiO5yyO8Z8YN
	 bZZ/161INj3g5CB4E7vi/AqtLTVCDAv4uSOsFgpi9Vf4JV4hLQTSAuKanoVKppFSxf
	 pAwIU7cwGdq07bh+EvItjIEQdbloAVvu4q+meRXCXxTr58JnKRMNsgwE2bMLCltPcm
	 3RwnCOd04XF6g==
Message-ID: <sashiko-outbox-221996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/17] mm/mglru: folio LRU refs based active/inactive
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
 Wang" <wangzicheng@honor.com>, "Chen Ridong" <chenridong@xiaomi.com>, "Tal
 Zussman" <tz2294@columbia.edu>, "Kairui Song" <ryncsn@gmail.com>, "Xiang
 Liu" <liuxiang.277@bytedance.com>, "Ehab Ababneh" <ehab.ababneh@intel.com>, "Zhao
 Zhenzhuo" <zhaozhengzhuo@uniontech.com>, "Lian Wang" <lianux.mm@gmail.com>, "Joanne
 Koong" <joannelkoong@gmail.com>, "Kunwu Chan" <kunwu.chan@gmail.com>, "Hui
 Zhu" <hui.zhu@linux.dev>, damon@lists.linux.dev, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <20261119-mglru-fg-v5-15-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-15-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:29:27 +0000
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
- [Medium] mm/mglru: raw folio_clear_referenced() in lru_deactivate()
  paths
--

commit b8ed2e873fb1f3b844c7ba1fec4ae00c0c04fb88
Author: Kairui Song <kasong@tencent.com>

mm/mglru: folio LRU refs based active/inactive number accounting

This commit switches MGLRU active/inactive LRU size accounting from
generation-window tracking to per-folio reference count thresholds
(LRU_REFS_ACTIVATED).

> diff --git a/mm/folio.c b/mm/folio.c
> index 06c9cde834f76..3b5ae5b516504 100644
> --- a/mm/folio.c
> +++ b/mm/folio.c

[ ... ]

> @@ -552,10 +523,12 @@ static void lru_lazyfree(struct lruvec *lruvec, str=
uct folio *folio)
>  	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
>  		return;
> =20
> -	lru_gen_clear_refs(folio);
>  	lruvec_del_folio(lruvec, folio);
>  	folio_clear_active(folio);
> -	folio_clear_referenced(folio);
> +	if (lru_gen_enabled())
> +		__folio_set_lru_refs(folio, 0);
> +	else
> +		folio_clear_referenced(folio);

[Severity: Medium]
Should lru_deactivate_file() and lru_deactivate() also call
__folio_set_lru_refs(folio, 0) when lru_gen_enabled() is true, like
lru_lazyfree() does here?

Although deactivate_file_folio() and folio_deactivate() call
folio_reset_lru_refs(folio) before queuing the folio into the per-CPU
batch, the folio stays on the LRU list until the batch drains, so
concurrent accesses can increment its refs count in the meantime.  When
the batch drains, lru_deactivate_file() and lru_deactivate() still call
raw folio_clear_referenced(folio):

mm/folio.c:lru_deactivate() {
	...
	lruvec_del_folio(lruvec, folio);
	folio_clear_active(folio);
	folio_clear_referenced(folio);
	lruvec_add_folio(lruvec, folio);
	...
}

Under MGLRU, folio_clear_referenced() clears only bit 0 (PG_referenced) of
the multi-bit refs counter, leaving PG_workingset and LRU_REFS_MASK set.
If the folio was accessed at least twice while queued in the batch,
lruvec_add_folio() sees the surviving upper refs bits and fails to place
the folio in the oldest generation (or re-adds it as active if refs
reached >=3D 4).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D15
