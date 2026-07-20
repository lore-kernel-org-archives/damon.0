Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AF2E8B64
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540631; cv=none; b=pPutAMpVo7Ftkq8DydLceLmfhImVJ6XJ/x/smIBDsw/pWzWEz2qhp+PFPm2XiXpwiXNJ0oVeD1bR+jUplCR2gGAVz75a/U0WV3aZq/av0WaNl5l4nrC5YYIIJO/fdHTK1rnnmhM+qazOZzhjZpDSI5wd0DbuVVM75eLumNi/wXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540631; c=relaxed/simple;
	bh=j1ZETi3/x4sDxuf8Hs5LtAyEh/7dlbEqRaEfZJkmiaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sqm03kMyyNz1570/kW4wA7CWKxPaZJKQOBPXyR6qzX32nC4MhRge1A/R8CNxzwfvOh/ZnBmQLml8MDD3R9SeRw5XMRflgopOwmvUvVWyO124imsZWoJw7JTvqKFk2nOqSOg/xrJLP8Dp/TWYbXsqZXO6QEHxhunLjGozvnOVsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeA2sVJR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeA2sVJR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso8903365b3a.3
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784540630; x=1785145430; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAmuH3TrSH/JKaELSX3UxD4gJHLMVKkSvtSAo6OO6Tg=;
        b=jeA2sVJRmVbUUGlEJ0GIYZtaTkS6U6sucw21WlAaSxftbTS8fa2Yk51q3gail7x5yv
         R7492quriSK7C1+Nc4V6UcMzaN/Le0vRHS/sZS8iA8bAScqobTlSZSeQVM+DEphf2fPf
         WAdvGy93b2OBxzTFnI0eQ3FukmeKVw9JWsJwLHv5nIlVzE9oUK+0PcCfy8CxoOzV6zfq
         g+L10JtWNLG02YQQdey4OcYWa4aGZYsBOnGfrhh7PcG2QUKHOMpDnBWL+hrHbN9eyMGx
         0euslU0q7gMK5ZTsSmAvRyjJW6qjIgQ5CrN7bP+jxFqb030wOwmlV0LrCRAlMv1AGiOF
         Imiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784540630; x=1785145430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kAmuH3TrSH/JKaELSX3UxD4gJHLMVKkSvtSAo6OO6Tg=;
        b=DzinhopDjVqBSFzM8mla+Qf/KWlVldcjyIoX7P6L2bLrxAHOTgwzG4s1uUvOjNWdiz
         NuaUQ7bdCcKm+yNAKxEc7g+deLkIKOmFoPLu1fUJFE3LLVix1FwDSGNJ42B4yOSvPVat
         ISdzXV/LbI29xW6BR3r1l7Cmu9VnIWWbVaePnmH+zOC9sJA+EuoDKtjUWmBRhkEbNZ4E
         lqC9PBrlPKrWflNskwoAwdYMrC18mRTtJPPLGtT6kou4GcxwXt8z+LWKFxzC24zQhQLi
         rjFFoVT+zhM6SLVMbh1SKjSUn3CKgEDh8bs/k5rp+VWZKAaWFy8tATZa7RbAydQs9fml
         LIoA==
X-Gm-Message-State: AOJu0Yy399LIFLVmsAWX/otvG1Ch+WC2moRnEl1ksDGXgsd/QJYPwdxg
	lUqBWO0lKAsUVe4HFvpyXOWWVtYHT/h3nEB1J4YB7AWtJsckcSw14ly9
X-Gm-Gg: AfdE7cmWdFledQugJzxtUhyjMvpLKLes98+lJT3a4ya6MemwzCJF8bV3nhe68nppn9o
	OP1BvX5v0sK4xdnBaxUGC1f2EUppNtxgG56YTJDQFhOAsx1IsmI6DZ9IlYaExrnvLnq+1E7Gq3w
	S6UUTVmD3JofFbo+nGMVXB17nUXkhiPo0GRf9ZhqRsn/APMDGX5H7F5gZXlVtAD93KuHw0uDwjm
	cTqZLviSwHon5CafRYTcS4rWFKgqgpI4CSm0868oRdu2QGoHfa9/9J/dPVW6U5JehOt7VgLcNX/
	MdyGQRrep01auGpfp/sbwVbXH4f4FVfloSmwhfPS9KVs9SIohJRHqNfk66/RMQ4jqEjsMdCFatg
	zPEoy2ugI307D7ZyeDFqIiahjyUkmRaYOklApduAEOcDaO8bDk/TPXDXyT2E6PS+4rMB6a9Plo/
	tg9SQOjedWeBTbDzkQQyL9fcED0Lg=
X-Received: by 2002:a05:6a00:2ea4:b0:848:5010:ad39 with SMTP id d2e1a72fcca58-84c2948a214mr13304609b3a.46.1784540629544;
        Mon, 20 Jul 2026 02:43:49 -0700 (PDT)
Received: from localhost.localdomain ([112.65.87.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad89d0csm5369285b3a.6.2026.07.20.02.43.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 02:43:49 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.mm@gmail.com,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: Re: [RFC PATCH v3 0/3] mm/damon: introduce DAMOS_SPLIT action
Date: Mon, 20 Jul 2026 17:43:40 +0800
Message-ID: <20260720094340.31733-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a168a9f2-953b-4ecb-98ee-ec6b27f4d963@huawei-partners.com>
References: <a168a9f2-953b-4ecb-98ee-ec6b27f4d963@huawei-partners.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Asier,

Thanks for the quick feedback.

On 7/20/2026 12:28 PM, Gutierrez Asier wrote:
> You should mention why page split is be needed. The fact that page
> collapsing exist doesn't necessarily mean that split should exist.

Fair point.  The underlying problem I'm trying to address is that
DAMON's vaddr monitoring loses accuracy under PMD-mapped THP:
multiple sampled addresses share a single Accessed bit, so the
observed hot set is coarser than the true working set.  Split is one
way to restore fine-grain monitoring -- by dismantling the PMD
mapping, each base page gets its own PTE Accessed bit and DAMON can
see the real access distribution again.

Split is not the only possible approach, and it is certainly not
intended to be "the opposite of collapse".  It is just one concrete
proposal to start the discussion.  What I really care about is
whether the community agrees that this monitoring granularity problem
is worth solving.  If there are better ways to address it, I'm very
open to that direction.

The RFC is as much about the problem as it is about the mechanism.
Feedback on real workloads that suffer from this coarsening, and on
alternative approaches, is exactly what I'm hoping for.

> Could you add v1 as well?

Good catch, will add in the next revision.

[1] https://lore.kernel.org/20260620203915.82947-1-sj@kernel.org/

Thanks,
Lian Wang
