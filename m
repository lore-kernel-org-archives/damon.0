Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709763EBF1A;
	Mon, 13 Jul 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952499; cv=none; b=XY2iRU06HuZjdD4NNHRsOe+hbStGLsD6i+gXPgmxId57M7gADOKEFJ3O70xeXiaX9kAVQ5xdX3K6bvesLSTqgMjGspz4n3c9lE4hQFw0M94EPFEYyiSEf89AVAf+kJhrK0ZQd6fFv4KxeCGOQZgcwvfywRsZ+4TSDIV/X+EIEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952499; c=relaxed/simple;
	bh=3xtgHzz+a53+/tvipqzssNO+pj5BJGn7LzhwmRL8luM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+UQzmZ9l3MZsQHb3eq0KOHknhqjJRjTJOoRHMg9VkX3ElSZZ2PiwAX6aFiKkZMYyeSc1B1S1IrTFj7meU1HqW4SGPk/ZWMLMu54DBi1u0ytu7TdTmfYq96bJWZwAfRpDJsO1Rg8Feqt2A+DF/bzKOhueqSzlNI+SioB3tjEbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+PA3qvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+PA3qvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD49C1F000E9;
	Mon, 13 Jul 2026 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783952498;
	bh=T13fF6DuKXjoRWGoSA1rsBfe5/M0+RntPAmfNLiYYjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+PA3qvNHakXfHOABuJr4wlRpP0q8Ad+tOu5kGf1se+V8EQdOP5DbAj9iqp/A4P7L
	 glX4aGZTfqC5fbuI4Vv68b7sEZU6iJvKc0GaL+SqJbyzttOab6sQaD/ueWsu0NxAjA
	 gZ+RT5CXpBCNSBDuXRIhgxnr1BNKpA6QtkAAeEF+9SjMCZIbNQOUbhLD8zTAfnraAI
	 rKQ/+y7xGXULbf7xm2asQpHLGl8KxQvziUUT16Ut2+V0NXqkEbtnWS5YB+FDJtG+DM
	 wP498bFgGxFoameYkK0Wb3tD/JycHD+VD9nyq8L57NUN4Oq6vpv6wiGtqr1dCeDBs5
	 BdDMk7LNBQa1A==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: test damon_nr_accesses_mvsum()
Date: Mon, 13 Jul 2026 07:21:30 -0700
Message-ID: <20260713142131.38616-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713094648.897239-1-husong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Jul 2026 17:46:48 +0800 Song Hu <husong@kylinos.cn> wrote:

> damon_nr_accesses_mvsum() wraps damon_mvsum() with the monitoring
> intervals of the context to compute the pseudo moving sum of a region's
> access frequency, with a special case for when the whole aggregation
> window remains. damon_mvsum() itself is already covered by
> damon_test_mvsum(), but the wrapper is not.
> 
> Add a table-driven KUnit test that exercises the full-window-remaining
> boundary (with both reset and not-yet-reset nr_accesses), partially
> elapsed windows, and the no-window-remaining case.

Thank you for this patch!

> 
> Signed-off-by: Song Hu <husong@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

> ---
> Changes in v2:
> - Drop the confusing 'bp=...:' annotation from each test-case comment.
> - Wrap the function documentation comment to the 80-column limit.

And the v1 is available [1] at mailing list.

Thank you for adding this changelog.  Please add links [2] to the previous
revisions too, from next time.  For other readers, v1 

This patch is applied to damon/next [3] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://lore.kernel.org/20260710041530.557455-1-husong@kylinos.cn
[2] https://docs.kernel.org/process/submitting-patches.html#commentary
[3] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
