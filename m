Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D73AAF68;
	Tue, 18 Aug 2026 04:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029130; cv=none; b=F6fzTERZIRFS7fN/gmrMalRJLBRL8WkU7Qc5lUwlJ0jnzmWqd1qYobqEwyHzj0bZJUNFtcxVoJQUSdieJvv8k+jTimva4Eg07cooGZsjdvU2UGG3arLLWlOo0lp+7iO008Kq6oYS4KSUYr78lEkY7CGHeIDIp/8ayG9uzh7dwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029130; c=relaxed/simple;
	bh=cwu3LMffIssKaNJqZeaV4KPQaCHypFgLfmvXgCCum7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIE6aSey1Z7WnvD9Gzv2xo82dt/Ou2RbllNOpbhfib+L4hleI7tSa3jGVz3tnDR8WPX6rBKHWna+BX52nxbHrLhkg/4QBNMA1582tSI23V9rnz9nn2ybg12QXrrcrH1PgwqZROLqrvDV9RfKGJ+NBIfcKOQfMnLCi7QBHlXN/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2t/Hnh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2t/Hnh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1AB1F000E9;
	Tue, 18 Aug 2026 04:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787029129;
	bh=lbvX5zjejzGb7rwtYKC1a37V4CKC0PUwDuNPU4yumtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U2t/Hnh2GaeTyUJJ8gd7aeudsvOMoTXLBHrHYqhwq9YSyFud/Jig7BLlZuKFZqb4v
	 +B5HJt21edC6UdfnnqVSzYjVmMKCDxd8yjaK4f4Ws4xb46uRdKdhchZkgz3GCkoH6V
	 4WGoxmeGZN/Nwz31ef6M5ZK5ywYv1IL6XrZ9g6yC3bWs34Ab/3GR+YWVdxRd0uKnlQ
	 uhrLD0iw6k/aRHoMbrZx6FreD/2T69vjFeOTjEp0L30VQuIUK4K/u7VGJbDlzbu18q
	 eiMhSqm8vKjtCVSlEbexlRsIgBtQbBXeBYyQ5zeLmdfoF3YlNe+AfHhRUBeTEAohlo
	 AWztxocTqQblw==
From: SJ Park <sj@kernel.org>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/damon: add kunit tests for probe_hits handling and probe params validation
Date: Mon, 17 Aug 2026 21:58:38 -0700
Message-ID: <20260818045839.97408-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818034552.11975-1-jasonangelov@ucla.edu>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 18 Aug 2026 03:45:50 +0000 Jason Angelov <jasonangelov@ucla.edu> wrote:

> DAMON recently introduced probes and probe weights. Add kunit tests
> for the propagation of probe_hits at region split and merge, and the
> rejection of invalid probe parameters by damon_valid_probe_params().

Thank you for this patch, Jason.  All patches look good to me.

I applied this series to damon/next [1] tree.  If this patch is not added to
mm.git in short term (a few weeks), I will ask mm.git maintainer (Andrew
Morton) to pick this.  So, no action from your side is needed for now.

Note that we are in the middle of the merge window for 7.3-rc1.  Andrew may be
too busy to pick this until the end of the merge window.  I will make the
action only after the end of the merge window.

If it seems I also forgot doing that or you cannot wait for my action, please
feel free to directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
