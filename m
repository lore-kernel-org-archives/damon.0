Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F0381C4;
	Thu, 14 May 2026 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736566; cv=none; b=NOFHW/xKLMzWdSZuV56Uu5FxQyI7tplxk7tVkLUunbBVgNOBF4gMYdJ+cT4eQnfSme77atrs3kKV5NAqANqtFgGZDJpoZHcgppW24L2ewuC1o6YT+AMdaMfuZv2/C36UPpwfJNSRi8N7IgGFHIXDOadNuqOndHnEGCWrI9Srv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736566; c=relaxed/simple;
	bh=GT3wQv+ArVJ90RYv0e6zEMOwJzZ4kWkjST7lIq8uNyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9MGyBb2C2MI20SOUmQp83UgyEVl4mnTsW+nHYyNgwLfD4O0sdit02Tsuxllwny/6LX8X8Ne3bqsNHsn94UeJailNhVlayWo/zOMH7SfhhqmEd4xfPEHfrw9PwloaI2prGExkRWaS24L1iXWR7XFJYGk3i+aOLUR2Wr2uucs5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoSnhBqa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoSnhBqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00787C2BCB7;
	Thu, 14 May 2026 05:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778736566;
	bh=GT3wQv+ArVJ90RYv0e6zEMOwJzZ4kWkjST7lIq8uNyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoSnhBqa2ezBsWzSpsBhwhrI54zdTpKPo7YS15cjO79VC73NbmCidF+DCsfPZefit
	 FYXodApUm4nmaUCZ0wX5C8S8tN1i8WZNZkAWrTLTqargwTU6xRVhsFSD6q/lX8ELfw
	 1k5pZ6k55mPXT/6vrx2XWhubkXVg0KL7qR1vzqp28vcW9V09Qu2IHvpPXcyPQyUm+4
	 ZnfuUG/Q57/AIJxjfq4GNMzirjZ6xKdF5xqGynVNgO160oWRMQPNB2eFGIqr8ciTuy
	 Gd4sZH4m0GWM7Ea3RAvkhiWLjhv1AJODJzz1TCHDNL2TUPDgFtx0XeuSxEFRiwwcjP
	 d0rZYMxpXL+ZQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y 2/2] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 22:29:16 -0700
Message-ID: <20260514052917.111980-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513043039.173237-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 May 2026 21:30:36 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> Link: https://lore.kernel.org/20260419161003.79176-3-sj@kernel.org
> Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
> Co-developed-by: Liew Rui Yan <aethernet65535@gmail.com>
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.0.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit b98b7ff6025ae82570d4915e083f0cbd8d48b3cf)
> Signed-off-by: SeongJae Park <sj@kernel.org>
> (port parts of 42b7491af14c ("mm/damon/core: introduce damon_call()")
> and d2b5be741a50 ("mm/damon/sysfs: use DAMON core API
> damon_is_running()") for damon_is_running() dependency)

Sashiko found this backport is incomplete.  Please read my reply [1] for
details.  I will send a complete version as a reply to this mail.

[1] https://lore.kernel.org/20260514052626.111769-1-sj@kernel.org


Thanks,
SJ

[...]
