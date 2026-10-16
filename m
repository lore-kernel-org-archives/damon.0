Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DC38D412
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131400; cv=pass; b=SQC/Ob3QRspWQZhq50xl4u72vsVeUUYGpfMo7CmU1V5LnHeMjCulC/lzX7M4xiyyN1flfvF+mbJz5eAMQGwCTaiAGje07k7QyQEpMECOJqIQ/vFOZJqTx49R6GLK8Gs2QiIHxiJo9AKEQ/cQJ1DrogUes8R7kok9O3TlKp+F1wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131400; c=relaxed/simple;
	bh=btnoV6CU2q0UBdK7jbLnMoo6ItmP18ZDQfYmAVaSBNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0hK4gQpPfFdgzhn07yqrigGdheHeBIvkVdiA6ij42Kv/OgUsYGnRKnp3Itxgk/mP/HewiZxUNm41V7BS8DnQ1SZ0MQ3VX6MHvjdCKUIb9FZOXHWmG8DlM1EJCNhwfzUeP+0QkiUWNCeMv3NXMJ9wneqlgPFHA9BwA8wMOMzQ9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXfEscMb; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXfEscMb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-88bd2b44f3aso3066178b3a.0
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 23:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792131398; cv=none;
        d=google.com; s=arc-20260327;
        b=aYX17EpCs6uBJmaWqN24jBs4biei7YkNj37FVva2FTQk/w0N+jNdfVVOw6XRjjAKOC
         SO/A/1rVRVRdnhqNVfG3mL5l3U84Eww0dyFdc8eyQRIMQTZMh7hbcAkNxmn0+5PE1dUd
         P/cMSqjPm5Um0yunXQj6vEpYfbuzxxWxlJ7NjvhRG6BhNi94atuP0wdSFeAcTT3JbPs6
         9JFk728ryUiH4Kn7YoBXXYTEfh29I8Q7wzxQLiKMw3VOMrm1Qj8WHr0DxNa+T6iXdCla
         fC7shWBImIQn8Nho0fk8uERhPDkSKQ52CdLhaDXZuJHxu5Gf8W1L/edI5fshnjl/FFvK
         ZAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nw95ViH0murspGBeVdDuR7/ikIvvt0nVUNuA1BMwLqs=;
        fh=Bc28KolLynOWwHWmMgPT7DGSkYOTnqrDW3l7WKYQm9Y=;
        b=nQORHcZDQPgCoW7m0Dt4HFdP0ubBsmHCwroOeiTL/y8HSNs1HKYRGO7z6WegWU0UAt
         Ojf3usHjM+6wndpVz1dm5cEy/V4jUWG4mnktu1NMCDn6IX8RqTwUxBNqfhpZ8ji+Tldk
         54LHjfU6A5zOPw6x8eZZAl5P1nPklohYORP7cvOWiCGHPkGN4Tdeyc1RQGY7Ag37/cOB
         3go+e/K1De+0Z21m7wlPB4P+WkIgV1w1GY186144T5ADmaIWld5XSvnpT9eaRmurfOWG
         LY1PpouRFrwdgc89t4qFoCmtaABITZXEwkI87rT5w1ugtZVB+srsnvSf+91KfqH8hK4f
         q+VQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131398; x=1792736198; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nw95ViH0murspGBeVdDuR7/ikIvvt0nVUNuA1BMwLqs=;
        b=cXfEscMb5BmlIoLvpQMO+Q6TOtCUVRgBlIPEox10WHfDRTd/VOgvRYiTVe7alP+67s
         qt9cP1IzavtwxXUhK28FMKkh2Ia25rxQrfU+8wYSqx20hTo67l3/Vgnl+yVUMYX4EZ6z
         LnsgX1CCra5oWfC9K5C2V6UymnGlRbXeOZ3AdeLVsvG9u2s6/tRiuOuszAazifypSo2i
         HPR4vltLA2yuGuekeT7oIf/KcLWH9nnckbIwaF2nu69ejbYuHLOrB4znaei0QZSmvfZ7
         fKVXrokItBT43RSlvqb07kRgphLzjhcRx+izcc1B15v5u5Ga+2E89fe7xgr7D2WBeBtu
         nZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131398; x=1792736198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nw95ViH0murspGBeVdDuR7/ikIvvt0nVUNuA1BMwLqs=;
        b=nGwyA43cZ4L8dHL5vgnj+uvr2qWmsT7yb1ehZfVE9byvos0BZ04KnUXCuhHs7UYCKj
         4xkikC1U0igLl5OMMrVkGUUB/+F6q/ngiWZnNcxcU1CCfcE5IjJeBFZv5kIIjqNWNv0/
         YoQf1aq4vImXO9BKRu4v9w0GPaL/hfPwa7EBIwyrVz8OTtX0+74/xsjSoXzp8OLhwYDO
         AFj+nuUvQmMM4hHnzLEZjO+IJJ3znb3R+WlyeAf+0usdGnFGMSxNf2Qbo0GFllFPA5/E
         B2fiFIgymZ+DN7XkFQE7w5olehuIBJ+kNbOpOo3Yocy9NT8CVa8vjvpMjsRudaV+abMC
         JToQ==
