Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134698;
	b=gULef4P8O4Kczpa0hxNhQTUvO75ZTuNLI+GwomxM4q3E3mgE/Rl/4BnrLjhEfdQY9eVw
	 L69AjiUgaXg8O2nRs1YvkpkAui3nhRwO/B/M2zpNre7SgcTOxX5nQTTHPO3x1m0hII3Cf
	 cEa+srsgTkXuYbHxjVVF7YwD0uJLYxV1x8GaxjLrYMOpJKtMaLO3dfPqcxqFgtII8pc/G
	 Tea+9mDkt2mW+UEM48KrhFAbT7z7e0wWiqWNM2ASorCITRtdjVoGacCC7ibN1AjSGA2PH
	 JblLm8FdSj4Q4mLIHVfJzSQkRR6FOZ9pyjXI1HbYvnGCN6IH9gRRgG3+lBn+lyiDFSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134698;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FSLKH/ZOja5ZsyP9KHbldn9we9OtgyfCNQ24loR9CoQ=;
	b=HioVbdB+RH569DCXYilGNeQVqD4aX/LYkVcozfnQcBEwurkDaZOxvpwdwRzqLCjHUdgk
	 mEdYPBcNeTLeaZ5rIssYqDVtWYFSySzQaOGBXAvFtqsXuIe8GYPn6GxZpNqYpZEzwE3XH
	 3kXXpKmwwAId4nsFh89+OyAt2Ov9LcWRlo4HEcHSVr6VXyw3133LYS/W8vB09KNDXO9hz
	 B8O4H1Cv/10KZJmbm7Bw0U8UBZU73t8WyBavbKYLJSLD1oXk2RJmqd8+BxY6jeSWq6OC+
	 LPPqgdM63VTx6z/WEk8MJQMv3GkgJo5i1dWlrSKTTMBhs6Jzj535WjNg3+r/bXNawRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVe8L4A6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB444606A320
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVe8L4A6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDAC1F000C4;
	Fri, 20 Nov 2026 00:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795134697;
	bh=FSLKH/ZOja5ZsyP9KHbldn9we9OtgyfCNQ24loR9CoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVe8L4A6oRe2k4jkjEWYow3Jfj4qr6RGzbiDtpkgbmV9hrm9gkcbKcVmiO/oLgkqg
	 EGYbtUfeMii9ggOYIFakAwnomI21GJDZyRkkStZAfOxC249yZuMCmaq8pofFYaw7A6
	 kwKycNmrcuI0pnINtk3RLS2TfJO3MmRKjGJ/6rM/dPFEaGS/6UMsWphiELZ0sOz5/f
	 IgV19Yf+TBl0X5B/hJTNisnVPkffkXv6Qa9SDWpTaMTSKRlk1INxulDsHlAswulp1c
	 RIBNG8BaFpBzFwdgQPvKFK1jpow4hq4BqRdi5y51gSzJGxQ4Kppp/XPKpKC/I5Go8K
	 eHgyFOxmHnf0A==
Message-ID: <sashiko-outbox-224267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: fix damos_walk() hang with zero
 watermarks interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Feng" <evanfengff@gmail.com>, "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261120001300.11809-1-evanfengff@gmail.com>
References: <20261119014247.119946-1-sj@kernel.org>
 <20261120001300.11809-1-evanfengff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 00:31:36 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] mm/damon: missing Signed-off-by trailer in commit message
- [Low] mm/damon: commit message body is an unedited mailing-list reply
- [Low] mm/damon: missing Fixes trailer for damos_walk() commit
  bf0eaba0ff9c
--

commit 47dbaffa25c5043afa14731164c912784e9890e4
Author: Yifan Feng <evanfengff@gmail.com>

> mm/damon/core: fix damos_walk() hang with zero watermarks interval
>
> On Wed, 18 Nov 2026 17:42:46 -0800 SJ Park <sj@kernel.org> wrote:
>
> [...]
> > But, this could make has_schemes_to_apply has false positive.  How about
> > calling damos_Walk_cancel() when has_schemes_to_apply is false, like be=
low?
>
> Thanks for the review.  You are right about the false positive.
>
> I tried your change.  It fixes the hang, but has_schemes_to_apply is also
> false whenever no scheme has reached its next_apply_sis yet, so it cancels
> the walks of activated schemes too.  In my test (one stat scheme, default
> intervals) 18 of 20 update_schemes_tried_regions writes got -ECANCELED,
> and two selftests fail: sysfs_update_schemes_tried_regions_wss_estimation=
.py
> and sysfs_update_schemes_tried_regions_hang.py.
>
> What do you think about cancelling only when no scheme is activated?
>
> '''

[Severity: High]
The commit message is missing a Signed-off-by: trailer, which is required by
Documentation/process/submitting-patches.rst to certify the Developer's
Certificate of Origin.

[Severity: Low]
This isn't a code bug, but the commit description is an unedited mailing-li=
st
reply ending with trailing single quotes rather than a standalone changelog
explaining why damos_walk() hangs with a zero watermarks interval and how
tracking activated schemes in kdamond_apply_schemes() resolves it.

[Severity: Low]
This fixes the damos_walk() hang when all schemes are deactivated with a ze=
ro
watermarks interval.  Should the commit message include:

  Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120001300.1180=
9-1-evanfengff@gmail.com?part=3D1
