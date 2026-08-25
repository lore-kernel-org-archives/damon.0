Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA948165B;
	Tue, 25 Aug 2026 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666111; cv=none; b=hoRzSSMwnqVtWoXFHfYVRBgP+f+hjI+H6DvBJuRR+Hdf+xqAvIkHGC+HZ4yrvjvuR3j9PsCrgTxMQKmDqL30pcf0ll/S/TEiJN3hfpUmm1SGhIPVWF93ugJ7P/cxaB9LVXA3WZwpJbcG3FQk/BGn6buepgSsOHmHBWuLE1LEsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666111; c=relaxed/simple;
	bh=t2IRTvTuple+OqZFxZWJoAiZJX65xumf4KJBFv72phQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQtMITj+ienzmBoU44tppYv/S9JsejEBOrZGq7d+6JC6sHfSTOyCei1fhLSRfHc3MurhxB94PqtFXhaTlbjbfpIqpxJ/mNd8fQHOKZBUjbgVLjglHYz8MKmwRm0v5RKFDkyHwo/ag1n8Dh3yv96Db2k2S6SvQvyYbEayX2UvENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM1HjBnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM1HjBnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DE61F00A3E;
	Tue, 25 Aug 2026 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787666110;
	bh=ohIDpKKSWuY/nOCEckXndoguryNSiTf+Hx10lCL4gv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OM1HjBnqp7yKkwww+cpXJ8aqdqp+eUcy4iK49H3GIU08V8TgUyd3oRxOpmO3O8oRC
	 6wjnYLsI9Bx6LVFZHPgKn0zz0G0GFG26iWp8pf7ILhz9XDFM0gr8OX2t1VQqAP9Mc0
	 YbavpHRreMLlvyYH8HU/R1uKDGbUh8C+cy4Alhbl6HIeVk+Tpolt59aOCJWQfQDuKO
	 HGB+hR0X1pCBR+fJpYGaKn8Ou/MCmw8biSTLsxawn/wBTQwFAlM1c0af4IxzPydOs4
	 yEK/dQGCVm8PJvMcbW2j3cugiY2bVZasgeei1bg3c3hJQd8aMj9+Bb9cJXWj3BZflD
	 XLvMfUvGBHefQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Tue, 25 Aug 2026 06:54:57 -0700
Message-ID: <20260825135458.64555-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260825124616.5129-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 20:46:16 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> DAMOS uses charge_target_from/charge_addr_from to remember how far a
> quota-limited walk has progressed.  The current implementation has two
> problems:
> 
> 1. Once set, the cursor unconditionally skips and resets at the last
>    region of the tracked target, so the last region can be skipped even
>    when it has not been processed.

I don't fully understand this.  Could you please clarify more?  Maybe adding a
realistic example scenario would be helpful.

> 
> 2. The cursor only advances when the quota becomes full.  Regions that
>    are filtered out do not move the cursor, and the scheme can remain
>    stuck on the same regions.

I don't fully understand this, either.  Could you pleae clarify more?

> 
> Fix this by treating the fields as a rotating walk cursor:
> 
> - Advance the cursor for every region walked while a quota is set,
>   regardless of whether the region is applied or filtered out.
> - Remove the unconditional last-region reset.
> - Skip regions before the cursor, and rotate to the next valid target
>   only after the current target has been fully walked.
> - Rename charge_{target,addr}_from to walk_{target,addr}_from and
>   damos_skip_charged_region() to damos_skip_walked_region().

Because I don't understand the problem, I can't understand benefit of this
change.  Again, more clarification would be helpful.

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
>  include/linux/damon.h |   6 +-
>  mm/damon/core.c       | 156 +++++++++++++++++++++++++++++-------------
>  2 files changed, 111 insertions(+), 51 deletions(-)

Quite amount of change.  I will review the code after the high level
understanding is done.


Thanks,
SJ

[...]
