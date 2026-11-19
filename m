Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117450;
	b=efWLHF8yXyEb9kSmk5hG76VxcIYnEwRwFcXM+1dTHptAtAhp1IE29sWtYQbkZ4SoQULx
	 S0NqeSFu+lMPiuuMpZzHxgCEC8km5l2McGjdljy0p//OnkrHj1ytjR7Z8cD8UjpUSQNdc
	 wl1WWdZ0PLSp7gRmstf78pPLm5frdw8KecroymEAjJIAF3FYlR9A6E2tH0uUstP8UPLzq
	 dq1UMIxf1LoyuG1YDTb9Zdr8LvJv/kwQCtZqMqz2E9RnYkG/9uhgl7qVzLZE1IMFh2/8u
	 gYkF6SpcbfKYXcFhnl29Y+lfWeQcQUlPHaApL0uL1se3uz9tVOQFCuCFCo5kFsj2+tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117450;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sB1Pq7vBNntqu94r/2oUTzxPCprX1DSImM5jhZ6L7Ys=;
	b=uCeA6Ki9qkBDc5lmFTkGUutBu3m8uM6cqFWnQk2iJ1M2kA8yHYEWfRREufl6dqvCnZZF
	 Ufz8GNrkVSlbT3JfC+VOLFNu2aB9vsWBv4uSsYXoGVpxOJBsoCmgK0PKyPWLVfJoMPY8x
	 hZlKu3hN+srph3o86Yg3IUJV9J6yiuvaXc5ev49JIBS2H1WKgxNt9VFD4E6Cd1A88VM5e
	 P03tk6gACIZXnOXWApykag/syZHgxFEiVm4cbKy+agwqrM8G7Z+up1pTmT0tD0HeQHQUA
	 /xQFgLo5vsf9Onj4PiXvEZoE2kNEa863YNNaM3lIq660TpqcTLwVpQChk8i1/SzGzdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IeVLrVCS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215D606A338
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IeVLrVCS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05971F00927
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 19:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117449;
	bh=sB1Pq7vBNntqu94r/2oUTzxPCprX1DSImM5jhZ6L7Ys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IeVLrVCSsRPiQX0drUz2UWM7wWQUoOv9UhM9eXUGEnnoMcl+sQW+qiCun3+CTmWkV
	 mi/z8zorQ0ZxXwChyn2aP6ccRSaXE9uwamxIHeos9YGbYyFT2rbjndXO694GPBly+2
	 6KuZK6TJIwcGzxnyatmp98KHy8TPz+7rfIzZRNZp0T5Li9IYVmSLsp8gOT9puZ22bv
	 xvd0gn6xaYu+9VYtSV98kfDQkkgDxi0n63CKvmRsbGvvKr9aiBgR8OVAiNJmkLOF0O
	 2WDCxDrm02ztgXhsgGUGkmjZPeUM+3m4wl+RxhVKX+MYCKfabM6JTsL9CTVKC4O29a
	 EBOJBLo2oZtzA==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9495c633eb5so9162785a.1
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 11:44:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGA3LsAhWC6/Kn+oiNG6K55RcWkdeTw4XNVtc1wR/NyEP/dF8drs4eMNpYFhiEvaqGVFaIwAg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9iWI7JYGJnP53ScJgvnih6lGuvyAcCZuE0UuIctHrBRzTH50cw
	Qx+N3phvk9tbWVzk3/9mG2Jv5J3Lyadbx0ALGLY5uriVpr7YW/RAl/FTCoxIDUAAdYONA90HObO
	ivu6cX2ykDxDAPbs2j8iuLmcpNqFTidQ=
X-Received: by 2002:a05:620a:130d:b0:943:f301:49b9 with SMTP id
 af79cd13be357-949bab32ac3mr114181385a.53.1795117448550; Thu, 19 Nov 2026
 11:44:08 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 20 Nov 2026 03:43:57 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z93rWEzqAQ_sWWVKbmQ5M3qjxX4o_qYzeX3xs+=2V8yA@mail.gmail.com>
X-Gm-Features: AclHuK83S9SvqTl7DWMa7lyKfrDc7jrgO_opWySalBDGVE3ZIlzAIZT17fPF3ZA
Message-ID: <CAGsJ_4z93rWEzqAQ_sWWVKbmQ5M3qjxX4o_qYzeX3xs+=2V8yA@mail.gmail.com>
Subject: Re: [PATCH v5 02/17] mm/memcontrol: allow update of LRU statistic
 without holding LRU lock
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
> To enable moving file pages in folio_mark_accessed directly and lazily
> for MGLRU, allow updating the LRU statistic atomically without holding a
> lock. It may cause temporary counter underflow, which should be fine as
> the counter is eventually consistent and only serves as an estimate.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/mm_inline.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
