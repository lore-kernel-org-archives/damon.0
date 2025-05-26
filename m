Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A22A1A4
	for <damon@lists.linux.dev>; Mon, 26 May 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748282127; cv=none; b=g9J1gxrlKmruFezR4YtDpYuDafwsUtU4Rvr4W7fxG/03Y5xA0NTZykVkaDazT35bxCpvWPgnpM6EnyHhhbTk160GjkVlNnbUnTRVHMDsEVNz76/3pg1n9wPcqsmJkK/2QPnrAiy1sit5qlgmxJnwUwHW2CjlijEj7we3Py7LDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748282127; c=relaxed/simple;
	bh=2wt63rinmphgpNqJNqbGfrk3Gql5+JvD9dkXi/gRCTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jg1qxhKEr6Z1Y4jzPuXI+MkPgOD6/1nyvl2r4YD+qxejoqejuZ6HrkktNdktqUPLkoRcttC2ZMS1LYzn/7y1RMRAjsj6B0HUUcOv9a5qrQBHY9yXWfGpYApWwiRLJJ6K0bjbb/TEvHYO9USSU1+iy0M7SabGVhLKxsvmWwWrNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9C5jJUR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9C5jJUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E25C4CEE7;
	Mon, 26 May 2025 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748282126;
	bh=2wt63rinmphgpNqJNqbGfrk3Gql5+JvD9dkXi/gRCTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9C5jJURpjf0oUMTyoXViwU1bnWKbU7Xyt+73axuv6OYVdL/cTsY9VPhU4y6UdbzJ
	 GoAKieOH2EaLwFtJnAxSv1BkPx1tAMHyk63nbWXBt/uNmgGuS2nOHglXhEPrtpyP4H
	 CDzwwXqkzw5IXWCQ8pUkIOO1MAGsfU7cPe1ViLhLT1t77Hq9zYQK4zJLBwMtOFuQCp
	 6v4j/bIPYLGF7MWb9cg9K01xHuWhn40hzI+Zq8iY1NfPs8lIwgV3EcVmYdjUrE4Q0Z
	 XNtpKAa9kpCLLykFUxSRrZLEl/4lX287Brv675uS1ioqsUeo3AXAiWTtK4QQE4L82o
	 8j423CQbFaznA==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Enze Li <lienze@kylinos.cn>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon: rename primitives to operations
Date: Mon, 26 May 2025 10:55:24 -0700
Message-Id: <20250526175524.2651-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <dc5391f3-6e0a-4e6a-b319-0c602af29202@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

On Mon, 26 May 2025 11:31:45 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 24.05.25 18:29, SeongJae Park wrote:
> > Hi Enze,
> > 
> > On Sat, 24 May 2025 20:55:36 +0800 Enze Li <lienze@kylinos.cn> wrote:
> > 
> >> The word 'primitive' is not explicit and has been deprecated in DAMON's
> >> context since commit f7d911c39cbb ("mm/damon: rename damon_primitives to
> >> damon_operations").  To make the code easier to be understand, this
> >> commit renames remaining 'primitives' to 'operations' in header comments
> >> of DAMON source files.
> > 
> > Thank you for this patch!  The description makes sense to me.
> > 
> > The title makes me bit confused, though.  By reading it, I was assuming this
> > patch is changing some code.  But this is changing only comments.  Could you
> > please make the title more clearly specify that?  E.g., "fix outdated comments
> > for monitoring primitives"?
> 
> Heh, but wouldn't we be calling this things "primitives" in the current 
> context?

Thanks for giving us this good point.  I was reading this as "fix outdated
comments for monitoring primitives (, which is a deprecated term)".  And I
agree this is not very clear.

> 
> "don't refer to common code as 'primitives'"

Nice suggestion.  But, this wouldn't explain the changes to {p,v}addr.c files,
since those are not for common code.

Maybe "mm/damon: s/primitives/code/ on comments" could also be a simple and not
that bad title?


Thanks,
SJ

> 
> -- 
> Cheers,
> 
> David / dhildenb
