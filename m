Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F883537C8;
	Thu, 11 Jun 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186178; cv=none; b=IGXhysejWZlsBiFPDqf/gdfTt6q1lZI3z2yMim9iNqpwbN1IirKswDHZ38RgdDwux871GJTWx+GlSvdIa3i94M76vVb9QCm1b8RgsngpRYvnjV7u4zlgLv16Ked8+ksE0qaDWAXJhlbF0wPgWvCruEU1VBzLVDYfeuG2A0F1vIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186178; c=relaxed/simple;
	bh=paRr4T6LKRY0fnIRe3DjenQLnPM7mOqcQW2rVnXTq2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHSSlUGpAF8U3VtQsUxaXKM0Pu2ZZlgAY0zEHgkuz7iOwroFPbrZQk161+yDao74sR2YPDa21IJglxOOGR9/eDFwc9pAveWKCvdgqa8os1J5/8vmrPaIs3XedLDd/jXrCN6GjOP+cCaVnjedSkYapn24dWZI3ZNrrszOH8WSf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmGsUd95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmGsUd95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956071F00893;
	Thu, 11 Jun 2026 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781186177;
	bh=SUOuPf9VgztfwpD31VQB2QF3LLKSgcQvoPRCqkRWmAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hmGsUd958piwIRs1z4CkCvr45U9dM9GKsRx053NCzGhO87m2uum70Tmti9TDd2C/u
	 UWU5s6LmQDCq5SW9RA3KwSgGilAcFn79urvlf9Qj1qH2HvmB8KP5/3Iswa0HC6/J0Q
	 Ymk/VYZeknMXO58bZER6SO03OxTvegn56iBnBtjxb0+3X2L6ngmV3xzAkjjt3eK7or
	 xn9QPsEaGnkqx10xvocBuGsFz3tVtEDohDu9Ap1GTQGDyUBHCj2dtpygmuyNqf3+/T
	 9GepEGD0Ra0mbtkAne1Otn8CslsfgypJrmFP2eci7hyNiw8Hfv+hHdHIjxlMKqoLQ6
	 gnG46iMDsp5Rw==
From: SeongJae Park <sj@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: reduce kernel stack usage
Date: Thu, 11 Jun 2026 06:56:07 -0700
Message-ID: <20260611135608.66888-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611125704.3386176-1-arnd@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Jun 2026 14:56:57 +0200 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The main thread function has recently grown to the point of
> exceeding stack frame size warning limits in some configurations.
> This is what I hit on s390 with clang and CONFIG_KASAN:
> 
> mm/damon/core.c:3440:31: error: stack frame size (1352) exceeds limit (1280) in 'kdamond_fn' [-Werror,-Wframe-larger-than]
>  3440 | static int kdamond_fn(struct damon_ctx *ctx)
> 
> The largest stack usage here is inside of the kdamond_tune_intervals(),
> so by marking that one as noinline_for_stack, the functions individually
> stay below the warning limit, though kdamond_fn() itself still uses
> hundreds of kilobytes for some reason.

Thank you for this fix, Arnd!  I will also take a look in kdamond_fn() to see
if there are more things to reduce.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: SeongJae Park <sj@kernel.org>

Should we add Fixes: and Cc: stable@ too?  This function was introduced by
commit f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning") which
was merged into 6.15.


Thanks,
SJ

[...]
