Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795045740;
	b=DTvRmBCphS6PKieKHdV57Fy0k8wN7x54+dN8xZUn6b+OLYnFOLOFRchgFXx7hBBZI4Jk
	 +kThll9kiETBOIrbSWUZhSVz6/0rPE/5/S/OjcR1hupnNmIKHWLKOR8NBwsEjob1ufntZ
	 Nrj9kKoaEOd0vw8RQK76FxUALBh6ijpS7JhiyfLTJ3kHkj4L0ifAMkwOjhcqHVKiFcwkt
	 R2RazJHQcKK/BnYR7YsKPh/t9bR8iXiiBBA33dK78zcKc/eSlJUbv4Y/mlpGMGcrub7bS
	 sfyiLMzptTPHlHwJLdg1ltVhOVnZqPEvlHlU9SEcrAslQUpaFErIBdyZ5e8smkT4imA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045740;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JokRczt5mVEgHxRUZJg6jCnvGvoAs9YtaIgcq2+6nkw=;
	b=YsTQePWDKh2vQQJ7C8qVfEd1teICVBT1KxLX8k3/Osj08jMVnXnPldRk+CDClxgV1IbD
	 jNAleAuQsM7yFUQX07wgE/JynqfbsvxbIkDE9ybEOn51DHnaXX7wGQvWW8WUqKhp+Ui3c
	 FwqgRa+ikt+yiS6hC6rJsc02809IS32yEAv6RtiU1L1zppEM89LeC+MiCfUqn1XkqDf8k
	 Neg+PSIchb2N4t3lGhP4kE44f1yVmSnDH3DKGYehEX/WPMFKUGNp0qIZa+zhvJ8bt0Nkn
	 QjtJYz9yZonr+r5ckEoes+qkefZh3YFInEOQOk/5bhbq8oujhhdmUcZjuVl2lZAyNDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOtIbFcu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92B606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOtIbFcu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B516B1F000C5
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 23:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795045739;
	bh=JokRczt5mVEgHxRUZJg6jCnvGvoAs9YtaIgcq2+6nkw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oOtIbFcuKGbYPJjGa5ZVRGgeaHzVpkuzTXPOHw3vnuvhUPE0HTqYt0h0Uu8QqgGoQ
	 lHisu5eSwPTqn+hazJGGckQw7QYoOw74bD+Q7J0bQa3ZjO33n1LrifNjwALxz0sKO/
	 ZiKWXd3uPAP25HAeA50GCqokAX30GY1Ls5njzH47WPY8ZOWYehCS967DqOuug9xhTk
	 4XB4RjRd3GNXjADRae5CqMbtxeWGpJQypzhX8TLu5u60aiH7mygtuVQ/ZTqR82/NJ8
	 wAWsKgPDoZC7QUVNCJni4vteyzyqcsmVvk1u0aMF6Z/iEaHvmy0u+5fIXLnaoPEx9G
	 4HZAtrraj0hcQ==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93a40a9a01aso49136685a.0
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 15:48:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFOB+JuH8ZiynSHVXnXvhSmSaBP7/cgkufkWkMbdkF2ewo82CA5F2mT0EvROTF6BLO8PfJ8IA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8RQoBb6LdcAJVcnGovrqnYWMud8aw8aVdRgGWfQRa/KQJwrZGb
	MgBn3B/RFs2YZ37u7iMz4bllT6X1/1mLYrOTvmGd3sjO29UkUyRdWc67dU1LarB9XWr2UulI55/
	X5wbnqT63BQjHk9pCdHuwGyoGxPTdrfM=
X-Received: by 2002:a05:620a:260a:b0:949:6b5e:33ee with SMTP id
 af79cd13be357-949ad938bc0mr22211185a.31.1795045738801; Wed, 18 Nov 2026
 15:48:58 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 19 Nov 2026 07:48:47 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yUH9EG=kPWkkp_jm2Fy7e1D20f+uod1_9fUypW1G5sgg@mail.gmail.com>
X-Gm-Features: AclHuK8u8pAmVqW9yFgv9yKvnlXrt2QgHUMeTnuokLmXwaR9lnc-LtRTxLtZGq8
Message-ID: <CAGsJ_4yUH9EG=kPWkkp_jm2Fy7e1D20f+uod1_9fUypW1G5sgg@mail.gmail.com>
Subject: Re: [PATCH v5 01/17] mm/mglru: rename the generation offset in lru_gen_folio_seq()
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
> From: Ridong Chen <chenridong@xiaomi.com>
>
> lru_gen_folio_seq() computes how many generations below max_seq a folio
> should be added to, but stores it in a variable named "gen". Elsewhere in
> MGLRU "gen" means an index into lrugen->folios[], i.e. seq % MAX_NR_GENS,
> so reusing the name for a relative offset is confusing.
>
> Rename it to "age", which matches what the value means: the newest
> generation is age 1, and a larger age is an older generation.
>
> No functional change.
>
> [kasong: dropped the comment table part, the series rewrites it]
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>
