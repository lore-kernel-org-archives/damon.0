Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469933E2AD1;
	Thu, 24 Sep 2026 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239292; cv=none; b=QuEBiNOj7NJCxKP+lvTJG4+1d2aBJDCIeOPDOgaKtcir/U82J3xwlFMZJ95XOHxoLp7BFRn3S7BEOyC1ayeHM2Dtkcg9lrZ5BBd7rz3EleEAQ5sCBAfuealWpI0nSUfIbG7uD14v3DqYihOkKQkKSR46ZRuohCvQ9kIRe6IenrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239292; c=relaxed/simple;
	bh=dxqw9mESNmJWrYrQibOqj4vtLRx72Buf2NA3HmBfAm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvgaWIQTdfQAggIhtXJSiY0iB0CvWFsEDwHXi379FHGgK1iB5UJjFJ78U+p282aC/AY5+rthU4o1ULe9AC714A5PbAmc1IvDD6RN0//wtRY57JL0KdEGryYHOR13wUPypATL3YRudH36DPzClgNKfkPZOM8mLPMX8IwD3Cxzj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/F/1Ar6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/F/1Ar6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E1C1F00893;
	Thu, 24 Sep 2026 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790239290;
	bh=pUnkSJWOm05fY56ErOz1EyuSwZYkIRaW/IFmvgi8dOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/F/1Ar6Ux8m52QixNR2WaT2CtMJqTUPv68Z/Zsi9/Y6reLgNdovGv9C35T8QC0H0
	 Ic0BDWK+weOwytEjz3h/v1Pif3OApXnhTnrBVxtRZ//gQ2LditMqmQ0FNogfH4U9e8
	 nCZnNzuXvxS3pAcVTwaoiD9uWszO8IIv4D+APB6FIwhJaVPdU7C6DC3qzpGuaYkQvY
	 eNGcoyUeKzDB6htfx8j68SLNTe0dCClRFGhrlzDDf6jH4K33R/mY71LDvjus+2idPd
	 DvjLQ78N31oObM+4Iso9LF8PU01EfmTvczl+hI79qauYigZR3s+GIF6VWelugBZfx3
	 52LPmACZcxKuw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RESEND PATCH] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Thu, 24 Sep 2026 01:41:26 -0700
Message-ID: <20260924084127.3620-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924075754.6839-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 15:57:42 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> Just a reminder, I think you might have missed the question I asked.

Sorry, I dropped the ball.  Thank you for reminding, Liew!

> 
> On Sun, 20 Sep 2026 03:09:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> > By the way, Sashiko reported an issue [1]: min_region_sz is not
> > power-of-2.  While this do not cause any real issue in this test,
> > non-power-of-2's min_region_sz is not legal.  Should min_region_sz
> > initial value set to power-of-2 value (e.g., PAGE_SIZE) in the next
> > revision?

Yes, let's use a power-of-2 value.  '1' should also be suffice.


Thanks,
SJ

[...]
