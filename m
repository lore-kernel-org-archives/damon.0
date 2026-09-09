Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B236195A
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935593; cv=none; b=FcpN2ABGGcmz576qAH7X3Jd44y69KkCTL5AXdhUCZD9zCSNuMP9blVEgmAnJcRMtLinpaiinFcJ8q7Vwba/8iqn0H1vw47BNFu7xjVgi5hg0RLghfCnHdIvSus+ZvzNE65tfiNZb+3Lzq4RYoNxpgV1ZbMLB+C11y1lV22D1CBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935593; c=relaxed/simple;
	bh=F/b7L2zys2YOZrgc+NSdUCwGaax+6iYxNZdBBSZmM28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEQKNSm4Ew4ShgFNJVdRsH5o2zQxPl/yZXkJo1pd/1PsqM39IPsszt4ajjgzNF/hNh0KfTkeBWcbcQZw2HEYBCz/UdKDjXZLH4NFDjQn16CbJAZX28POQkcfsBi+BlVhBFU00AvZYJnvhMrx9/mrQT76Q0//jK8Gxcvg5QyEw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os5xTcM9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os5xTcM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A48B1F00A3A;
	Wed,  9 Sep 2026 06:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935591;
	bh=O3PDCjhFqqzdQFXDdXRXU7Iz+wO39R8npA16fWg7tm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Os5xTcM9c4TePg30N+HjVzl+ahBlye+5vfwEEQwJvG89oQL8zlBrK+SUJoF9YUliP
	 KViRJB3gpjrs/CKqPSn9wItEmth44BeGyu0BC5N7lxlTcBJNANdX02b2uCCMBgTVRi
	 My/qlR3rX5W3YxVz5SakILLXkG27MpqPIIW6YFcyKDz/5JU9apYTA2Eu8zI9HIg2D5
	 9CjF/LasxDhr9/+v1317VU8JEnmlMx3nnBqP5K1HAVIFIkQ9xEboME//L1PoNRrYe5
	 BbOviBHdmH8g96DkNVRgZBPqRU0XWwLcNmP6SngHm0PXAFUPvg9a5YgnAWPoRN/drb
	 gCRgAbsBnBxgQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y] mm/damon/core-kunit: check region count before testing in split_at()
Date: Tue,  8 Sep 2026 23:32:58 -0700
Message-ID: <20260909063259.79031-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909040249.243941F00A3D@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 09 Sep 2026 04:02:48 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The error-checking condition `!damon_nr_regions(t) != 2` is always true due to operator precedence, causing the test to unconditionally skip its core assertions.
> --
> 
> commit 6fefc501724f8572d4bbc1782d2ab55fa7568e21
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: check region count before testing in split_at()
> 
> This patch updates damon_test_split_at() to verify the region count was
> successfully changed before proceeding. This prevents invalid pointer
> dereferences if the split fails.
> 
> Link: https://lore.kernel.org/20260718001442.87129-3-sj@kernel.org
> Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> > index d8fef225930a5..1dd17d43a642c 100644
> > --- a/mm/damon/core-test.h
> > +++ b/mm/damon/core-test.h
> > @@ -162,6 +162,9 @@ static void damon_test_split_at(struct kunit *test)
> >  	}
> >  	damon_add_region(r, t);
> >  	damon_split_region_at(t, r, 25);
> > +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> > +	if (!damon_nr_regions(t) != 2)
> > +		goto out;
> 
> [Severity: Medium]
> Will this error-checking condition unintentionally skip the core assertions
> of the test?
> 
> Because of operator precedence, !damon_nr_regions(t) evaluates to either 0
> or 1. Neither 0 nor 1 equals 2, meaning the inequality (!= 2) is always true.
> 
> This seems to force the test to unconditionally take the goto out path, 
> bypassing the boundary validations it is designed to perform.

Nice finding, it was a typo.  I will fix.

> 
> >  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
> >  	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260909035813.162131-1-sj@kernel.org?part=1
> 


Thanks,
SJ
