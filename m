Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9672772E
	for <damon@lists.linux.dev>; Wed, 20 May 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259318; cv=none; b=HkWw+D+CqguMhr/md9S+qjfDmsxfB0gHFZftKhSBZ3A9Bs+gG8bDxqDFCki3BO8NHuRpWwLrGXdD9BoZO2hmrpgvSJakclzlK14fiArxGpikFcO/x2bvCTZ8gjeNcA4011E0igQVO2K+GbDUe/kyPT+vJoKU610NWTB0Z80/9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259318; c=relaxed/simple;
	bh=/gaYF4qv695nCsooq6ITDJFEbZJmLCUE1KjbdZV7rZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HG8TS6Kg//YqARGpx5ZpYFbaFtMEfygvZA9j0WxufF5nyotQPpc3tdC5forZYJiMjhzoJPyfm9Bu93Sa+nuB22tDRg0Csan9PrsR5ieV3qEyHRsRddY5w7c1INvQBGSfgakdq+kICGvpyMRbhAdEyv4FQXiAmrW7xD/R7A6fX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8Eb+jkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8Eb+jkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F94F1F000E9;
	Wed, 20 May 2026 06:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779259317;
	bh=osaxrsjVG1Lb3pPXt6ee4NHRextGlmenjbDYau7mkLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8Eb+jkpianCPElsLo/dN8Hy33X/rtj0L2orhiYZ7f4eDvGhrzOLwBLbe5FYX31Kb
	 fSXVUApsp8kAh5VRMe7nZg7lsm6GuZsc4IhxteVsUMvfJUn28CgNr2rGTtmK6C1uZa
	 SuqZemYXAIgcF1AJfMGODr1EQptk/h1dmNFdst6LH+OPZdZXVxkxbZmB2FhepLa/QF
	 59rGj+vhykXa6NXDW7dpcQ04tZGGfORTznaR5/hcTSwouy2Qag7J75DDD8MTwV2mfp
	 ULZCg2lpJKvuWLqhITw6tUx/33d2rFWISN1mqthKjGcTDPlVgX3NaQAGFIuULljS0W
	 Z8KsRZC9ezZHQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 13/14] selftests/damon/sysfs.sh: test addr_unit file
 existence
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260520062858.167011-14-sj@kernel.org>
References: <20260520062858.167011-14-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 06:41:56 +0000
Message-Id: <20260520064157.4F94F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added test for the `addr_unit` sysfs file incorrectly =
passes 'exit' instead of 'exist' to `ensure_file()`, causing the test check=
 to be silently skipped.
--

commit a9bc6162fe06c0405081aeb68c3f5e9a54287e20
Author: SeongJae Park <sj@kernel.org>

selftests/damon/sysfs.sh: test addr_unit file existence

This commit adds a test to verify the existence of the addr_unit sysfs
file in the DAMON selftests.

> diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selft=
ests/damon/sysfs.sh
> index b3418214ed358..1e10881afabb6 100755
> --- a/tools/testing/selftests/damon/sysfs.sh
> +++ b/tools/testing/selftests/damon/sysfs.sh
> @@ -365,6 +365,7 @@ test_context()
>  	ensure_dir "$context_dir" "exist"
>  	ensure_file "$context_dir/avail_operations" "exit" 400
>  	ensure_file "$context_dir/operations" "exist" 600
> +	ensure_file "$context_dir/addr_unit" "exit" 600

[Severity: Medium]
Is "exit" a typo for "exist" in this new test?

If ensure_file() expects "exist" or "not_exist" as its second argument,
passing "exit" might cause the function to return immediately without
performing any file existence or permission checks, which would silently
skip the intended test coverage.

>  	test_monitoring_attrs "$context_dir/monitoring_attrs"
>  	test_targets "$context_dir/targets"
>  	test_schemes "$context_dir/schemes"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520062858.1670=
11-1-sj@kernel.org?part=3D13
