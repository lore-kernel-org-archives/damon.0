Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101D32FA18
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323860; cv=none; b=IwGLuKFxpIYoAxszFHN0OBVrOcg6D1jxE/LVH2M1cKAJ+/LlxqIWBOhAWuiPs2BzfDzaE8/ZcpegNHBwPcZ3SnpRQTUs9uJuhTbh9vFgA/CFwy8njfdPuXHl8BE2C94VKU6BJQid2EqRjjvKeka8kvZW553KNuy2/oTufFPrstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323860; c=relaxed/simple;
	bh=hWWwvcynBlErxar2E8A2HKm6qByP4OkicAoCJvPe20c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dUfxUYL73ra4SiQWl6mNREe7EWgCjBMgJSmEcT1T0TVuxYFbb5y9Ij+hO+RLPv8zHn0IwDXkQiHvCuUqEf7/WzUbnDYfqnxB24kPiCJW7DN/WGgRs2e7X49hf2jjqtjSS+16SNauKJsbiU+mIXnEXAFM3Z1KnQ/Npy4C8cC7WQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLAvp/ag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLAvp/ag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AEDC2BCB6;
	Mon, 27 Apr 2026 21:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323860;
	bh=hWWwvcynBlErxar2E8A2HKm6qByP4OkicAoCJvPe20c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SLAvp/agi+93aYuvyPWaxkbKGXI9MO9xKLewTd/GVbfMGBma/G5aCcxSM9G1Hm0sI
	 uVzMCu4OXCsZCHSJW3GhnnBvutEQXwicVSaZ2IebaEKQmfWjOosazgBvY7N/ZkjcMk
	 O3BTq108Yg++H6JcHEiEAncvIt4B94roXWLZZOf3XK7dR/Al3YCzKqzgawVrNQRRbH
	 Tfp1doxZYRLjdDW8VDqVciocfS544VGkiMbdi2u86ddpN/95deVZdiwp3HjcmTxSqY
	 UL8YmDYA56vUiwerBsxrDvpnrWMQl+hdnaFq1IFa/IH1xPIcjGLonhRE5ZVHeNiI9b
	 NJRr/HpDfdHZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] selftests/damon/sysfs.py: pause DAMON before
 dumping status
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260427151231.113429-11-sj@kernel.org>
References: <20260427151231.113429-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 21:04:19 +0000
Message-Id: <20260427210420.12AEDC2BCB6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Medium] Mutating the state before assertion bypasses the verification of=
 the original `pause` state.
--

commit 2c32bc147a1cb335e85629e00bb0efe1bbb44638
Author: SeongJae Park <sj@kernel.org>

selftests/damon/sysfs.py: pause DAMON before dumping status

This commit updates the DAMON sysfs selftest to pause DAMON execution
during state dumping. It attempts to prevent race conditions where DAMON
could add or remove regions while the dump is ongoing.

> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selft=
ests/damon/sysfs.py
> index e6d34ba05893..b8d6e0f8fd90 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -193,18 +193,55 @@ def assert_ctx_committed(ctx, dump):
>      assert_true(dump['pause'] =3D=3D ctx.pause, 'pause', dump)
> =20
>  def assert_ctxs_committed(kdamonds):
> +    ctxs_paused_for_dump =3D []
> +    kdamonds_paused_for_dump =3D []
> +    # pause for safe state dumping
> +    for kd in kdamonds.kdamonds:
> +        for ctx in kd.contexts:
> +            if ctx.pause is False:
> +                ctx.pause =3D True
> +                ctxs_paused_for_dump.append(ctx)
> +                if not kd in kdamonds_paused_for_dump:
> +                    kdamonds_paused_for_dump.append(kd)
> +        if kd in kdamonds_paused_for_dump:
> +            err =3D kd.commit()

[ ... ]

> +    # restore for comparison
> +    for ctx in ctxs_paused_for_dump:
> +        ctx.pause =3D True
> +
>      ctxs =3D kdamonds.kdamonds[0].contexts
>      dump =3D status['contexts']
>      assert_true(len(ctxs) =3D=3D len(dump), 'ctxs length', dump)
>      for idx, ctx in enumerate(ctxs):
>          assert_ctx_committed(ctx, dump[idx])

Does this bypass the verification of the original pause state?

By temporarily pausing the DAMON context and committing this new state
before dumping the sysfs status, the test overwrites the actual pause state
in the kernel. Then, setting the Python object's ctx.pause to True for
comparison means the test always compares True against True for the pause
parameter.

Because of this, the test seems fundamentally incapable of verifying
whether a pause =3D False configuration was ever correctly committed to the
kernel prior to calling assert_ctxs_committed().

> +    # restore for the caller
> +    for kd in kdamonds.kdamonds:
> +        for ctx in kd.contexts:
> +            if ctx in ctxs_paused_for_dump:
> +                ctx.pause =3D False

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427151231.1134=
29-1-sj@kernel.org?part=3D10
