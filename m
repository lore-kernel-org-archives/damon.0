Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D8184
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774216418; cv=pass; b=aKRVL6Ckt2AGuR82ZB3Ghaq1XoMoZn7gLSA2OEtJv67PGIfiF8gaio7LHymaFj9MF+bO2iYcUKbLp9hPxCT9w9jfweSGq7DOHNjT+5UKLQk8rv1UzrW1PFrWZEvuCpHBn6D9qCd2JDYV920BFLsfL/XRgMn/4wZteDSIdEeUy5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774216418; c=relaxed/simple;
	bh=lr6H2QANCxVXmW2AFbe50Fcw9NcfRVU9+4IWWM9Yf+k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Pp9uzWNH9MGOQnNsQFaqJrVauPqQ4KgdUEe/4JzLVZoH1IIWP/mZO3BnqBpTSnqwfZfi1VFUE9waSMLAR87mwdXLh6Md1pZw4Z+QG8HeV39H6xu1FVxCGOqmtKmFRV3tRnfyFhVKtuEnAbFUpF5pTwdxU73NaybCBGt2Km87XK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=lURDETyr; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="lURDETyr"
ARC-Seal: i=1; a=rsa-sha256; t=1774216413; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VidU/wf5Kvvx/sTsGhtWEGH3ltaSypCbWXvnDUaFc9c2Rlr3hC0nSHazcAlX/EVrLjULlihQxgGTHzr8xavN4dGBKGDpE7UPzA8VJ39SX/vfPo2+DfG97TkhkHKsmLJ2DvS1lbVQgZfCp3J1lOVmE0IKg7aLAaOvboV/By6GrMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774216413; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WF2Jc8jd49SvUSReADfs88mf3NQmxL0j42Z4CgklKLE=; 
	b=Q63SMqXzOTh0Rb1p4XJReNpIPZuBtshCuJMDq7pWJ8LR64zFlAPCVSXps7wYrWQfy7oWFwQ9r78LnYQKIyoextx9a9jT6139eqCcz+wCqh3j6WjVaYl40DZ4qyS6t5vOZLJAU+HWge+42Fq9oXFUbVtHiLCYUepiKYPgMQQrC5c=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774216413;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=WF2Jc8jd49SvUSReADfs88mf3NQmxL0j42Z4CgklKLE=;
	b=lURDETyrJVICtD8UJRuvXuKJ2KZXOS1pQk1AKY5vbZ7DAob+k+fxHbINdCs5+Me4
	SEab9bznZcPkM2vwJpSV+do/um7Dmcj0k8pZxuTs7NDH2hww7wqiKSoFLCUzlz3o1mw
	2jNHXkHYv/llp/iba8ohv3CbKpWPQvOgFN9M2oV0=
Received: by mx.zoho.eu with SMTPS id 1774216412426730.3504676121884;
	Sun, 22 Mar 2026 22:53:32 +0100 (CET)
Date: Sun, 22 Mar 2026 21:53:31 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_mm/damon/core=3A_optimize_kdamond=5Fap?=
 =?US-ASCII?Q?ply=5Fschemes=28=29_by_inverting_scheme_and_region_loops?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260322214419.89419-1-sj@kernel.org>
References:  <20260322214419.89419-1-sj@kernel.org>
Message-ID: <19250970-62DB-4151-9170-BD2930C6D59D@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 22 March 2026 21:44:18 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>Hello Josh,
>
>On Sun, 22 Mar 2026 18:46:40 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>> Currently, kdamond_apply_schemes() iterates over all targets, then over=
 all
>> regions, and finally calls damon_do_apply_schemes() which iterates over
>> all schemes=2E This nested structure causes scheme-level invariants (su=
ch as
>> time intervals, activation status, and quota limits) to be evaluated in=
side
>> the innermost loop for every single region=2E
>>=20
>> If a scheme is inactive, has not reached its apply interval, or has alr=
eady
>> fulfilled its quota (quota->charged_sz >=3D quota->esz), the kernel sti=
ll
>> needlessly iterates through thousands of regions only to repeatedly
>> evaluate these same scheme-level conditions and continue=2E
>>=20
>> This patch inlines damon_do_apply_schemes() into kdamond_apply_schemes(=
)
>> and inverts the loop ordering=2E It now iterates over schemes on the ou=
tside,
>> and targets/regions on the inside=2E
>>=20
>> This allows the code to evaluate scheme-level limits once per scheme=2E
>> If a scheme's quota is met or it is inactive, we completely bypass the
>> O(Targets * Regions) inner loop for that scheme=2E This drastically red=
uces
>> unnecessary branching, cache thrashing, and CPU overhead in the kdamond
>> hot path=2E
>
>That makes sense in high level=2E  But, this will make a kind of behavior=
al
>difference that could be user-visible=2E  I am failing at finding a clear=
 use
>case that really depends on the old behavior=2E  But, still it feels like=
 not a
>small change to me=2E
>
>So, I'd like to be conservative to this change, unless there are good evi=
dences
>showing very clear and impactful real world benefits=2E  Can you share su=
ch
>evidences if you have?
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Hello,=20


 Performance Scaling Scenarios (Speedup of New vs Old)                    =
                                                  =20
 | Scenario Description      | Speedup |                                  =
                                                  =20
 |---------------------------|---------|                                  =
                                                  =20
 | Typical (5s, 1k regions)  |  1=2E9x |                                  =
                                                    =20
 | Large Scale (5s, 10k reg) |  6=2E9x |                                  =
                                                    =20
 | Multi-Scheme (20s, 1k reg) |  4=2E0x |                                 =
                                                    =20
 | Idle Schemes (10s, 1k reg) |  6=2E9x |                                 =
                                                    =20
 | No Quotas (All Active)    |  1=2E1x |


This here is a benchmark full of multiple real world scenarios (made in C)=
 and the speedup


About real world usage, this improves performance massively with most cons=
umer based systems=2E


V/R


Josh Law


