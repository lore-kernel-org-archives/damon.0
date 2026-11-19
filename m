Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117478;
	b=vFHPd1KlQW0bvMsp1CGUWM5KwRDzwcuWNFA6e4MdkhW433INIZheDXCEtDCCiOXSecnT
	 I32BXtP0+IfmTI+rrHdG4JHjivaa1QkMyyY/3Y/piXMuAZx+Q9H1kzTtLQ+eaLcXYTjt7
	 HPrLPrWd+xr7bYMteoukQDrEBR4nrwDEoUifD7Zia1xDsFEeW/kk9GxQmz4U+FViUOT8/
	 PXS3uXqc/LRl7pSOGwagvxBDUsZ+2kPj3/n6+PyzN1vI4qfA69jrujEI//3GZhCf9T8oy
	 6aOlq4xceAt52Lj7JBstWSUcpM0WJ91WrEcm4H/6JYzYkprBRNWcmSe9gpm2oO2oq4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117478;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YKyrivJzo+Mben9cmzx8JhnXyAay12IuEg5j9gR3E6E=;
	b=fXQN1aVtyWse4HSD84Hdc/hUROJAM6p9Z8GCEcWj0gUNvGhkm8sf0ISwzszthOpQNllD
	 vPde5+myhVfznk9HhElx3ZdYxDyOTlzs3o9uM87IgyomcdoL4+qGlm1kq0tEKCIGmpqOU
	 1dHkN7UDb7uOdz4RlCILa2SjRk8eS9oVnsI1sdvAAXA903a8sdGSuuOL4nWwDVQ3YRQHV
	 kzHiVN1uX8BprcnH79ehheMtNVHw+u43fS0jOeFLtqS1tMbEV6pCjJi6Pt5o9sL6MBpER
	 BGAFWc9rQPYg62ESLos6IZpPMCcWzqrI/0kzMsR87Dd66N5Pdx9ZutU0l0Ja7aKJnEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaoXci3l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6508260A2608
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaoXci3l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA031F01574
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117477;
	bh=YKyrivJzo+Mben9cmzx8JhnXyAay12IuEg5j9gR3E6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OaoXci3lHVzfeCba3lln8uF7Qn9l96givMQbGbGKWNk7T3kABm78qlP4MdS4F2Fqu
	 /Y4lzfYPSQbPYX8HLaFPQqkRqRinSsLy7Vpz45XPcYOzATFoPJpOHNHjfGpSDDYrjj
	 TffPUltbSp9ZowtNe2jRuvCW2Qz4JzGn+hjouog7Cs7/mbtsW70Jxv9+lU57+sQkzd
	 CZ46yF4bryVojOPkVGe4AUHNOQlOW3G6NZ+jU3PO+JE90rMbrSU1GNBfzixhvtYMey
	 mfzINn1iW9Q9zHeH7kun39HuPeDfujI6kZnHIzb3UjSnlox3D4jA+qKJJQt7/nWmzG
	 KSVcUcLVqnyGw==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9496473b511so10499985a.0
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 11:44:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEBupXQIkUpjDu3+r4TVz8AfM+jByGBXJqmeffM7BKxEcPAoPjsAA8A06uh6A2K8P6dQxOCRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+15R8c2VsGOIGt64A9gNf5idGvThRWmenQRtG7W87GMmZty02B
	JgTHwP/va7VkE9DBZDKiBHHCk0puhoS2wrZLjXDBPnqdXZRUIszIdWrltYeDEZXUiR2uG/DQUfq
	Y+DuKt+1CYmp4qvu/idLY1tYeKUJC2Y8=
X-Received: by 2002:a05:620a:261d:b0:93e:c12d:4ec7 with SMTP id
 af79cd13be357-949b3841debmr323824085a.39.1795117477060; Thu, 19 Nov 2026
 11:44:37 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-3-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-3-9eee2fe97a2d@tencent.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 20 Nov 2026 03:44:24 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xXdPsnHFX6SUff_1vbsEmGCHdZcXAmOumiN8EMar+KAA@mail.gmail.com>
X-Gm-Features: AclHuK_KKF5P4wFEq4Ot8gOVbDoJlPrF_Qs2r1floMy82S2ahYTVnc8-alAnTWA
Message-ID: <CAGsJ_4xXdPsnHFX6SUff_1vbsEmGCHdZcXAmOumiN8EMar+KAA@mail.gmail.com>
Subject: Re: [PATCH v5 03/17] mm/mglru: make generation page counters atomic
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:03=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> No feature change, convert them to atomic so we can update them without
> holding the LRU lock. A temporary underflow is fine: readers clamp a
> negative value to zero, and the counters only need to be eventually
> consistent.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/mm_inline.h |  6 ++----
>  include/linux/mmzone.h    |  2 +-
>  mm/vmscan.c               | 26 +++++++++++++-------------
>  mm/vmscan.h               |  2 +-
>  4 files changed, 17 insertions(+), 19 deletions(-)
