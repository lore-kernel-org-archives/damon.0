Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB53B3885
	for <damon@lists.linux.dev>; Fri, 13 Mar 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413292; cv=none; b=N0AY57nx7yQLRt4i0j5US7SGLTd8AWaoh1C6KPXrmPNo56Vu3RQ+PADIaDjOzPCKayNuGwYGmgYJ275/me5Xr8l7+nd3aBE9xBJudEA1Uzp+UufAa2s1LKOYHLZZGFe1wAaRfVFIBLsUCVa6Z4elGTgi1hJMBUxxTgPccrH2H84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413292; c=relaxed/simple;
	bh=CUmFsU2G+NBF4oI24RS3s7BTKOpnDvSejeSWKgDW6y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfWkCXmI72WBKF9jfjfYPey28uo5a9RdZ9z9Cv6QrvkxvkKprc83vf76LkV3NHU8hdIbNOFrlTOw4YoTLqLtZ5Y31Z1HKSsNOHpwDCp3HaN+lcbgBoTzl7yz9xK1fxbEKvPdKuQ+bjfAnBJ3/9ZFLszOrkmwxnT2WmxOtX2Kh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcEG7Lcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcEG7Lcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3F6C19421;
	Fri, 13 Mar 2026 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773413292;
	bh=CUmFsU2G+NBF4oI24RS3s7BTKOpnDvSejeSWKgDW6y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcEG7Lcp5gbPg7QvViC5EM6NsfYIuaxOUVfI6Ps3cHxNmGUwjmVW0vmwXVrcxSX1c
	 k9eJFrOtZpnUwXvNEdk5OR3TcnuXF/XQRGhZsWpYFsF6dw6XSOgeYh6gGnPLsXuFbF
	 ldFhrgJeG7g3+0+ph4r5UH8uBIv1YqrhdRa8DSPtZwV6aUoIU5DHtv6wbty6etPhNJ
	 LdZ09iDzyZQPp5LldQUhcWrUvofNB8MygeeWEVq3LYI4K5wRZ9NRW0j59uD0Xid350
	 60dnn0ImFOKBVWBm28RoH8aHJhz/fove5WgZ/Cenm8NUeQAyYFRVVLSe+pDoGc4pEq
	 tKVIpb4ey6gAA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [Question] mm/damon: conflict between DAMON_STAT and DAMON_LRU_SORT?
Date: Fri, 13 Mar 2026 07:48:08 -0700
Message-ID: <20260313144809.46527-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313111702.38667-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 13 Mar 2026 19:17:02 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> TL;DR
> =====
> When CONFIG_DAMON_STAT_ENABLED_DEFAULT=y, enabling damon_lru_sort via sysfs
> "enabled" parameter returns -EBUSY. Is this expected behavior?

Yes, it is an expected behavior.  DAMON modules run in an exclusive manner like
this, to avoid interfering others' monitoring results.

I'm planning to make them be able to run together [1], but that's a future
work.  For now, this is the expected behavior.

> If yes, should
> this limitation be documented?

Good point!  Yes, it would be better to be documented.

> 
> Reproduction
> ============
> Environment:
> - Kernel: 7.0.0-rc3+ (x86_64)
> - VM: Virtme-ng (4G RAM, 2 CPUs)
> - Config: CONFIG_DAMON_STAT_ENABLED_DEFAULT=y, CONFIG_DAMON_LRU_SORT=y
> 
> Steps:
> 1. cd /sys/module/damon_lru_sort/parameters
> 2. (optional) tune parameters: hot_thres_access_freq, cold_min_age, etc.
> 3. echo Y > enabled
> 
> Result:
>   bash: echo: write error: Device or resource busy
> 
> Workaround:
>   Disable CONFIG_DAMON_STAT_ENABLED_DEFAULT, or disable damon_stat at runtime
>   before enabling damon_lru_sort.
> 
> Questions
> =========
> 1. Is this resource conflict between damon_stat and damon_lru_sort expected?

Yes, as I mentioned above.

> 2. If yes, should this limitation be documented in:
>    - Documentation/admin-guide/mm/damon/lru_sort.rst
>    - Documentation/admin-guide/mm/damon/stat.rst

Yes.  But, I think 'Special-Purpose Access-aware Kernel Modules' section of
Documentation/mm/damon/design.rst is a better place to document it.

Would you mind sending a patch for that?

> 
> Additional Context
> ==================
> - On major distros (Arch/Fedora), CONFIG_DAMON_STAT_ENABLED_DEFAULT is typically
>   unset (disabled), so this issue may not affect most users.
> - However, for kernel developers or custom builds enabling both modules, clearer
>   documentation or error handling would improve debuggability.

I agree.

[1] DAMON-X in https://lore.kernel.org/20260307210250.204245-1-sj@kernel.org


Thanks,
SJ

[...]
