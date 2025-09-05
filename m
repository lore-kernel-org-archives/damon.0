Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16D28488D;
	Fri,  5 Sep 2025 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103173; cv=none; b=LoqC4oqRccSY4hrwqBK//C5wZsuZieXRqwMTZ67uN4bl6JsVEXFcMTA2c92loj3IpskNT8SPgxV6xPBVkFrutoXX601UFHPUk9WuKSHLYhFKokhb2HVm+Ey0TS5g8gkl7wJB6FwP6tzQLE35h255Y9IjwFIyLk1lNruQIxbFHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103173; c=relaxed/simple;
	bh=NA50xwmQmHmnHyMRdpp2t+2pd4JaCvoJdVuE9gVOf8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPNyYrbcOQKzt3pYW5KI1eO0CN+b7nIsbQqIsFB5N1l2HQsKHce4jCMAGCOY14clJHNZwY2yuORMuSKT58yksZg0ugDNkSLBmruIonmA35SbVcI/VA7Swa8YV3MS/6gyOMIx+1YSBIeTET+Kz5oPa7oti5fB+loNrPjFCn74mwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz7cmopB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz7cmopB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816B1C4CEF7;
	Fri,  5 Sep 2025 20:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757103172;
	bh=NA50xwmQmHmnHyMRdpp2t+2pd4JaCvoJdVuE9gVOf8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dz7cmopBXbpWZFEY5lwdPnHhoDBxWatG6S77ihR9vfdasn+oWaloQ8R8lz3gxY6dT
	 +vthFNb1napSOAVqSuIxn3UbERXOCSzoM+dTow0p9FsDrVfmyK2ZAOysq1DvqrjTuO
	 a3RnFSddTRDoNXb87FctjFGMt+vp9N79ImfLBw+TPyagm1eTt01fJ/95GWGbGODkmP
	 lDGfD+3TY6IAX2dv8jnmmQZFrxVfZ0ChPR0+nkWLPosBSsk2/8u5Yb+j3YsP2AxEM4
	 vB0UUl6PXrh7qZRI9STSEd1It7kIqdW1Mjn1kH52b39balPfjAubcqi6O+ZCahGoF4
	 /acHfYNM/IzGg==
From: SeongJae Park <sj@kernel.org>
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/damon/sysfs: fix use-after-free in state_show()
Date: Fri,  5 Sep 2025 13:12:50 -0700
Message-Id: <20250905201250.36561-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905101046.2288-1-disclosure@aisle.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Fri,  5 Sep 2025 13:10:46 +0300 Stanislav Fort <stanislav.fort@aisle.com> wrote:

> state_show() reads kdamond->damon_ctx without holding damon_sysfs_lock.
> This allows a use-after-free race:
> 
> CPU 0                         CPU 1
> -----                         -----
> state_show()                  damon_sysfs_turn_damon_on()
> ctx = kdamond->damon_ctx;     mutex_lock(&damon_sysfs_lock);
>                               damon_destroy_ctx(kdamond->damon_ctx);
>                               kdamond->damon_ctx = NULL;
>                               mutex_unlock(&damon_sysfs_lock);
> damon_is_running(ctx);        /* ctx is freed */
> mutex_lock(&ctx->kdamond_lock); /* UAF */
> 
> (The race can also occur with damon_sysfs_kdamonds_rm_dirs() and
> damon_sysfs_kdamond_release(), which free or replace the context under
> damon_sysfs_lock.)
> 
> Fix by taking damon_sysfs_lock before dereferencing the context,
> mirroring the locking used in pid_show().
> 
> The bug has existed since state_show() first accessed kdamond->damon_ctx.
> 
> Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Closes: N/A # non-publicly reported
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
