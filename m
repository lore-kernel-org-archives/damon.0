Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E68372EF7
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774216794; cv=pass; b=OAJWhgpYV45e0IjLHoxmyQhJMJYFIBqTwfYExgVC+VsqRNZ9lO3mZM7HSiuS7aB3ODqQB20dqOa+p97LNqSWCdIHCQ5QLPEMT4ud4Y3Y4WRpxAPJMOl/12mf3sDOi/LHRLSEu9D9JSVjgj6iOYI1TB3HpR9LkAlA6KCvKjyaa04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774216794; c=relaxed/simple;
	bh=jQDbVDta+C59ov4AAQOqD9v02ssCf7pfCiIPOtA7/K0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=k3IMy30Gjnq17qV9E4qfRrIIpFsQr+VCRwMdynEvS87VHq/ltHHY2onvQUHfwKtXtbKL6DRkorntFnlQ1CFrTaRVOdWK+a/cAZNYaE5hY7wawokoMn+BALinYW+lzVq3wFtRzSopj+dGUaqB1y8CxEZRutzNnYOSDyw4VPkpB6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fxNZhfFB; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fxNZhfFB"
ARC-Seal: i=1; a=rsa-sha256; t=1774216788; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EKuccVsvfUIJRgw7tycR80l5VpmyxcRpgC13lfLNAZMKQ54ycbbB3H6NCTjhTxbI4JUgq9rre247wKJGaIIIBBDQLVXCXN0vyal34YyyViPU9GkmQUcjTZZOiRmFOm/72k11JbNKhz46Le+I3qXNPMqgFaP0nlXRQRQx2juqwOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774216788; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q5SBfcXWoZKMehLKAOaodzbx+qJB2kcIdSj54XofiDw=; 
	b=NYXzc+OHfPK4EVs45DKdQyGlLoP12uWaymMcBsaL1ZNS8DXvWi+qb54zD4tzyBi0KzqCiXPBoH3Eu2jGQA/YGeMPav71Je2GF66QfeMXrgB3+OZcNWA/s9hFZYTXNRs4e940cuvHEGUhexCWcJ+9XhwqO5jKQLOOXTbVW9VTDgw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774216788;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=q5SBfcXWoZKMehLKAOaodzbx+qJB2kcIdSj54XofiDw=;
	b=fxNZhfFBq5whhE1w6Mw+L+aVzRP1aEkxdGImtwtkeewvXhFyyohIF1TxBSItrdIB
	XuAGie/RPS+eN+i5P52dDeQx7yCgb2oVLakv+CFrxTQjM3+caxxZfynEBNls36pOmF6
	iy1T2rxXozNhnwLvfo68TBEZ/maspX1ldfBFWJKs=
Received: by mx.zoho.eu with SMTPS id 1774216786422857.3733260462551;
	Sun, 22 Mar 2026 22:59:46 +0100 (CET)
Date: Sun, 22 Mar 2026 21:59:45 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_mm/damon/core=3A_optimize_kdamond=5Fap?=
 =?US-ASCII?Q?ply=5Fschemes=28=29_by_inverting_scheme_and_region_loops?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260322214419.89419-1-sj@kernel.org>
References:  <20260322214419.89419-1-sj@kernel.org>
Message-ID: <C9B59023-161D-405F-8941-1B0E0B8E1D6B@objecting.org>
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


My last email:

Hi SeongJae,

I've looked into this further and ran some extra benchmarks on the kdamond=
 hot path to see if the gains were actually meaningful=2E

The main issue right now is that kdamond spends a lot of time "spinning" t=
hrough regions even when there's no work to do=2E For example, if a user ha=
s 10,000 regions and a few schemes that have already hit their quotas or ar=
e disabled by watermarks, the current code still iterates through every sin=
gle region just to check those same flags 10,000 times=2E

In my tests:

Typical setup (10 schemes, 2k regions): ~3=2E4x faster=2E

Large scale (10k regions, hitting quotas): ~7x faster=2E

Idle schemes (watermarks off): ~7x faster=2E


It's also a cache locality win=2E Right now the CPU has to bounce between =
different scheme metadata inside the innermost loop for every region=2E Inv=
erting the loops lets us process one scheme completely, which keeps the hot=
 data in L1/L2 and gives about a 10% gain even when everything is active=2E

The goal isn't just to shave cycles, but to make DAMON scale better on hig=
h-memory systems (512GB+) where the region count is high=2E This keeps the =
background "CPU floor" much lower when DAMON is supposed to be idle or thro=
ttled=2E

V/R



Josh Law
