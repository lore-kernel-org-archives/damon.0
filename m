Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F421D5146
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926571; cv=none; b=CJpRFQDB8xcLz6kAmHA2Z+KWpZ+jrwFNZrkWLw/Ve/UWNu5qxRZUsnTe+kQHVO8xm3B5oDjwE5EZA5xd0jfXQIwgIDOvsAgfjjVVuP56cNmsC/aV5kbp7fFhVIkFysPKZcva2emftXnWLD5tjC610wwNb+W1pECvjJ7MrtcHb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926571; c=relaxed/simple;
	bh=06hFxjk1xpIDOu5CLoqQHSRH+qs7K1YxC2cx6Wjrz50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k2ly3u4DwgdZX/KHttge61/Hmqbgp2nuir3WwzUtN+W9htz15r4PHPTolWkCF+CbpZqx8aO1y+xkNtHB4jEkE4L9tWZBhhaUqMtstJNo3FGSIwlvk8r3g00yXUa2riUk2uN+VkDMUYt1NRNrZZhvR2IylVltfQcy0mGaTPaY/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZkveEZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZkveEZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243941F00A3D;
	Wed,  9 Sep 2026 04:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926569;
	bh=g7sQd2LxjsTarj090nsATHB6h2h0xIqj68MCEciEWdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZkveEZmBASZKjGG0rerFajHO6XcuBxKskXkvNSVmrRws9cBa7W00QahLtKwVi+1t
	 Py3Vuex38mm9N2ymEI2QRWTRTO8IjbReMVdyxUGjU2iUz3RYSC2BFicGxwl0c29puZ
	 WpHtpPtgWEkpcxfDIerkOX7XSK0eJrytGXqRst0v+aB7C7nxDkXKY7lTZY1qaMk3jD
	 d26qSSbVP0THojFdjJCUxNnukvT7wTvSke3Mn8MOoqWWVA4pbtSBRKwKVAOW8ftOor
	 H8XfFdKWOSHaxqoE/J93U1ZbK6qAgnc/hQKchOgUXTHG4DTWRA20qZ6JM+7kp1gLCc
	 7H32dBCSgteww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core-kunit: check region count before
 testing in split_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909035813.162131-1-sj@kernel.org>
References: <2026090820-envoy-endanger-c99b@gregkh>
 <20260909035813.162131-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:02:48 +0000
Message-Id: <20260909040249.243941F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The error-checking condition `!damon_nr_regions(t) !=3D 2` is al=
ways true due to operator precedence, causing the test to unconditionally s=
kip its core assertions.
--

commit 6fefc501724f8572d4bbc1782d2ab55fa7568e21
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: check region count before testing in split_at()

This patch updates damon_test_split_at() to verify the region count was
successfully changed before proceeding. This prevents invalid pointer
dereferences if the split fails.

Link: https://lore.kernel.org/20260718001442.87129-3-sj@kernel.org
Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]

> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index d8fef225930a5..1dd17d43a642c 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -162,6 +162,9 @@ static void damon_test_split_at(struct kunit *test)
>  	}
>  	damon_add_region(r, t);
>  	damon_split_region_at(t, r, 25);
> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> +	if (!damon_nr_regions(t) !=3D 2)
> +		goto out;

[Severity: Medium]
Will this error-checking condition unintentionally skip the core assertions
of the test?

Because of operator precedence, !damon_nr_regions(t) evaluates to either 0
or 1. Neither 0 nor 1 equals 2, meaning the inequality (!=3D 2) is always t=
rue.

This seems to force the test to unconditionally take the goto out path,=20
bypassing the boundary validations it is designed to perform.

>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909035813.1621=
31-1-sj@kernel.org?part=3D1
