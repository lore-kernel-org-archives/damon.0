Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9693D23183B
	for <damon@lists.linux.dev>; Sat, 18 Apr 2026 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776491657; cv=none; b=jewjpehmGFy1ofxkBgvFDSQ+Gth7wTEFQLVuC77cijqbZzGa6I4rZUqlAHEB+Bmen633XHgnC+A2AhpOegkCHIKRI81z2abgkRMrxSWqgzphKghuQNwd1SncsTMrtjwMRh/0lSFrCyigxyFOG8xD6lToqORaekt5p4d0gxAu5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776491657; c=relaxed/simple;
	bh=o56ZBDFDXhXWLoxG7wvLElaBW7F0/EoBAJdytdQiDtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i6ymJ42mwqsS75ELbhCx4BoqvciyZawn2qjggeUnirBkpEdmLLM+CVAUxO4Ta2PE5tWv8uF46VbFo+6kqaTR/txxSeERJ2hsAZ3OUWsHvEdniVhEghxYNj5gcykOjyXS0Nyaul3a+TLsK+iI5VlCYRazWv6EY/9Xmx0MzMgGSDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbojrf8L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbojrf8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1399AC19424;
	Sat, 18 Apr 2026 05:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776491657;
	bh=o56ZBDFDXhXWLoxG7wvLElaBW7F0/EoBAJdytdQiDtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dbojrf8LiusXGThVNwGJVRv5vDISKTxFiDlznQNM5zztj8ZHokW6kiSm1STAVz7WA
	 rgEAriXVHu53exGHET96OcGPAV0unvpWmHCe4l4Xn5FIcnwkfsnCZgzR8E7CWcSIeU
	 sc3FEc1/83Ex0+zeiN4hfBAF9JXfY1UO1Bd/eRipfSdIGCHVVd4S3ySJDJ1J5bMswI
	 so/kipCyC6fogciK/ZbyZm0rDrPbIgWIt5mtJ/DCHHsl30gD8EEXQXih3CWNEBVsHJ
	 7fbjRCx1cbuDL2Ow7nQu5Gd7ssSG40Z7D5MH6e1K6HQ8+DWmou4jUvHu8+M0BaQizm
	 bNWopP5wWL3qw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/3] mm/damon/stat: detect and use fresh enabled
 value
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260418014439.6353-4-sj@kernel.org>
References: <20260418014439.6353-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 05:54:16 +0000
Message-Id: <20260418055417.1399AC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Medium] Leaking damon_stat_context when explicitly disabling DAMON_STAT =
after an unexpected kdamond termination.
--

commit 4bf999258ec2f00a1ac02dbd77ac9f923e38bd2f
Author: SeongJae Park <sj@kernel.org>

mm/damon/stat: detect and use fresh enabled value

This commit modifies DAMON_STAT to dynamically check the kdamond status
when the enabled parameter is requested, rather than relying on a cached
parameter value. This ensures users do not see stale values if kdamond
stops unexpectedly.

> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index 99ba346f9e325..3951b762cbddf 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
[ ... ]
> @@ -273,17 +276,23 @@ static void damon_stat_stop(void)
>  	damon_stat_context =3D NULL;
>  }
> =20
> +static bool damon_stat_enabled(void)
> +{
> +	if (!damon_stat_context)
> +		return false;
> +	return damon_is_running(damon_stat_context);
> +}
> +
>  static int damon_stat_enabled_store(
>  		const char *val, const struct kernel_param *kp)
>  {
> -	bool is_enabled =3D enabled;
>  	int err;
> =20
>  	err =3D kstrtobool(val, &enabled);
>  	if (err)
>  		return err;
> =20
> -	if (is_enabled =3D=3D enabled)
> +	if (damon_stat_enabled() =3D=3D enabled)
>  		return 0;

Could this leak damon_stat_context if the kdamond thread stops unexpectedly?

If kdamond terminates due to an internal failure,
damon_is_running(damon_stat_context) returns false, making
damon_stat_enabled() also return false.

If a user then explicitly disables DAMON_STAT by writing 'N' to the enabled
parameter, both damon_stat_enabled() and enabled would be false. This causes
the function to return 0 early, bypassing the call to damon_stat_stop().

Since damon_stat_stop() is the function responsible for invoking
damon_destroy_ctx() and setting damon_stat_context to NULL, does this bypass
leave the context structure allocated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418014439.6353=
-1-sj@kernel.org?part=3D3
