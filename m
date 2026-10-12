Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D637B41E;
	Mon, 12 Oct 2026 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833967; cv=none; b=aTlX1xYUrccxR13sAbcUoU4pDsmop/1oItvEHQPemNfLm0BfQhTv29lxEFgEa63RkNDOC9FsiIX1zQwZ8N7n6Hqr1ULloWCMisQwbW1pyjNJZt0g/fWHhx5+/GQXC4B7lHKPrySnyBkllKHsFT/M6+n8CMHpT5/VwryYWBmmGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833967; c=relaxed/simple;
	bh=xpX0MeKdzj6x2w8OpMnaRMLLE/8wUIXF+fqvVCl6AYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEHQZCczMSH4TObvZnhOZefDhsVU+PaU0fKpTVKalT2ZrQZtMDSPux22bpEJzW3OiU4f/ydpAuvZiFzS++fFreZH76u0kmwoHCBg4jjZunTcwCS4HnI5j7thtB9P8dWUQtYs+FJhS3TXdey1VJfKCaEc3Gnctyuy74s7JzW+jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo6667aW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo6667aW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB65B1F0089B;
	Mon, 12 Oct 2026 19:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791833965;
	bh=dmphcHtLoa5lN5HKZf3N/rNWg+UFc8RVpn9tVq5WvJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fo6667aWdwibX0X+nESPDpiEp8VM9vajSVdYVjODcvXynPJOd495Y8E7acv4Fh3AO
	 kBwB1PV/gkcS35mMdIi3lJgPK3EUS9pHWugLCbrlPj31p8OrSwdF9sVEq5DjtHB0wE
	 ElOow0LqSoID8aw3UG8jumaNQVSqplYoPKOj7hEwPhsbidU1FY0sHU6qpm3etSCyOj
	 utwPMgMBHQ4UzngvTJ5N+NwmZSxQYNAHY2+B+V3GEfEYXsY5jF2sBbGrH80o5MYkAQ
	 yW0VGOTjDCe00gX/WR9CXHJpW0OqdRDtwf6B505qVI3s67LNQOWKc6GLSQsZMXGI6/
	 188RxfXr1t06w==
From: SJ Park <sj@kernel.org>
To: Suhaas Joshi <suhaas@s-joshi.in>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/damon/core: Copy only installed probe in damon_split_region_at()
Date: Mon, 12 Oct 2026 12:39:18 -0700
Message-ID: <20261012193918.373055-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012150045.169377-2-suhaas@s-joshi.in>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 Oct 2026 20:30:40 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

> In damon_split_region_at(), we copy the entire probe_hits[] and
> last_probe_hits[] arrays of DAMON_MAX_PROBES size. However it is possible
> that the number of probes installed is less than DAMON_MAX_PROBES, in which
> case one or more iterations is/are redundant. To remedy this, iterate over
> only as many times as the number of installed probes. To do so, accept a
> struct damon_ctx pointer in damon_split_region_at(), and update all
> invocations of the function to pass the new argument.
> 
> Also update damon_test_split_at() and damos_test_filter_out() in
> core-kunit.h to supply a context to function paths that call
> damon_split_region_at().

Sashiko raises [1] a few questions, and those look valid to me.  Could you
please address those by replying to the mail [1]?

[1] https://lore.kernel.org/sashiko-outbox-168321@kernel.org


Thanks,
SJ

[...]
