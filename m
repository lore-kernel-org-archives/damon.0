Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E12BFC7B
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 04:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399545; cv=none; b=jDx8z2ap3JgJGkkfCl/qhVf8dwaOUrRDxg0hfQvUBcTTONRJwjA+V2xMF96jhu86yu7kXQGYHyFOqAfabq59VamcrLREOFkuYvcWA4FeWfumdGT1C2tgpb0c7FD//LuT1OodeXGf600qfPx+LgsvTinN9G/ICaevAuRWkvyt180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399545; c=relaxed/simple;
	bh=wOF4lZVEHcaYhltSPrMBCcFs7H4yWEIwGynItW8Z5rU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CLL9d2+5h+aimolts7grzhCtRhADCSYN2tmGNg9DAJNWpI0hK1115Yr73YTkO1kCGC4AxwWhT9F5qrYgQgJoLsw75c523jxTlE2mxKwXhaam5Y9+Po4DEvQPZGvzd3OIYDogBIcTZmrgHnZRGbv2Wds6VuzrRBztokkLNMIxy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMW8LZ5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMW8LZ5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E3D1F000E9;
	Tue,  7 Jul 2026 04:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399544;
	bh=6UN8CVFEnDmlpygoLEMSsGy0f6GyJeNX6PannsmtDa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mMW8LZ5ghEDBMCTUHeUPNyVlGtWdDPyTAlO1vL79C596gUeO1MUNL7e2H4DRS1Kol
	 EK2vwgNuIdijGWyz6uWZO73ej6f0YDDw4nncxATfVcENzsNAQ0nG9v3MqJipbNoNsK
	 D8QuC6hw1VpHm0Xm4lNTSIIx8dcCkPhvjNZijfYtNWw4EuFCFm5fGm3flT8EJbsWri
	 limgzqonFh37WJfOrrEkASvBC0hYOIWkZT4YLnhby5E9bdeVXSbiamHUBaPPPMd7g/
	 ZbRPcHL0i6yQYd3sv4jkfn5jG9YZCzP8+3jqg2TK6GonJsyzmAYbuFYTyRTDDBaNWh
	 Lg8nOAhy2vvgg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/6] mm/damon/core:
 s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707043828.97900-4-sj@kernel.org>
References: <20260707043828.97900-1-sj@kernel.org>
 <20260707043828.97900-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 04:45:43 +0000
Message-Id: <20260707044544.42E3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Obsolete divide-by-zero comment and skip logic were not removed =
in the KUnit test, contradicting the commit message and core code.
--

--- Patch [3]: [RFC PATCH 3/6] mm/damon/core: s/nr_accesses_to_accesses_bp/=
sample_count_to_bp/ ---
commit aaafc980a7ea0e3c63783a3dbd0d43aab65ff523
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/

This commit renames damon_nr_accesses_to_accesses_bp() to
damon_sample_count_to_bp() to better describe its functionality. It also
mentions removing obsolete comments regarding a division-by-zero bug that
was previously fixed.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 0124f83b39b83..86eae3a590354 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
[ ... ]
> @@ -585,7 +585,7 @@ static void damon_test_nr_accesses_to_accesses_bp(str=
uct kunit *test)
>  	/*
>  	 * In some cases such as 32bit architectures where UINT_MAX is
>  	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
> -	 * damon_nr_accesses_to_accesses_bp() in the case will cause
> +	 * damon_sample_count_to_bp() in the case will cause
>  	 * divide-by-zero.  Such case is prohibited in normal execution since
>  	 * the caution is documented on the comment for the function, and
>  	 * damon_update_monitoring_results() does the check.  Skip the test in
> @@ -594,7 +594,7 @@ static void damon_test_nr_accesses_to_accesses_bp(str=
uct kunit *test)
>  	if (!attrs.aggr_interval)
>  		kunit_skip(test, "aggr_interval is zero.");

[Severity: Medium]
The commit message mentions that the obsolete comment about division-by-zero
is removed because damon_nr_samples_per_aggr() now always returns non-zero.

Should this comment and the associated kunit_skip logic also be removed
from damon_test_sample_count_to_bp()?=20

It appears to still reference the caution comment that was removed from the
core code, and it continues to guard against a divide-by-zero that can no
longer happen.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707043828.9790=
0-1-sj@kernel.org?part=3D3
