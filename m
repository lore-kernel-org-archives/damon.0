Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376962D063E;
	Sat, 31 Jan 2026 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889259; cv=none; b=f95hX2xnxe677cqNjfvG5BL7P1BlmJgMhpA5zn5X0pNh7rBKPIFQ/V/lt2U6JTltkohR03NO478YuciiSu5i08Rgp7IodppO4OEAvqlh3fawDO14X8SMGHJ8fE0TT/tGtys8MyFvdd7Dccmh0CIgOpm+SbLRFhe7a3NVtt+4wIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889259; c=relaxed/simple;
	bh=N8vKGMyccUxrYrqp4qY0jWMxA5NCQ/73rs9xDcCS5Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mA/hULdMYD7gjHs2TaxInNlkp2snC7M86O5D9Vx4HPwbgb+bn685SzTqAGs/Ho95+Dh0BKYgyNGzEbbElURY89utKTribttm7kKn7TaTZ/l1mC7Z3n0qiSNJmXc1gaf4sdlj1yrQ7ReXm/oM8gNmsTT+U+rpJ6hi+5wpri4rvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmUnRFIC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmUnRFIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E10C4CEF1;
	Sat, 31 Jan 2026 19:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769889258;
	bh=N8vKGMyccUxrYrqp4qY0jWMxA5NCQ/73rs9xDcCS5Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmUnRFIChWDWwhJxLVO7VzYaEr21cBFNt5vFZXdhn4hObmhuEZeGNgIE2xBQtHO7Y
	 d5ZZJ7TXwa7VPq234F5zPHdhKgUlTj0F+0IB6tVM5myIW687yeM9UYiF/m32ANpAEP
	 i+RYt6T6RcWdWDvIexlbj83YEY+wcLLYzL3yzOtv+U3B0xbla+LlXYGAaZmdpplDyS
	 z3qmrmg1fjO0e5X3z3s4NyZEP6dff+b6jLa6wJBKD1rm5QpzIqap+czcoXm6ESQXFa
	 k1SFj6BWJjtYmzDUEuDMdL2RlDRBGJxjVAB8h1wYuR/HiksHxVR0twjwIrzLcIrIcj
	 L2J4bDpA4UaYw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v2 0/3] mm/damon: Introduce node_target_mem_bp Quota Goal Metric
Date: Sat, 31 Jan 2026 11:54:07 -0800
Message-ID: <20260131195408.66514-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130014807.51302-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Jan 2026 17:48:06 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 29 Jan 2026 13:58:11 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> 
> > This series introduces a new DAMON quota goal metric, `node_target_mem_bp`,
> > designed for controlling memory migration in heterogeneous memory systems
> > (e.g., DRAM and CXL memory tiering).
> > 
> > v1: https://lore.kernel.org/linux-mm/20260123045733.6954-1-ravis.opensrc@gmail.com/T/#u
[...]
>     Context 0: monitors node 0, migrate_hot -> node 1
>       goal: node_ineligible_mem_bp, nid=0, target=4000
> 
>     Context 1: monitors node 1, migrate_hot -> node 0
>       goal: node_target_mem_bp, nid=0, target=6000

In offline, Ravi enlightened me that using a single context with two schemes
instead of the above two contexts setup can be more efficienct and useful.  I
agree that.  It will be able to only single kdamond, and there could be more
flexible use cases that can use the whole-memory access pattern.

That is, we can use single context with the two schemes, but adding a core
layer DAMOS filters for applying the schemes to only memory of node 0 and node
1, respectively.  Similar for memory tiering use cases.

But I was recommending the multi contexts approach to people because the
current implementation of DAMOS is not efficient when both quota and core layer
filters are used.  I was actually working on making it improved, and just
posted an RFC patch series [1].  After the patches are merged, hopefully the
single context approach will be useful and effcient enough for varying use
cases including the memory tiering.

[1] https://lore.kernel.org/20260131194145.66286-1-sj@kernel.org


Thanks,
SJ

[...]
