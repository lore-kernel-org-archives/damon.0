Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7633EB1B
	for <damon@lists.linux.dev>; Wed, 20 May 2026 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259374; cv=none; b=seYAs6NYn97qUfNiiqnGZZRbTTBKQApraCt8ZleV68OTed8ogiT4IBS7LFmGSKFBLj9fyvygkK/9AQmJfK4kDowA7OndDp+53Z1i2B9gIZzoNHMKmagfj2FDJL3zdlg5B0WNP9mTsnQ6K4XdbqoWuGQgk15MUfeg3eRj3rh1jp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259374; c=relaxed/simple;
	bh=plpZ2TBDHTKDFgL4CxD8QgS2umthpYOrayiiL0nQ8oM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IUPQqkR34szAEIFaNPMt9AbIsR6ZMfzQnLwUr5wsrz+/tuy23JvT9J9OHg+l2LMkjtumekeezB50cl3Cgb3I2cqQawjCktUWYiqf1ou26w2q+2C8j3tfDdocgil5M0a6cDDJPXyFDvNBoubd08lefiB7xvWhjt19YXCXz0Eijfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocaSqUn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocaSqUn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10C61F000E9;
	Wed, 20 May 2026 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779259372;
	bh=0VYkScAC+RTF8hNPQUUgY1cA3fQizNk1G92nPI1YbLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ocaSqUn6Aiq6xFiyKDSTt2DbHl7goX4LypjJGQnuFqQci71W1RxtEh9PnI8W8OOMB
	 qo89xk66iaSDO7a/b3CwjNSId0GXjkBPP5Zvg4zpHb5NvqQAEioTNnG9yB91Z0lgf9
	 +9OcYrQxnL9NT1HIW9mnxCwkiI0uX09uzly2frrK8sLmXTjmmnYk1FIZfR8wl6vSGh
	 AzN6hy9Qc0ylp2xO/c5/r+eCVqthVU64i3HFHiScSawk8acJ5DPLZXaI1MvQPj2AFC
	 F0D7K9sKY9CW0adVCEco2txiyKC4RAjqwYLVPGTKqLCb+OKjhzsyskwpUbXGFpAeta
	 /W3InBVysLnMA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 14/14] selftests/damon/sysfs.sh: test pause file
 existence
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260520062858.167011-15-sj@kernel.org>
References: <20260520062858.167011-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 06:42:52 +0000
Message-Id: <20260520064252.A10C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added test for the 'pause' file passes the typoed stri=
ng 'exit' instead of 'exist' to `ensure_file()`, causing the test to silent=
ly do nothing.
--

commit dfd394f0319e5426a9139ffa02a782a34b43e8ff
Author: SeongJae Park <sj@kernel.org>

selftests/damon/sysfs.sh: test pause file existence

This commit adds a test to ensure the 'pause' sysfs file exists in DAMON's
sysfs interface.

> diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selft=
ests/damon/sysfs.sh
> --- a/tools/testing/selftests/damon/sysfs.sh
> +++ b/tools/testing/selftests/damon/sysfs.sh
> @@ -366,6 +366,7 @@ test_context()
>  	ensure_file "$context_dir/avail_operations" "exit" 400
>  	ensure_file "$context_dir/operations" "exist" 600
>  	ensure_file "$context_dir/addr_unit" "exit" 600
> +	ensure_file "$context_dir/pause" "exit" 600

[Severity: Medium]
Is this test unintentionally bypassed? The helper function ensure_file()
checks for the strings "exist" or "not_exist" to determine what checks
to perform. Because "exit" is passed instead of "exist", the function
evaluates neither condition and returns immediately.

This prevents the test from verifying the file's presence or its
permissions, causing it to silently do nothing.

>  	test_monitoring_attrs "$context_dir/monitoring_attrs"
>  	test_targets "$context_dir/targets"
>  	test_schemes "$context_dir/schemes"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520062858.1670=
11-1-sj@kernel.org?part=3D14
