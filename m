Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93843DA59;
	Fri, 25 Sep 2026 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362923; cv=none; b=Kyo5iRcEP8ffHPJ64TVbcgHfu3IuXQfA2G84bpve7EOYUdtsWzYuPshQOGh6CqR2jD0pamjlxPCXYllyz3MUTgTQCIyRMG1mXWgahTOl4EFzMYzyxzPlzWJPtjllquRHKlEkexEVsT8ozxaSZOytPFGVihd0N24jWDknKU5Sz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362923; c=relaxed/simple;
	bh=4tNjcLqHt3BjmYU+UYqC8FZ4H1vg46q8puKb9caNdmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRJeusipsOXjWwM3DlMEaQPvOtApab3F54jzSRhKNNnKkFCIcT31Pd/aXl2+Zv+ZmGMqACJ+PQpgREN/X1iHDs+z+uAQA95FCgNyKhisOmD3Sch+/Ewy6lLbG9wSKBOI16jjO/g4AQ2R0/RhxVEmnUssPUE9/Z5nbiZUGrxAuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beJzbYhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beJzbYhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B411F000FF;
	Fri, 25 Sep 2026 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362911;
	bh=K+Ar61tv78gbaAB5x2pqKfWYRtZb9fTQQOWby/HKljI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=beJzbYhbsUaFJb+iBlNUq5lBMdl2PkZuSguZb8itkZ/vO+zcHB7u2Jg3vKgPyepG0
	 x0+NRQl6zljrn9j9YL4H6oMewiET+NhzPGYg2H9dYsBT0lQs5aAbD83LTVhOgFeHz3
	 U1lL/isFBX+L+wPGxhqX3NjLosS3mTD3+o+pR6L1FExVAi1oKQ+L09TP5DPsO/VJJR
	 qJEYbP26knXKRATUJfdKx2WeYnHOIVTeIJH47vpLRLjl0CSk1SYEuElBHic+2oJsYC
	 9uG0DcEXvmhgNNfsTOaeeYaM42VOe/xQwPKPxf9kMP5fdwzT5KoJiGA7BhmwKcevhm
	 ydrClkokl5rfQ==
From: SJ Park <sj@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] damon: reduce stack usage further
Date: Fri, 25 Sep 2026 12:01:43 -0700
Message-ID: <20260925190143.2553-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925130254.4022227-1-arnd@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 25 Sep 2026 15:02:46 +0200 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> In a previous patch, I had annotated kdamond_tune_intervals() as
> noinline_for_stack in order to not exceed the stack frame warning
> limit. Unfortunately, my current linux-next randconfig builds show
> a similar problem again with clang-21:
> 
> mm/damon/core.c:3953:12: error: stack frame size (1288) exceeds limit (1280) in 'kdamond_fn' [-Werror,-Wframe-larger-than]
>  3953 | static int kdamond_fn(void *data)
> 
> Do the same thing with kdamond_apply_schemes(), kdamond_merge_regions(),
> and kdamond_split_regions(), which also have individually large stacks.
> This should work to keep the deepest total stack depth down much more
> as well as avoid the warning.
> 
> I also tried to reduce the complexity of kdamond_fn() itself by splitting
> out the while() loop into a separate function. While this arguably led
> to slightly more readable code, it had no effect on the total stack
> usage and just made the new function the largest stack user and had
> a nonzero risk of me getting the conversion wrong.

Looks good to me.  Thank you Arnd!

> 
> Fixes: 5a00cae64de1 ("mm/damon/core: reduce kernel stack usage")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
ping me or Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
