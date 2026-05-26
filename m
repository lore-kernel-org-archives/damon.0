Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC13CFF5F
	for <damon@lists.linux.dev>; Tue, 26 May 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785888; cv=none; b=Ca7Sau8q9KOuW8mUDSIPT2GtOYGzo1VdcFbetixMK9fiAsqeg50WDLeqHLYVyEJXBZ1GvY8FTJnxStICEcrSZfgi1Z6aCGI+sdFmuUVw9I/kFnaZShyBwEjTh487dkwfR7SQEMV8zwHDSuNao4zCTAhTVIb9jjpWtrBI0cgi23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785888; c=relaxed/simple;
	bh=mbI/1ZZyLFFY7tkeghObR6q7VK9b3u0nCeZBv4zIOnA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=lWtl8sUIOolfUWsIcJpzY7NVXl33Ma7Q7hM2pnfH9JhKr4fe9DaF/G0tMFskb2R1bfd+5ZsNLJ++C+jcjXeSSX/0Oe3soi7YHZMo2gpQK6aLJehmKRD9fiix4F23SuifW8v2dPIn01pBfpJyO9+5a5C8aX66cStjG9nKGTWI8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b6wPl46V; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b6wPl46V"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779785881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE7MjLXIxkGaqCG0W4L8suV+9EMhirV+1X23ro04U8I=;
	b=b6wPl46VbjaUgUx7obH+o2ROBodD3XpXi56J75qiOm5YfaFQE0UDyitx4P/owEykhCb19Z
	liZK1szz3t812AYxM1O6Ex3O8hYfEGBK6NB+ycURXF3W8igegOtnwVQPwpFWi3wxalt9Dx
	F//fjmxCp95ExH2CYua+asEsg5aiL2Q=
Date: Tue, 26 May 2026 08:57:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <3d09f6b9cf4a9b275876185f5b234253e7af0225@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/damon: fix stale TLB young-state handling on arm64
To: "SeongJae Park" <sj@kernel.org>, "Kunwu Chan" <chentao@kylinos.cn>, "Wang
 Lian" <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260525174640.9440-1-sj@kernel.org>
References: <20260525174640.9440-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

May 26, 2026 at 1:46 AM, "SeongJae Park" <sj@kernel.org mailto:sj@kernel.=
org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > wrote:


>=20
>=20On Mon, 25 May 2026 22:48:46 +0800 Kunwu Chan <kunwu.chan@linux.dev> =
wrote:
>=20
>=20>=20
>=20> From: Kunwu Chan <chentao@kylinos.cn>
> >=20
>=20Thank you for this great patch!
Thanks for the reply.
>=20
>=20>=20
>=20> damon_ptep_mkold() clears the PTE Access Flag so that a later
> >  access will set it again and damon_folio_young() can observe it
> >  via pte_young().
> >=20=20
>=20>  On arm64, however, ptep_test_and_clear_young() clears AF in the
> >  page tables without invalidating the corresponding TLB entry.
> >  Subsequent accesses can therefore continue hitting a stale TLB
> >  entry without a page table walk. The PTE AF bit stays clear,
> >  pte_young() reports false, and DAMON treats the region as
> >  unaccessed.
> >=20=20
>=20>  folio_set_idle() does not help here. It updates only software
> >  state, and accesses through a stale TLB entry do not clear the
> >  idle flag.
> >=20=20
>=20>  As a result, nr_accesses stays low regardless of the real access
> >  pattern. DAMOS schemes fail to match, WSS estimation reports
> >  zero, and actions like pageout never trigger.
> >=20
>=20You are correct. Nonetheless, we intentionally designed DAMON in this=
 way, to
> avoid the performance overhead from the added TLB flushes. Meanwhile, w=
e
> believed this is ok in terms of the monitoring results accuracy on real=
 world
> production environment, becasue such environments would have large amou=
nt of
> working set that flushes TLB buffers anyway. We decided to take this wa=
y after
> a measurement [1].
>=20
Understood,=20thanks for the detailed explanation and context.  We were
too focused on the testing issue and overlooked the original tradeoff
between monitoring accuracy and the overhead of TLB flushing.

> And apparently you found this behavior as problematic on a test environ=
ment
> that having small size of working set. We found a similar issue in DAMO=
N
> selftest, and we updated the test [2] to simulate the expected real wor=
ld
> production environments, rather than changing DAMON.
>=20
That=20makes sense.

The selftest change in [2] also clarified why DAMON normally works fine
in production workloads. Large and active workloads naturally exceed
TLB coverage, so accessed-bit updates eventually become visible again.

