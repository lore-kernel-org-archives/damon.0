Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795056340;
	b=Ej1rLT+GxqJ2ss4JD3o2UsDtHD28NlscoogE9NZlqN/+WgYqm6YnfGuofP+VRVRDAf/F
	 K1bC3JaM6g8WOC1jg5lQc2O4jfESR2aFR8RwLoweihvidvxNuz0DOyZkujopZ8/oFGjoI
	 xOfU2AhaHFF2FcRzPtPVFvjkUFII19Do558srFNZbtA4RMKU3517Bhr59nLzlGLCj15J0
	 LgZLMiGioT1TGTuIi8uSvrKWKMfH21oGRtUFzwebVySpBWDXN9J0O6MJOP5HFhFxAfsn9
	 2cwA7/vZw0elBYpNHQTq0RSgfCaaQY3LsIgB5T7D+F2Uwo8sS0A//YerAxD2iZQEXrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:MIME-Version:Received:Received:From:In-Reply-To:References:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=nHE4K0vpamVM1it9uzuLpZzTtHZ4wN8e10RDqi3C1Ys=;
	b=5GJax9hRMtt7Kzvl4Ix1hN0qmcIkgVjUliSk1zHSuGYmy/OrrmJo8ePAQFMH3qVsr73q
	 WibMiJT4brAGXC+9mxnkmX6HG6yG52pflrjSOiIrgdyrit3FKLW7KrVMTllQON8H8i7i+
	 M7th3iX1a7lfMYEkwaEmO9WpQc81lPHiJ2oKNkpnK9g84IbTuzr3YS65zG+gLFbSw1GsN
	 E0dzBOpCKvMM9z5mHXfK8DAgRn3VRQI+lHGA0zM8vcjKENsvI3FtMLqytlmRugsmWLaAg
	 qFqiCULtdQUe1SzG4L30uQZVeHl5vZ9VqkwZQ/bxJlFpKyhSobi8LDj629P3XCOg/6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2TdtYUT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A2606A330
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 02:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94A2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2TdtYUT
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91eb46044c4so20530316d6.1
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 18:45:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795056339; cv=none;
        d=google.com; s=arc-20260327;
        b=Hnc4apdy2h2wa6rIvFOgaAqJMypTKZ/M4qyRDDxtkgYf84+VjNsGrI+bDuV/MX5idn
         J/Z4rjg9BmYSXrxzvMR2OgWuB+05kV82EQHEQxQjGErKvZOIxxw9UBBI6s8+V3zO8bJp
         cLafHNhyxFI04VLd/wRMco+kzycrfXHfmqZOzmU6lofACu6janAFd+nzhRixGiJgjMpL
         gOv3IqFs2EzSzvwuqklgNdhdjJVZ1ESpdt9h4EP1IGuuERFoYwBD59Hpn3dd89of4HmZ
         SoeMM8JHmrrzu6scN2TdpgKLsGGK8DVqknvmIIH2m5qZO7/ehPJ7eq0ouJHJuAOAvRa4
         IfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=nHE4K0vpamVM1it9uzuLpZzTtHZ4wN8e10RDqi3C1Ys=;
        fh=QInPrQqv7wPsvZRL9h2S82tSLebXbIbqwUaVY1wS528=;
        b=oznAgduhl2jNlISxxDdQu6ALsokv7nVNmPZNThVnP4S6DqttQRs8aq/Be4lPy1E2sb
         noodbuZRqZz+9fXDMBf2rtIkuL+4Kb+x3Yr0TEQAEuZqBQyHBcZTLQgNAqqT0GZuYREd
         54zaQmcDg0OtyuKB1hSs5FD73GtIZZZOlqTFPxezQpIRYLxnZ0NRKwu4pd/f617lBgmu
         UMvOpaKo4JmOpp948ppWlBArMqcse9cMlRNJQCpUOVjOhZ9ogUTVj8L65nx773OXbfmW
         QhDM32XXWnKM9+PHmQdLWPGF+TCOJN+hI44lP5i6PwtrYO8G1w+atpSTDjK7ERqHfOUE
         OXGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795056339; x=1795661139; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHE4K0vpamVM1it9uzuLpZzTtHZ4wN8e10RDqi3C1Ys=;
        b=C2TdtYUTiDZo3IKT3dAkl1r04HBa31DKH87tXnyjxujepIXEoEHYwxArYO8z/J167N
         s7Ddu1g0Ym9YFStURXJ+kwTfYpfZgtjU4Co2VawVn03+5OKAaQtDeu1bbgVtS2MdFE/u
         5f1ctAwrB3nJjGu0n+8Diapzo6noVeFKpoH3s2+ao6WXxeG29DSVR1qDU0LXhiPjl8BR
         Rpht82K+9iun2NU03jcx8hCR68Aj3KVblEQKv0fvCErDf2yoO7IipMuONUgyPXSW814w
         USONHlfXLeASa6GlAc/JU41XpqnwM9yizaoPn75+jfJZS+MgiKy3NGAhJ7QiMWiI1uV5
         gw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795056339; x=1795661139;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nHE4K0vpamVM1it9uzuLpZzTtHZ4wN8e10RDqi3C1Ys=;
        b=122n0jKla6jTwKYjLXpyBxjKmbssYR+Emak2I1UEMSxAqmMqsSACUyLQVmEbYlgo6P
         MMrrCSw2AntG1QmRTn9CO7l7DQFrcm276qTfzG1lINzzADYdTAIk4c36rZSlaG6Oazep
         s6i9ZkmJlHW5/ET+4ANyWmhlIrkd/ZkMxjPe5BnNKf2fOzHGvCg1USJJ1Kh9ppxXYIBh
         CQmBYCtWa0V001lkE34EHVwjte1F6qpiBAPX1aboTPQrJAeSyCE+xlWVafxbCxSHdmVF
         55Zf5Dnqyv3mRFn5GaIFyd7Qgp17HgFozgp7PC46TKjOlhcjHQcdls2os5xw4ZiKkA7Y
         RXkw==
