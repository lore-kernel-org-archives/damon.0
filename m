Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E41632E7;
	Sat, 15 Aug 2026 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786754861; cv=none; b=AcULUi3aIpSeI07DwkcNdz+fTRQV1B2dRgV6quRXKxKCPcouQzLD0G81rjM5aOkUF87FQQi73hhbjc3RiI9LQKCSUcLtQWGu6SU3sunyXHl+/3slNKxzy8GnuDSniljjCFNSFvgAu8iQP7gI472Cx1wU+/r8ttzqht1PPZizU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786754861; c=relaxed/simple;
	bh=/HbWI4R69rzbaZ95FdbUeJtbE5yFJiR2I28JqwRnsHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjLkMTiH9iaQxxlL41NSAKg4aPn9h4wX4WdznGjFDgEG2lsjB1CgLGf8ek303i8P3ux/b7feQqU9Q78okp/bz9U0SD1wsKJZpN2Pw3mtd5VMYuzd6Dl58aAUnOPwHX8xJcBi88hOihbmkapAGd+LlbsfeGB8tBjDp+pR3ukltU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RouPeZYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RouPeZYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE1B1F000E9;
	Sat, 15 Aug 2026 00:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786754859;
	bh=EXjSPj2g8X11uO/ReLFrgauWbcYOxscwU3FcqHFGgS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RouPeZYPBKyWMOzE44JhhpIppAimjKV75i45nR0uE78muv32i3ucJxp6KhPuGoxZO
	 Bc7ldcOkpEGUjQ4/YJeYs+PxlFTUGQTNvcTvnrm0g91G7bWKdPGPBrek9DTP1T9FCU
	 L4iZOK+Qa0WdyFH6pXV7t9ZFEJJHqMcFhPVQRc4wW8V8UDDU0Bxax2W3VXGr469PPw
	 QLtZsCGLQ7m1rDkCl42sj5ch5mCbPERQqoy0hmBegk3lqIBYxEoyvJpx7RHHppAYd3
	 IeDeW+yQIrxKoxjN1ezeXHqT2ggr2UYwIw8YnlmYbZqBbQpfO3wl/beRaPTVvYoq53
	 RHErsXlZugmmA==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/stat: avoid iterating targets in damon_stat_sort_regions()
Date: Fri, 14 Aug 2026 17:47:26 -0700
Message-ID: <20260815004727.83755-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814145409.553724-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Aug 2026 22:54:09 +0800 Enze Li <lienze@kylinos.cn> wrote:

> damon/stat module creates only one target in damon_stat_build_ctx(), and
> the comment in damon_stat_sort_regions() already says so.  But the code
> still iterates adaptive_targets with damon_for_each_target(), which is
> needlessly verbose and adds an extra indentation level.
> 
> Just use list_first_entry() to grab the single target, with a
> list_empty() check to be safe.

damon_ctx->adaptive_targetes is a private field.  DAMON API callers should
access the field using only public API that exposed on damon.h.  Let's not do
this.

If the verboseness and the indentation are problems, let's split out the code
to a function.


Thanks,
SJ

[...]
