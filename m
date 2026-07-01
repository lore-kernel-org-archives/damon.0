Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07420481FBC
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918428; cv=none; b=uFK1Ko614uWg2B9gNGPfTlYXD6+YEtKYPNO5xVs0EDUq64Tvsj0UStsdjpNB6Uo84T8yhqA/5Au4Yl/dH/q5Omw7YtyEsyKVnlj2UD0rIQleALXQ14cwNyyKZXiACCiPUnq2Xpqj9j4ESDI6Gj/YxblLaZHDC6cKhrAjVAxOBSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918428; c=relaxed/simple;
	bh=BCvh+K1Bje9VXesE1lC6L8M1Unh/LYBAPadBNCg/5a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9RaaNdeGgcnwZ5C0LxLhaNYHlhNg1X/sPzb/tLw9N8NnYNK9TdZQrpe/i+AwmzfaexHl72l7M95a4kgntJoG2bjQ3AROM2VnrvPnx4uYoaR+vPh94aRsgjOaOhcqDlJFjbcY4JGj041HePg7cC9EA+7Y3ec253bIb59z5aRedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck/O/Xpb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck/O/Xpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38C61F000E9;
	Wed,  1 Jul 2026 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782918421;
	bh=fjoGQmtET//KVYgawaM75QrRCmmA9h7I+ev8NSBns9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ck/O/Xpbd0uibgpwhxkpuR0k1v8GqZM5VDsBv7GwDiGMJJogYvgvq+wFaQhn+VP+8
	 x07v2G6apzh0g2XVAbIiGV7psGgvcHLutN7TJXyjONJXbKVCRymanOIcYVB4DdjfCn
	 XJmc42IlGqyKSqIAIIFJFq59ebHsIGRBozxLiJwlPESNjxdZikBPYSBqwqWyK/LUpM
	 ZK2EJ0x+Qvqf2+2xNbnzuatAMdV/7TiSFPHrpWxmytiUSrrNor4J2iAnELVOGx2wh9
	 8lyU8aolHVlgRPodPEytz+DOgWGGQedaQQFs8TQpSGipf5fpN2Tejzf/7wFxn1RUNE
	 XO4pTzlewxPZA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/8] mm/damon/core: safely validate src on damon_commit_ctx()
Date: Wed,  1 Jul 2026 08:06:53 -0700
Message-ID: <20260701150654.114297-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701150110.A4FB21F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 01 Jul 2026 15:01:10 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Validation step incorrectly tests the existing context (`dst`) instead of the new parameters (`src`), completely neutralizing the patch's safety guarantees.
> --
> 
> commit 4ac81fdba8a8c8576fad127fdd4347015f4dac51
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: safely validate src on damon_commit_ctx()
> 
> This commit updates damon_commit_ctx() to validate parameters safely by
> applying them to a test context before applying them to the running context.
> If the test context validation succeeds, the real update proceeds.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 5febe58a07028..5ca176eb27e1d 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1635,6 +1622,52 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> 
> [ ... ]
> 
> > +int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> > +{
> > +	struct damon_ctx *test_ctx;
> > +	int err;
> > +
> > +	test_ctx = damon_new_test_ctx(dst);
> > +	if (!test_ctx)
> > +		return -ENOMEM;
> > +	err = __damon_commit_ctx(test_ctx, dst);
> 
> [Severity: High]
> Does this code incorrectly validate the existing context instead of the new
> parameters?
> 
> test_ctx is initialized as a clone of dst via damon_new_test_ctx(dst). If
> __damon_commit_ctx() applies dst to test_ctx again, it avoids testing the
> new parameters in src entirely.
> 
> If src contains invalid parameters (like a non-power-of-two min_region_sz),
> it will bypass this check. When the unvalidated src is subsequently applied
> to the running context:
> 
>     err = __damon_commit_ctx(dst, src);
>     
> it can fail partway through. This leaves dst->maybe_corrupted = true and
> causes the running kdamond monitoring thread to terminate unexpectedly.
> 
> Should the validation step be checking src instead?
> 
>     err = __damon_commit_ctx(test_ctx, src);

Correct.  Maybe I made a copy-pasta.  I will fix this in the next revisssion.


Thanks,
SJ

[...]