X-Forwarded-Encrypted: i=1; AKwUvBywEpOic/4vWbskacbv7Z1khczCt9GzA1n0e5Qlya0WxxeoKRLWWa/0RVBcmqk8gX4lH4+GLg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJKVg2diOHsbK2vOTtgchl7yvFWTV04h/S9gEJD6LrFGIoRv8po
	P84TNdD+K/YPFYNg5g6HL43RqF827bBycWLbyQTvUbc6lPRfvkTECpeprvaNsmgUxNGKu8hr9tr
	5QNfX8eN0NQXbkFqCoE15ltjd8LsTUBk=
X-Gm-Gg: AYBFou0qWg5KtznhFWVpZzO7vUfK67mFPkMuSaGk+jNs74+a/0l+Q/deMwQbvvLPNE2
	DdgiYAD5VUjxHGelA5Bjqn7xyVJR7CPRhIukQWKSM/KNS28fvHWPOVSsm53daSYq7e6ff5WCqXv
	Uv/gzs60MOLNA7kC5wQcS1dtnMC7MtjXE7d3Y2e513qqZkA/w33247YRf6WTuW3J+Ug23kCl4pT
	IObl/SHcUpiCVVWouFCgtlJzMRPuzZ2csTYr48OB1ehjtGWRhL9ru3H+4EMGi6Ymoea6nFyD2FY
	+mthhLwkpQJJU9+XIgeSFSM1+OxQbNcOoZjv2lgoXVoXdoqy6Vavc8pOHN12gHJiPrtZie45nrk
	rLrZkHk4ld3djIThsoX41OroKxIGTf+g9kNz+PT7E03B5FEkOu7+w1maM8cID/ZrsOO9Fog==
X-Received: by 2002:a05:6a00:3d11:b0:88f:9fd9:3779 with SMTP id
 d2e1a72fcca58-897c65410bemr19217680b3a.19.1792131398279; Thu, 15 Oct 2026
 23:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-3-2106750c0bfa@tencent.com> <atEkfmRFgXJCbJuK@thinkstation>
In-Reply-To: <atEkfmRFgXJCbJuK@thinkstation>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Oct 2026 14:15:59 +0800
X-Gm-Features: AclHuK9suf2MtgpJ8U-2R0dSol8SG-UyxjWNOAi7XM84G6vCwX9BAPJIIlEtxbI
Message-ID: <CAMgjq7A6Yom=dHDMXk+mpYm3dotgOaVRjPHgUsOryjJ1VjPC6Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/17] mm/memcg: add folio-based lruvec live helper
To: Harry Yoo <harry@kernel.org>
Cc: linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, SJ Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	zhaozhengzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:11=E2=80=AFAM Harry Yoo <harry@kernel.org> wrote:
>
> On Fri, Oct 16, 2026 at 02:15:52AM +0800, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Add a helper that resolves a stable lruvec for a folio under RCU
> > without taking the lruvec lock.  It takes a folio directly so the
> > lruvec lookup happens inside the RCU read-side critical section,
> > which a lruvec-based interface cannot guarantee.
> >
> > No functional change.
> >
> > Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
>
> This new helper is doing the the same thing as what
> get_non_dying_memcg_start/end() do.
>

Hi Harry, thanks for letting me know, I wasn't aware this helper
exists, this series started before the re-planting work, so I missed
it.

But it's a bit different though, get_non_dying_memcg_start assumes the
caller holds a reference to memcg, while folio_lruvec_live_get only
assumes the caller holds an reference to the folio.

I'll check if I can deduplicate it though.
