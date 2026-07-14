Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB75358367
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008491; cv=none; b=AMdTrYO2HPESd8zYmEwyRt2hX6uhBAMBcRbqRqXQwT70WzM9LP2a8YoCmr+xEe95MHYxXG87hfYCZgzlOWMe3qHNlDVk4jwjF1mjvzz2TVMikLgiR+QfCkMfjQNRVMaO9M30/qlDqqK/25hcR85yY1g2n2tjiZmzBxqWQEBECSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008491; c=relaxed/simple;
	bh=CcYYwenrym3dKPKf9bpZnyHdBJvk7ymBp8bsLUgQEJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrbdYm55NTFugJ4WOwHd9Dw1AaQMF9eS7NPHDZr1UZ8BDyFRLl/QbHrG+hE/XNYBNAzyg/p7s76DxS+VYwQfC/OF8E65ZOpHntrQbjFotzyZwJkeZWgm5he8JPS/xcuRkRU7NVYiq4TgfwAe8p8VROdZ+nb1Zm+es+tBYTHG6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR6GkGnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR6GkGnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82E91F000E9;
	Tue, 14 Jul 2026 05:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784008490;
	bh=Vv06u4573FAqTSMfnf0IJglS0CxUcsU8ZydTwmKNkds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UR6GkGnI830AZiImuQxAkcaqAsysv6ehp6VtrHRXK586OID/DxJbuxVam1hN6CXPc
	 gQ3hb9MbvTI7f7ZyKXY+rBliUcTA/QY3OMiB0BngiyB9m8ZeUJbAJVBnYpyoU3n5C0
	 CWpGlz7v3RuooLvdWpTL1qJdyMMrooZ4uoCJVj4ECQTYhJ1pmaziVYM4N+kpbUEK98
	 jdaVWNZXaCSbJ5ugbPpyIdS8owiYp2gLHjQ6Yz+MIKiQF1josUfyFE+7AzU4KgMYk3
	 Zpicv9EyNqzmaRA5R0czw4KD4lHcKhrOPyOwcW1GNlLCVp9XXXAzgqw5azyis1E6De
	 nXLIJ0c3sjJxw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 06/10] mm/damon/core: hide private damos fields
Date: Mon, 13 Jul 2026 22:54:35 -0700
Message-ID: <20260714055436.120034-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714045241.08E611F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 04:52:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] `struct damos->last_applied` is left uninitialized upon allocation in `damon_new_scheme()`, leading to a potential read of uninitialized memory during the first scheme application.
> --
> 
> --- Patch [6]: [RFC PATCH 06/10] mm/damon/core: hide private damos fields ---
> Note: The format of this report has been altered to provide a free-form
> summary instead of quoting the original patch code directly, due to system
> recitation restrictions.
> 
> commit 74f6565901cd9e992427e68af079cc1885de502e
> Author: SJ Park <sj@kernel.org>
> mm/damon/core: hide private damos fields
> 
> This commit updates struct damos to hide several fields intended only for
> the DAMON core layer by moving them under a private comment block.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the changes
> to the last_applied field, I noticed a potential uninitialized memory read.
> 
> In mm/damon/core.c:damon_new_scheme(), a new struct damos is allocated
> using a non-zeroing kmalloc variant. While several fields are explicitly
> initialized in this function, the last_applied pointer is skipped and
> left uninitialized.
> 
> When kdamond_apply_schemes() performs the very first region walk, it calls
> into operations layers like mm/damon/paddr.c:damon_pa_invalid_damos_folio()
> before last_applied is ever cleared to NULL.
> 
> This causes damon_pa_invalid_damos_folio() to read the uninitialized heap
> value and compare it against the valid folio pointer currently being
> walked.
> 
> If a local user configures DAMON and the uninitialized heap memory happens
> to match a valid folio pointer being walked, could this result in an
> erroneous folio_put() being executed prematurely? Does this open up an
> exploitable use-after-free vulnerability during the initial scheme
> application?

Good finding.  I will separately work on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714043437.95811-1-sj@kernel.org?part=6


Thanks,
SJ