So I agree that adjusting the test instead of forcing TLB flushes in
DAMON was the right tradeoff there.

> But, this kind of question is recurring. In addition to the previous
> discussion, there were a few private inqueries for this issue. And thou=
gh the
> real world production environment is the priamry target of DAMON, I und=
erstand
> it is better to support testing environment, too. So, I think it is bet=
ter to
> make some changes for this issue, if it doesn't make other problems.
>=20
At=20the same time, I also understand why this keeps coming up.  Test
environments can differ a lot in workload size, THP usage, VM setup,
and hardware configuration, so stable and reproducible testing is not
always easy across different systems.

So I agree it makes sense to improve this area as long as it does not
add noticeable overhead or cause problems for the normal production
case.

> >=20
>=20> Fix this by switching to ptep_clear_flush_young() and
> >  pmdp_clear_flush_young().
> >=20=20
>=20>  On arm64 these perform the required TLB invalidation after
> >  clearing AF. The invalidation is deferred, but still sufficient
> >  for DAMON's sampling granularity.
> >=20=20
>=20>  On x86, ptep_clear_flush_young() is equivalent to
> >  ptep_test_and_clear_young() for base pages, so there is no
> >  behavioral change. pmdp_clear_flush_young() additionally performs
> >  a flush at PMD level, matching the existing x86 implementation.
> >=20=20
>=20>  On powerpc, riscv, and s390, the clear_flush variants currently
> >  map back to test_and_clear implementations, so this patch does not
> >  change their behavior.
> >=20
>=20This change seems much nicer and might be more optimized than my simp=
le
> implementation of tlb flush [1] that I tested before.
>=20
Thanks.=20Yes, we were mainly trying to reuse the existing
arch-optimized helpers as much as possible.

> >=20
>=20> Reproduced on arm64 (128 CPUs, 7.1.0-rc4):
> >=20=20
>=20>  before:
> >  WSS estimation: 50th percentile error 100% (reported as zero)
> >  apply_interval: schemes never tried
> >=20=20
>=20>  after:
> >  WSS estimation: 50th percentile error 0.08%
> >  apply_interval: passes
> >=20
>=20And nice test results. I guess you are referring to the tests in damo=
n-tests?
> Clarifying the context would be nice.
>=20
Yes,=20those results are from: make -C tools/testing/selftests/damon run_=
tests
on the arm64 test machine mentioned above.

The before/after summary was extracted from the relevant failing tests
(sysfs_update_schemes_tried_regions_wss_estimation.py and
damos_apply_interval.py) for brevity.

> Also, have you had a chance to measure the performance impact?
We haven't done detailed performance measurements yet, but we can try to
collect some numbers for the flush overhead on a few different setups.
=20
>=20So, I'd like to have this change. But, unless we have very clear evid=
ence
> showing this change is not increasing the performance overhead, I'd pre=
fer
> making this as an optional feature.
>
We agree that making it optional sounds safer unless we have solid
evidence showing the overhead is negligible. Keeping the current
default behavior for production workloads also makes sense to me.

> For the user interface, we could add a new sysfs file for the option, s=
ay,
> 'flush_sample_tlb' under 'monitoring_attrs' directory.
>=20
The=20proposed 'flush_sample_tlb' interface under monitoring_attrs sounds
reasonable to me as well.

> For long term, I'm planning [1] to extend the data attributes monitorin=
g
> feature so that data access becomes just one of the attributes. Once it=
 is
> done, we could control this tlb flush option using the probes interface=
.
>=20
>=20I was initially thinking about asking Kunwu to wait until the data at=
tributes
> monitoring extension is done, and add this tlb flush option on top of t=
hat.
> Because, otherwise, we may need to deprecate 'flush_sample_tlb' after t=
he
> extension is done. But, we will anyway need to deprecate a few interfac=
es
> including 'nr_accesses'. Doing the deprecation of 'flush_sample_tlb' to=
gether
> with it shouldn't be huge amount of overhead.
>=20
>=20So, unless Kunwu and Lian has other concerns, I'd suggest the
> 'flush_sample_tlb' path.
Yes, we also think deprecating it later together with interfaces such as
'nr_accesses' should be manageable once the data attributes monitoring
extension is ready.

Thanks, Kunwu
>=20
>=20[...]
>=20
>=20[1] https://lore.kernel.org/20200403103059.12762-1-sjpark@amazon.com/
> [2] https://lore.kernel.org/20260117020731.226785-3-sj@kernel.org/
>=20
>=20Thanks,
> SJ
>
