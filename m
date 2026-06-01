Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74301E5207
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780281240; cv=none; b=PTg1OszUn+tP0g9rVGgWf8mHrhalQrIe+AOBSr7Jwb4qGor6MKfan5VG8ifPRAe51biCcnNBz+Ny07jd6MHzJyjKoKmcBGi62RQqS/eBZJMOFvUjbU3pj5vh6kPthUg2UHE4ORT5N4J4MzIqOowLGwryiH9A3IEe1d3pm3E2ucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780281240; c=relaxed/simple;
	bh=JqDHJVAKyGpl+ngYGBc4rz9MtrD0LjNaznhwCYkd3R8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=MYtZowmUPhGpxmOgU56TXmuOcuOOYWZVkazCDX4RNAz5BBQUYRIDkVKscnNxzGdZlz02uvZuQnmOcIYuDUnyVhgS99uVNCiz3zzVmyfVcAB9W3QetA1x6Vu+zOiiAh/f/twl/XWUWJivxkkMFqD8RMQ48X++z2TU9AQjwj6vOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USGIKcbS; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USGIKcbS"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780281236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMHgRM2VgLCMfYV/Kx1tsJefCoHRzu2kO6ZVF0TG+Ng=;
	b=USGIKcbS9nOCEqYdBNcQ0LJXZKLix/4zkNsDQi4I/bTsjwkJ15Jjc1l9ouC84+s+uKAKQx
	peltIFP+3sBipJu0MValVmndBCloOGVXp684I5NEdj9O7B438dTOT+Xa87xcFq25H6G3bX
	eOWzpOa7XvD1Dae3zeJmayev2iA3IrQ=
Date: Mon, 01 Jun 2026 02:33:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <4915dbdd42711403f1781e3c7a71a11a53b0249d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 4/5] selftests/damon/damos_tried_regions: handle empty
 tried regions in early cycles
To: "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, shuah@kernel.org, damon@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Kunwu Chan" <kunwu.chan@gmail.com>, "Wang Lian"
 <lianux.mm@gmail.com>, "Kunwu Chan" <chentao@kylinos.cn>
In-Reply-To: <20260531165437.99410-1-sj@kernel.org>
References: <20260531165437.99410-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

June 1, 2026 at 12:54 AM, "SeongJae Park" <sj@kernel.org mailto:sj@kernel=
.org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > wrote:


>=20
>=20On Sun, 31 May 2026 17:17:23 +0800 Kunwu Chan <kunwu.chan@linux.dev> =
wrote:
>=20
>=20>=20
>=20> From: Kunwu Chan <kunwu.chan@gmail.com>
> >=20=20
>=20>  The test aborts if the initial aggregation cycles produce zero
> >  tried regions. This can happen on slow machines, causing false
> >  failures. Skip empty cycles and retry up to 200 times before
> >  giving up. Also check that enough samples were collected before
> >  computing the 50th percentile.
> >=20
>=20I agree this will make the test be more reliable. I'm bit concerned i=
f 200
> times retry can make the test run too long, though.
>=20
>=20Also, could you further elaborate why this can fail on slow machines?=
 That is,
> DAMON will check the access of 'access_memory_even' process every 5ms. =
Are you
> thinking the 5ms is too short for 'access_memory_event' to make the exp=
ected
> access (accessing the 7 regins of 10 MiB size) within? If so, should we
> increase the sampling interval before retrying?
>=20
>=20I also suspect if the unreliable results you seen is due to the fact =
that DAMON
> is not flushing TLB, like we discussed before. If that's the case, coul=
d we
> increase the working set size of this test, similar to the wss_estimati=
on test?
>=20
Thanks,=20SJ.

Good points.

I don't yet have enough evidence to say whether this is primarily due to
scheduling delays, a too-short sampling interval, or effects from not
flushing TLB.

I'll investigate the root cause and see if increasing the working set
size or adjusting the test configuration may be a cleaner solution than
adding retries.

I'll drop this patch from v2 for now and revisit it once I better
understand the root cause.

Thanks,
Kunwu

> [1] https://lore.kernel.org/20260525144846.604907-1-kunwu.chan@linux.de=
v
>=20
>=20Thanks,
> SJ
>=20
>=20[...]
>
