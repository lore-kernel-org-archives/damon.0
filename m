Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023B421EF6
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432672; cv=none; b=Jbmrj0mZH9RYLaQgJI94Xtj/TXHSeDHFpuAPnQX6BusGKZKNJPJP2LB4xYBnC8K8OlyF2kZTjCBNdMzVpTPaUIc5C9Kg4P4l6mQOSrZkLlZPoHYNn/E/UmzruZ1rai8AdqiCMxn5zokU2QoLTp17RRC8t1+pvusmOXr+wHdfoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432672; c=relaxed/simple;
	bh=AoujrY4llQxmK5UV5Bik9asx20O94lNtoTVIogCnPXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cNcByzbssZl6wFxBJfVsvT9PVJY1x0PvYX8plv9zXXdPw8hL1q1dGd7r0k9HVlJyWip5HjEMZU5B4YjRAIt2J3GiCFccrCALO/S/uUwrWcJjIl5mhaSmfpr0soRAseBlc/Y4RgIA13+b5xcWVGP+a+Wl0uktHnfKDDqFXMxW2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6JKc91M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6JKc91M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD21B1F00A3A;
	Tue,  7 Jul 2026 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432671;
	bh=23F5tnxWYi81M84y36uYW40GWqxl9TZeEUzwfK4gLnw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U6JKc91MEgopmXgfMO9fuwHRsC9yMM84Ae95iJP5aAqqcj1t1oTQdqrJtkAW2ib8K
	 g3DAqfQHpdJ4+0Ives6bv0PosNEW6lP0OXTemU2AgCEvq2LJS8O8dt0whSJU3zMPAK
	 wzrUu5yNKjIH0kUZ+31W5nBTEkPe0dRJNpx9qcG/k4NEBo5xkFMZa+By4QV81rpTnA
	 UicCwzZY+sGzckAic4YFDtclu/t9W/LMSMvQWWcBGZBYEKq6BeZZ9Sr1IWss3Qz92c
	 BvaBYKizJwxHHbYhHLpkPhJ6P06MvdEDTHtYTjSdJERmOnAM+dhoCoHqKCEKnn9t9O
	 AgV9xK2GiL6DA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 1/7] mm/damon/core: remove obsolete comment for
 nr_to_bp() divide-by-zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707135038.90068-2-sj@kernel.org>
References: <20260707135038.90068-1-sj@kernel.org>
 <20260707135038.90068-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:57:50 +0000
Message-Id: <20260707135750.DD21B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing the `!attrs.aggr_interval` skip guard causes `damon_tes=
t_nr_accesses_to_accesses_bp` to fail deterministically on 32-bit architect=
ures.
--

--- Patch [1]: [RFC PATCH v1.1 1/7] mm/damon/core: remove obsolete comment =
for nr_to_bp() divide-by-zero ---
commit a31fcddef9e05dc323b42f64143ffe58dc702dee
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove obsolete comment for nr_to_bp() divide-by-zero

This commit removes obsolete comments about division-by-zero in
damon_nr_accesses_to_accesses_bp() and its related test code. A previous
commit modified the underlying calculation to always return a non-zero valu=
e,
preventing the division-by-zero issue.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 0124f83b39b83..224a3ecaa0701 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
[ ... ]
> @@ -582,18 +582,6 @@ static void damon_test_nr_accesses_to_accesses_bp(st=
ruct kunit *test)
>  		.aggr_interval =3D ((unsigned long)UINT_MAX + 1) * 10
>  	};
> =20
> -	/*
> -	 * In some cases such as 32bit architectures where UINT_MAX is
> -	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
> -	 * damon_nr_accesses_to_accesses_bp() in the case will cause
> -	 * divide-by-zero.  Such case is prohibited in normal execution since
> -	 * the caution is documented on the comment for the function, and
> -	 * damon_update_monitoring_results() does the check.  Skip the test in
> -	 * the case.
> -	 */
> -	if (!attrs.aggr_interval)
> -		kunit_skip(test, "aggr_interval is zero.");
> -
>  	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);

[Severity: Medium]
Will removing this skip guard cause a deterministic test failure on 32-bit
architectures?

When the test runs on a 32-bit architecture, attrs.aggr_interval is initial=
ized
to ((unsigned long)UINT_MAX + 1) * 10, which overflows to 0. With the divis=
ion
by zero fix in place, damon_max_nr_accesses(&attrs) will return 1 instead o=
f 0.

This causes damon_nr_accesses_to_accesses_bp(123, &attrs) to evaluate to
(123 * 10000) / 1 =3D 1230000. Since the test unconditionally expects the r=
esult
to be 0, the KUNIT_EXPECT_EQ assertion will fail.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135038.9006=
8-1-sj@kernel.org?part=3D1
