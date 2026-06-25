Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29A21773D
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364491; cv=none; b=ehWbqJjzkJ2EW/RgdTvYcbRB5gfY3d5p0s6HSbKVmT2dgoosHR1KhK3f5NABctwYAEfkHCD3pZgj7vE75jNazzrw7S/X+lfzEOKTs5NTvg/Zblw3CTeE95Ahk2yfi5HECPs07l0TAhJdbyPtmvtXBsBIzo9IvIzvdaTrbylE8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364491; c=relaxed/simple;
	bh=tFzqNvTN4Ce936yxgxjSztCRqpuPdWiG6S1wSbO4nfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=id6cj+z2RjUgKXIvfABrwSMA9W1Pho9NEq7dHraHd8GjBn4mfn5jad/ol3Q62kG6ZoV4i2LgO47TiDOKGAkiR91qWMYyRhEWodOsnAA4zZO89Xk4+0vRfeIKlIhaezId5hsOREUxaS46NVe2O62G9nVAYKkGCyOJUFpprVJgvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKk1svP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKk1svP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27CF1F000E9;
	Thu, 25 Jun 2026 05:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364490;
	bh=Qcep9gkEvb+dNN5zfJrPZ57zAQm+1Vw8rUmMvOROAgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lKk1svP+D+8NvwxYj8UFzEJGpiTrwQfjPNWPXqKG9/wu2JdJDjOt+3QEFgBCNjnGO
	 Lzps/6uXMZOS/rwP6vkYRtHcHlDSvM1JxCE1JdHy8N/V0dDp19HB6HuAwITVo8TTyp
	 UO0X54yCZYBS+RaXQZ8+KP6HdtyForVs0E5DOS3GDXKRkaus0CiYyHtjSSFUvtt/QG
	 R6yny9lMoNjTT3nsoQ4skh9zIPed+ThyqXXcFZnJkrKKlZ2OqW51XVbHQW3HxGAoj3
	 0uRT1dE7+Y7s2L/JTS1XavPU7n30jxkEXSI9jjTr48U44TC/kn91D4dfpwOf8+SGqu
	 ai50SgZnbgC8w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 06/11] selftests/damon/sysfs.sh: test dests dir
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260625050756.91115-7-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
 <20260625050756.91115-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 05:14:49 +0000
Message-Id: <20260625051449.E27CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `test_dests()` function is never invoked, and it=
s helper `test_dest()` omits a required argument, causing the test to be bo=
th unexercised and structurally broken.
--

commit 53579293376a979c6b9c9914d1d77ffa57418d36
Author: SeongJae Park <sj@kernel.org>

selftests/damon/sysfs.sh: test dests dir

DAMON selftest interface essential file operations test (sysfs.sh) is
not testing DAMOS dests/ directory. This commit adds a test for the
dests directory.

> diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selft=
ests/damon/sysfs.sh
> index 07a33995be852..ffa8413b5ab3d 100755
> --- a/tools/testing/selftests/damon/sysfs.sh
> +++ b/tools/testing/selftests/damon/sysfs.sh
> @@ -99,6 +99,29 @@ test_stats()
>  	done
>  }
> =20
> +test_dest()
> +{
> +	dest_dir=3D$1
> +	ensure_file "$dest_dir/id" "exist"
> +	ensure_file "$dest_dir/weight" "exist"

[Severity: Medium]
Does ensure_file() require a third argument for the expected permission?
Without it, the underlying check might evaluate the file's permission again=
st
an empty string and unconditionally fail the test.

> +}
> +
> +test_dests()
> +{

[Severity: Medium]
Is test_dests() ever invoked? It looks like this function is defined here
but remains unreferenced in the script. Should it be called from
test_scheme() to verify the directory under each scheme?

> +	dests_dir=3D$1
> +	ensure_file "$dests_dir/nr_dests" "exist" "600"
> +	ensure_write_succ "$dests_dir/nr_dests" "1" "valid input"
> +	test_dest "$dests_dir/0"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625050756.9111=
5-1-sj@kernel.org?part=3D6
