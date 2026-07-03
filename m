Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666328505E;
	Fri,  3 Jul 2026 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783109176; cv=none; b=NZWjR+fa8yjvdJweHQjppIZiJuoVz+3JzB40Yw3m6y9QNEXNOqmhG9qa1HIUml2c4DIKTGt59sOjYLuIlI6nB9lwlFaEXsThcrpI3zJ4yuMq5hHqZ2EYnv/iQxnpW4bWXu0R32jBQ1VfFigJ4IwuUvdjuvk6mZYcBEVMlWtvbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783109176; c=relaxed/simple;
	bh=2tSdN7Xec9YwW/M/VNRZbrOkU8fnl6XzXsMlJpm9S4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFb5HldVQzspXNbep+Hs76KkCxO5eRm82kCD9Hcm7KuX03dD6kjtiCf6ouo+j1arPxqBTl6CTYlufImBts3AXlJQWg5aI2VWpUo1ERn5onDOdFAzfZs7PWb84Ik4Qqgvo5/T6Bifs2TPcvYhF9xBqi4a+To0wTq/bpPQ8ZZHOe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1bchi5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1bchi5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018071F000E9;
	Fri,  3 Jul 2026 20:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783109175;
	bh=C8zf2oenIzK/5sv6TzeAsiMNLr4snDxOKcCQpjzACiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C1bchi5AKR8Omb4EfoMSbv/1fj1Z+Oq8IzB1W6NVyGeehPhOvUPd/fhXjiC9u9FpF
	 cuy0JSYbuvt2qYlHR5iG09086X2oUJ/jMr7fEXACQ1e/MIBPpXDvNTFITTohK/lKrH
	 IsH6EcGeFPiEcxV8MFUF6ikINsDzt9sQhbuOxjJVjSmnZa6cQfcXtUbulKxYhPTPvf
	 NTJWVQSuuVrUY4sa72suD1cA05Svu13wrDCVaxjnlFPKP9H2BlBq6uwtBneEVVKatN
	 3VLhZcnaHBC4oewLz+CEG5mMB22tGVPCn/A+bEwGjKi5JP+XshqxDPytWPJF5XkQ06
	 GYqzFrWbbVwWg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Release Newsletter for v7.2-rc1
Date: Fri,  3 Jul 2026 13:06:11 -0700
Message-ID: <20260703200612.102544-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628211904.94361-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 14:19:03 -0700 SJ Park <sj@kernel.org> wrote:

> Hello community,
> 
> 
> This newsletter covers DAMON features that landed on the mainline, queued for
> the mainline, development statistics and misc events that were interesting to
> me that happened in v7.1-rc1..v7.2-rc1 time period (2026-04-26..2026-06-28).
> 
> The newsletter covering the previous release cycle (v7.0-rc1..v7.1-rc1) is
> also available [1].
[...]
> Chanegs Landed for 7.2
> ======================
> 
> During the 7.2-rc1 merge window, 95 DAMON patches have landed via the MM pull
> requests [2,3].  Introducing a few of changes that could introduce non-trivial
> user impacts.
> 
> New Features
> ------------
> 
> In the merge window, below user-visible new features are added.
> 
> 1. Commit 9138e27a3bc38: "mm/damon: add node_eligible_mem_bp goal metric"
> 2. Commit c7ec7d5f6b3d1 "mm/damon: introduce DAMOS failed region quota charge
>    ratio"
> 3. Commit 3b9e3cc0405b4 "mm/damon: let DAMON be paused and resumed"
> 4. Commit 70d8797c15d64 "mm/damon/reclaim,lru_sort: monitor all system rams by
>    default"
> 5. Commit 0453f857eb32c "mm/damon/reclaim: support monitoring intervals
>    auto-tuning"
> 6. Commit 3a0bc9568c354 "mm/damon/stat: add kdamond_pid parameter".
> 7. Commit 45c49d9fd6089 "mm/damon: introduce data attributes monitoring".
> 
> Feature 1 is developed by Ravi at Micron, for their auto-tuned dynamic
> DRAM/CXL memory interleaving for memory bandwidth optimization.
> 
> Features 2 and 3 make DAMOS be more deterministically controllable.
> 
> Features 4-6 improves DAMON modules for easier control and more reliable
> operations.
> 
> Feature 7 introduces the data attributes monitoring, which enables light-weight
> page level (e.g., cgroup-aware) access monitoring.  It will also be the
> foundation of the ongoing collaboration project.

Sorry, I forgot mentioning one more important new feature.

Commit 58996503b631 ("mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme
action") is also merged into 7.2-rc1.  It is developed by Asier from Huawei,
for DAMON-based THP collapsing.


Thanks,
SJ

[...]
