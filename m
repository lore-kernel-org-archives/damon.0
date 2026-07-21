Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A740860A
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784614360; cv=none; b=O4HGN0GriPpt/4AAIbLIjED/GAOw8GlPc3d6sEsPIWMrsl5b6yKCYPdIBU8G8EqmyjYDA4ITb33mFkEzjv8kxBe+sGa4WmRZEikBcFLWSb/HDd5vkLrq4M/KMmasNExrHm1U/JbNgAR0Y/77oUviVW6ZhAca9rm8W94bRIsw6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784614360; c=relaxed/simple;
	bh=vz5djLI3sjvtDo0x5pHp6joF1Gp6u0IQBkTgo9JvEUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rLFIsFWTgBUwZHSlUzxVbe7mymFxy4W3x9qV4W0HCsXVBjQsC7ga0+nE/rkR7IPUc4e6P5jz1y89CopoO7yAdbvKqI2Bo6KmyJVjFwriRSe/qLjzggKd0khSxxF0GG269cgmTyNw59Nkj5mmRbJN4S3F9OhmHDsmzZsEzhwMXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ69hL23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ69hL23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44CA1F000E9;
	Tue, 21 Jul 2026 06:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784614354;
	bh=nMCYv2aKrBivPDwKXakOcYZ4uqGo/RdRWhJKiok/cck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XJ69hL232nqz0JAj83VMn0oeTDI0ZVJ1VkELFQDFtm+chTS9MRebAIUwpetNWD3cX
	 ywQDYGA0EciVjo7hkvVnpgsrNexzrib2AHempvCyNqaiZ3R4NwnP18cO6ZjY99OdwL
	 i6MhRhaRelmqhE6WG6+w53gSAGiVD3dlhJT9syjUImnn/qLkTl/srMmmkeLk1ndAiC
	 jJEfv2BVh8UPknBPXtnAIeQERmREUGI6n+V2O9qwrX8p2XsZNugv6AEpk9XTm7z267
	 8poNh5kShrgldEnAm0ebE7C/Bp7q8v5KFAq69V9a4nxZvuYUxKBxEJHsV2Cue3ESZP
	 ywOS5aGVifiQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selftests/damon: Add missing NULL checks after
 malloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "longlong yan" <yanlonglong@kylinos.cn>
Cc: damon@lists.linux.dev
In-Reply-To: <20260721060542.326-1-yanlonglong@kylinos.cn>
References: <20260721043139.151887-1-sj@kernel.org>
 <20260721060542.326-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 06:12:34 +0000
Message-Id: <20260721061234.B44CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced error path returns -1 to prevent an OOM cra=
sh, but this does not coordinate with the Python test harnesses to actually=
 skip the test or report a resource error. Instead, it causes tests to eith=
er silently pass (false positive) or crash with Python exceptions.
--

--- Patch [1]: [PATCH v2] selftests/damon: Add missing NULL checks after ma=
lloc() ---
commit c48bfd12db1afa969a2ab38d496264e74f1b6b1e
Author: longlong yan <yanlonglong@kylinos.cn>

selftests/damon: Add missing NULL checks after malloc()

This commit adds NULL checks after malloc() calls in access_memory.c and=20
access_memory_even.c to prevent crashes during low-memory conditions.

> diff --git a/tools/testing/selftests/damon/access_memory.c b/tools/testin=
g/selftests/damon/access_memory.c
> --- a/tools/testing/selftests/damon/access_memory.c
> +++ b/tools/testing/selftests/damon/access_memory.c
> @@ -38,8 +38,17 @@ int main(int argc, char *argv[])
>  		mode =3D ACCESS_MODE_REPEAT;
> =20
>  	regions =3D malloc(sizeof(*regions) * nr_regions);
> -	for (i =3D 0; i < nr_regions; i++)
> +	if (!regions) {
> +		fprintf(stderr, "Failed to allocate regions array\n");
> +		return -1;

[Severity: Medium]
Will returning -1 here coordinate correctly with the Python test harnesses
like damos_quota.py and sysfs_update_schemes_tried_regions_wss_estimation.p=
y?

If the Python scripts do not check the subprocess return code, an early exit
might leave data arrays empty. Depending on the script, this can either lead
to a Python IndexError (e.g., when accessing wss_collected in
pass_wss_estimation) or a silent test pass that masks the out of memory
condition entirely.

Should this return KSFT_SKIP (4) instead to properly notify the test harnes=
s,
or do the Python scripts need updating to verify the return code?

> +	}
> +	for (i =3D 0; i < nr_regions; i++) {
>  		regions[i] =3D malloc(sz_region);
> +		if (!regions[i]) {
> +			fprintf(stderr, "Failed to allocate region %d\n", i);
> +			return -1;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721060542.326-=
1-yanlonglong@kylinos.cn?part=3D1
