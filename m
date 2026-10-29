Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239363;
	b=G/FdV/ixTbjo/9VMpXcPp3X65WLGbjgOcd20doVoIlOAutZPoSt59N6o7m6L791AARap
	 mQ++gebYIfBo6tm11AFfiRIZJ2zqioKKSg5Rfa9TJ3ojD3JsY1aIyt0t4ytCU1suoT9iu
	 T4MypJmX6QKAHQIgYkIbTVYXS2lXKc7mvmJHj/VeWs0SMVN9MKocSOlBl9UQ8HiirLs2o
	 zsJEoTJw8e13r/zdo1gq7O6Rspz6fHNZbClfvBFC72wpYSXHtrVdZbqiBPkz3REDLSFQL
	 Udd8S9N8oWf2t7U74oGBneeufgytw3MPgDJu+VRBvJsYBPghK9NS5xnSSyfEKLD0EyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239363;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tgvWlnWFppEnT1CoCTYoqGmvjAB4fbAjntbvbb4Z4i0=;
	b=E8WwxsDLGUUp92dJf2ix85XXovs2ya4xXewP8O8O/s0G/CCLpOLWL00wyIjsCQCADKih
	 65tE3XfeQgPbUgnoXRV8yO9iSHr0O0cgKC6VB+blw2N2l77WgkinpAzdHNeZBIOHTghyn
	 slYr7f3sIHgAq1cSx9jFNEnBU6lNRW0SyuG851QWKd1WSjhKCmFs/+eTdEVMAh3r06KXx
	 z4iUsLFD5d+msB9EUlW1cu+hGSdzUYq6ubZxZG/hHY3zEbwj2VSrWZo13lP50wUfxzWVw
	 Z9+tkhvWEcRHgRM6rTkfYMtPtAvTKcgG+dwdoyeVmKBmtQOmjaWLpyTFEYm+Zm5mv/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIvSeu0T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24900606A32D
	for <damon@lists.linux.dev>; Thu, 29 Oct 2026 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIvSeu0T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9F61F031E1;
	Thu, 29 Oct 2026 02:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793239362;
	bh=tgvWlnWFppEnT1CoCTYoqGmvjAB4fbAjntbvbb4Z4i0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WIvSeu0Tvx+LeNyQgMMt4LthVOnp1EQG0LopAFXH/6DEbtlehnx8zCjdP6o8aAk+A
	 enOu/ge+RTZkAC1WA0s/bIlovpZiI3IHXhYgAxVZmuXsa7q+Ppp8QMR2lbNwTYVLRp
	 EDcWQ0AoFRJ8QXcsx9BAbKqpWFdmDc+fcOaUPdZiC08JpegemntSPM28Zzvun0WiFf
	 3SY/q+KchD973cSumOZKHjKkqwmhcZSrqOEMjnxaJFTXsFJq41ukD500jCmX1PyIAu
	 /cZQaHhaTm2c0MtVR/ZNPJpBHiuxP7ZWSrQWI8chzJbrPdhudej90PXgizxmvkILzk
	 axorqdNxkAo3w==
Message-ID: <sashiko-outbox-188628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/tests/sysfs-kunit: fix leaked pid reference in
 add_targets test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaolei Wang" <xiaoleiwangxiaolei@gmail.com>, sj@kernel.org, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, error27@gmail.com, yanquanmin1@huawei.com, wangkefeng.wang@huawei.com
Cc: damon@lists.linux.dev, linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, "Michal
 Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Vlastimil Babka" <vbabka@kernel.org>
In-Reply-To: <20261029015725.17378-1-xiaoleiwangxiaolei@gmail.com>
References: <20261029015725.17378-1-xiaoleiwangxiaolei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 02:02:41 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/damon: memory leak of ctx in damon_sysfs_test_add_targets() o=
n skip
--

commit 15e9d751202cdf7c593524fe7b4266b6f6dd0dbf
Author: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>

mm/damon/tests/sysfs-kunit: fix leaked pid reference in add_targets test

This commit fixes a struct pid reference leak in
damon_sysfs_test_add_targets() by calling damon_select_ops() to select
DAMON_OPS_VADDR on the monitoring context before adding targets, ensuring
that damon_destroy_ctx() invokes damon_va_cleanup_target() to release the
pid references. If DAMON_OPS_VADDR is not registered, the test cleans up
its allocations and skips itself.

> diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
> index 138a4b8d14e73..634387c6178b9 100644
> --- a/mm/damon/tests/sysfs-kunit.h
> +++ b/mm/damon/tests/sysfs-kunit.h
> @@ -79,6 +79,14 @@ static void damon_sysfs_test_add_targets(struct kunit =
*test)
>  		kunit_skip(test, "ctx alloc fail");
>  	}
> =20
> +	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
> +		kfree(sysfs_targets->targets_arr);
> +		kfree(sysfs_targets);
> +		kfree(sysfs_target->regions);
> +		kfree(sysfs_target);
> +		kunit_skip(test, "vaddr ops not registered");
> +	}

[Severity: Medium]
Does this error path leak ctx when damon_select_ops() fails (for example,
when CONFIG_DAMON_VADDR is disabled)?

Earlier in damon_sysfs_test_add_targets(), ctx is allocated via
damon_new_ctx():

	ctx =3D damon_new_ctx();
	if (!ctx) {
		kfree(sysfs_targets->targets_arr);
		kfree(sysfs_targets);
		kfree(sysfs_target->regions);
		kfree(sysfs_target);
		kunit_skip(test, "ctx alloc fail");
	}

When damon_select_ops(ctx, DAMON_OPS_VADDR) returns a non-zero error,
kunit_skip() aborts the test immediately without calling
damon_destroy_ctx(ctx). Should damon_destroy_ctx(ctx) be called before
kunit_skip() here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029015725.1737=
8-1-xiaoleiwangxiaolei@gmail.com?part=3D1