X-Forwarded-Encrypted: i=1; AL+hErEtzsjP7BO53022FzcSG/Lu+U0F6zcjGgUHphgoEM9XJNBhuIejYpNErNx+YPdcgBdMytNDGw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/J8dX54BeiWBGaSpJUL/1EGAkZb5/HscfqFOvANzkWtwxfH6rK
	RYxz0AbpUhS/GExMrkvXWRr1Sea8+W7fmZEX6vHDocO/Jeo4fcT6FAVGEdN+k/xyPGf63Isc8df
	PSbLCoqztAjIao3NzvXwg+EYNv/EhsRE=
X-Gm-Gg: AZFdTZe0253JG7a0qvylkX0o+wzV4nkyz+w6ZoZn58dFO9GgF74Kptx/jHViVdjfZNZ
	NiRTTFaz0MmapehgNEUqMq+QJyT/e36t226MrnJsfXCz3qkdTaijbZvbzPhoIWkfP30SR5cMpt7
	iY2rn1aUDZ1X+71wRV50+2V5hcRqgvClCgHnreL/pBPxjRFyaNJ5Ah/uZ7QHoWKrrhd0wcjbnVJ
	vOYqOFab6Yku6B0EktUWBx35xjH56/GKbB9bj7mF5lZYSL0VD6q3x9p/xUmK3xNppkmCZ/idGGs
	JZgijwxyww3T8p8Ni9bQ0io6z+UuEwv4ofrZNwG/2O6vQFLBvWnLjg+SD/LM/V9BSrvKi9Z1XMp
	9Z9JSfqNK/2XMz8QTNL6ARVf1BziCSaLq0r/g
X-Received: by 2002:a05:6214:4509:b0:91e:93bd:17d4 with SMTP id
 6a1803df08f44-92114f234d9mr68688036d6.31.1795056338595; Wed, 18 Nov 2026
 18:45:38 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 18 Nov 2026 18:45:38 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 18 Nov 2026 18:44:56 -0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Wed, 18 Nov 2026 18:43:28 -0800
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Wed, 18 Nov 2026 18:42:52 -0800
From: lianux.mm@gmail.com
In-Reply-To: <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
Date: Wed, 18 Nov 2026 18:45:38 -0800
X-Gm-Features: Aa3M54oczcrQgnIKIdlWRyAqAv-8pL4r_8Eu0gOG26vA4iWYOD9SKwZ3124B0Ic
Message-ID: <CAD1ZK4Zo_qQf5aJkVLtoc-LXM9XbyZd2Vy6rFvK_fih-6FE_EA@mail.gmail.com>
Subject: Re: [PATCH v5 01/17] mm/mglru: rename the generation offset in lru_gen_folio_seq()
To: kasong@tencent.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	muchun.song@linux.dev, qi.zheng@linux.dev, ying.huang@linux.alibaba.com, 
	chrisl@kernel.org, baoquan.he@linux.dev, nico.pache@linux.dev, 
	usama.arif@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, vbabka@kernel.org, surenb@google.com, nphamcs@gmail.com, 
	youngjun.park@lge.com, ziy@nvidia.com, gourry@gourry.net, willy@infradead.org, 
	baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	lance.yang@linux.dev, hughd@google.com, sj@kernel.org, rientjes@google.com, 
	yuzhao@google.com, vernon2gm@gmail.com, wangzicheng@honor.com, 
	chenridong@xiaomi.com, tz2294@columbia.edu, ryncsn@gmail.com, 
	liuxiang.277@bytedance.com, ehab.ababneh@intel.com, 
	zhaozhengzhuo@uniontech.com, joannelkoong@gmail.com, kunwu.chan@gmail.com, 
	hui.zhu@linux.dev, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
