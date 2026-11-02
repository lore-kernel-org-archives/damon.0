Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630883;
	b=Fl84aE6UOPdfK33rsPIaD3aOW+lzoI4tkZ66thNjuozOTrRhsgsBfWTPZ1CKerrEaRNV
	 /xILiQxq5xDxOOabvfYEwXFKOJj1XWCQp2tb/PTkDUqz4AwM8Zv076lEkvGn+MRqhAS5Q
	 CuyzAGiW69BSwf2DRdniahQAwpGejzDaUpyDluWg1YiOW/QhQ+2E0WwACv725pGdjf7R7
	 8V9ULJZXozdLEc3FFTDa59mrxCN3pYXEkjCZYHvjzoH2UPBs5noQ5zT3HX5O47Rx2BJsS
	 WLXFnLjerWY9AFetCd1ro72pspP+JYF2R/3hLFsxQQhHnzDe4mqRXbwMEUDsEMaLfAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G9lp6lp7aRrqvLo599muNL3XhA3hEQTZDj7UELlaV4g=;
	b=uhaD5VLpoDLjIMMHhy4o5fyvuOWVYAwjPftUIf1VVRcJUm07+yvWliIa5MSAafZ9vHDS
	 ApQn0hs2GH6x/5ljca0IjuH5V4BObHr6NGYXZuiisCmG/XjsvfJ61WSOAhZl9vpJQA//Q
	 rapju7z1H9ea+nx7GLi69mGZfe7+uxmzgj2dcPnG+LDadsgFsD+u3WLQv8BOwagNsLGuJ
	 omTvFdhXtT1loGyDbYVXapt46N8i4NBM2KSlHk8F5Hgxw87vicks59td+D7Vsts+01mY0
	 2qd+0oQ2xKz/UWfqkM8xcvSQuLGjWULtEJ4J5Odd/brm8sRa/r0SlrsN6hxkQQGlPyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPWYLPJT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAC606AB95
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPWYLPJT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6F51F00A1B;
	Mon,  2 Nov 2026 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630882;
	bh=G9lp6lp7aRrqvLo599muNL3XhA3hEQTZDj7UELlaV4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iPWYLPJTUPmM8iPGkizYCM5D/YgrWC83B96bCFD+yqfp1ihjZ4mAi/M26rRa0tdWo
	 egdJnaUVEEcADBLnBSax+isS3vFSgmaXVTB/gtBofnYQBPKLy0mAKfr/61KRp7QkmC
	 yNcyFvTgMij7F/nvQFzeon7ombYPOtta38sZ9871o/eYZoBDGHGXaGuQnYwvtzDHmc
	 3ysM36WAFVSQA8VDAhWkHuhAwaIemYZv99ITgo52v7MTcKfWvaAIMFKMC7B33P4S+X
	 2gdq87UjVWKULV1VGq4yutrxdDUfiJ0XuMDBVG60BFAqXh1TNpobELfVolZyd4++JH
	 kahP1CW8kWdDw==
Message-ID: <sashiko-outbox-193602@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes-unstable 3/3]
 selftests/damon/sysfs_memcg_path_leak: define ksft_skip
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102144627.88843-4-sj@kernel.org>
References: <20261102144627.88843-1-sj@kernel.org>
 <20261102144627.88843-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:48:02 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> sysfs_memcg_path_leak test uses $ksft_skip without defining it.  As a
> result, the test is marked as passed while it was skipped, like below.
>=20
>     $ ./sysfs_memcg_path_leak.sh
>     Run as root
>     $ echo $?
>     0
>=20
> Users who run the test could therefore wrongly believe the test was run
> and passed while it was skipped.
>=20
> Define the value at the beginning of the test.  After this patch, the
> exit code reflects the skip.
>=20
>     $ ./sysfs_memcg_path_leak.sh
>     Run as root
>     $ echo $?
>     4
>=20
> Fixes: dfa3cf0bc018 ("selftets/damon: add a test for memcg_path leak")
> Cc: <stable@vger.kernel.org> # 6.17.x
> Closes: https://sashiko.dev/#/bug/linux-a0456336-0608-4fec-ac22-0ee61d1d6=
a91
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Tested-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102144627.8884=
3-1-sj@kernel.org?part=3D3

