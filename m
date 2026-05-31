Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E82D8DB5
	for <damon@lists.linux.dev>; Sun, 31 May 2026 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229815; cv=none; b=oAaNY+GHQhcRdBbCYhAtJu8P+7j9Invd2cz86Go08CElSChHEAUQSlLxFv/q6bbW2ONGBzSP/ecLD2AM4MIKSmIPYzdcMJAOlhuSQo7Ndf7i0ZfzgKjOXEndges4QwG12vm9qCUSm1AahMJ0HtG80JMGQjkYg5HnvQWUGYAmRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229815; c=relaxed/simple;
	bh=zC8ShaPWApdIOceKotrrfLGxdVh5CxaaWvZtirgUxF0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=a+KjLftM72YwQ5MNeooJqCqOfc5nosqhMJXVjTdrn/jw8SWcWgFtbgG8yKZMsRw0IpqoJvTEuvkqcMJkv4RuR5LgPafsqd2ZT0UU4jWKqdlPzULFf7YnpF3A1OlkX/lt9Jp5E6d0+nyE+M9WugBf8BYp4vBvgWXRl9xB172RNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NxKn+BSv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NxKn+BSv"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780229811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSkYXQH+UFXJ6VQOm8Vmkeg+L5wEsvwuM8wq4irKhqc=;
	b=NxKn+BSvrTkHb9Cl02yAUV/0u9KXAEmOObugtmlyFUlsBGh0DSEGiqSlXQGLkVRIftZXe9
	x5h8bJDjj+P9ZDUTsWlezr5gqYuXwu3LNCgUCaYkSJxeQl11lIlMHn/TewWEmgZf4rpiaL
	QVZPbd6dBBxh8e7fDiucDUEHDGN7YyY=
Date: Sun, 31 May 2026 12:16:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <cfa837d8641972b79a404f4f9d489644dd6675f7@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/damon: fix stale TLB young-state handling on arm64
To: "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, "Kunwu Chan" <chentao@kylinos.cn>, "Wang
   Lian" <lianux.mm@gmail.com>, akpm@linux-foundation.org,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260526145034.91594-1-sj@kernel.org>
References: <20260526145034.91594-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi SJ,


[...]

> Thank you for clarifying!
>=20
>=20wss_estimation increases its working set size up to 160 MiB for this =
issue.
> Seems your test machine has large TLB buffer. I think we should decide =
the
> limit based on the real running system configuration and apply similar =
approach
> to other tests including the apply_interval.
>=20
>=20For out-of-tree tests, we may better to provide a guideline, too. E.g=
., run
> this sort of test program with this DAMON config to find the reliable t=
est
> working set size on your setup.
>=20
Thanks=20for the detailed analysis.

We agree that improving the documentation and aligning the tests is a
better direction for now. Adding an optional feature mainly for testing
could confuse users and create additional maintenance burden.

We've already done some selftests:
https://lore.kernel.org/damon/20260531085633.48626-1-kunwu.chan@linux.dev=
/

[...]
> >=20
>=20I was thinking this again. I still want DAMON to be easy to test. But=
, is
> this making tests that difficult? Users could increase the test working=
 set
> size. I'm not very sure that is too diifficult to add new optional feat=
ure.
> Meanwhille, adding an optional feature for only test might make users b=
e
> confused. DAMON usage might also be diverged and add maintenance burden=
s.
>=20
>=20So, now I think another option is improving the documentation. It sho=
uldd
> clearly explain how and why DAMON does not flush TLB and what is the ex=
pected
> problems (in tests) and recommendation. In this option, we should also =
update
> existing DAMON tests to be reliable and aligned with the documented
> recommendation. If we find it becomes a problem on testing even after a=
pplying
> the recommendation, or on production, we can revisit.
>=20
>=20Regardless of the decision about the optional feature in DAMON, I thi=
nk such
> documentation and tests improvement should be made.
>=20
>=20Maybe I'm biased, so any input would be appreicatedd. What do you thi=
nk, Kunwu
> and Lian?
>=20
We=20think that makes sense.  Explaining the rationale for not flushing T=
LB,
the limitations this can introduce for tests, and recommendations for
choosing reliable test working set sizes would be helpful.

If we later find cases where the documented recommendations are still
insufficient, we can revisit more intrusive approaches.

I'd be happy to help with the documentation work if needed.  Please let
me know if you'd like me to prepare a draft patch.

Thanks,
Kunwu

> Thanks,
> SJ
>=20
>=20[...]
>
