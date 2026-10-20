Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504847;
	b=T4YQoofiesQbqfI93wkQI3dgbuWjX2MNmMpI0vb8u3dy7Nu4mfR+BGBfgchiDEuSx3Wi
	 oRoV1BezTTyKY4Xkdf0hA1TPBVhTj7ZM+dLONbHrmMs9H1x5Db3qyYTi9yQI5hYei9rAi
	 KuITt5C73LdcChoh89R3eXoN+R0MB+zaIkbFpzDHSqV4u0BJHHfGBl/YV/FsPlUEXpx1V
	 fuRNUgrrsl8WefYJSY8Ovpc4q+zcbsJnciyE5FirCwEUPJTQuwRvekFxHk2bsQNhtYZLc
	 Oe2NbUWlpxC86z9+cLRKMGZl5S7YviRpiphJ0tYvcDQQJjp8kLhcD9D4Z3cmcdjvi/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504847;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BSlLg91psftAobeV8gdQkEiFF6hG5zNghfZl0ld8xE4=;
	b=hoW71iyiwjaC1zfTAMHg9TRTjJS/SPndBuW/mrnp7UYKz4pCyrHWfbMHj/lLJPnOoaJR
	 3muc7nKrbKTl3gB4YTutP2cEiXEuoPH9DrpUhqzMJfbaqQbn3aXi1P1/AVs7yPmfCA0S3
	 JYBI7ZrTtHXWz/tNXT4bGAs1q1BuNuresHIxhcQXuAtamWbnc4Q8V8Eg94g9ti1surIQP
	 wCGoCijVuHFfI/TJu3faNbaZjsTtd0N1j8uZIFOiPqC8+xeirmWfXsZQVO2BqL6KzAhJh
	 WbGo0EfjWAPiK51vzri/iETv5LXXJxqvaRqRgixsdEA1dxRuC4uHJ4J0ZuSIAFLViEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2geFVwp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2360A261F
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2geFVwp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD991F000CA;
	Tue, 20 Oct 2026 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792504846;
	bh=BSlLg91psftAobeV8gdQkEiFF6hG5zNghfZl0ld8xE4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=I2geFVwpdSRal6bhErvcT89tNx5RPlTBPnxPEWTRgZ1PCP6+4uvuCtwpstdekNojV
	 Uz60j6IcEaWMy5hor8cADcWBlmm2HevTpR/F/CP7EdPh75z6P08NVOJXt39AI0yGdi
	 OOwWB9+n1GmRItRBa0g34ad9/F77U4B1knotKvN8atrOpU+yXC+L8mRI4VJE401sMm
	 km8oS2uDT2kaatV1fMmhgkYphsvkfViyySdMg1bYmPu86j4kWtoMc3h4JjTuAF/47q
	 rqeEXkLLEwgubHrTX2XaGNxhwE1KWbkwYQeojkSy4M72Rzb9PUE7iuPEUmtM5LQQcO
	 7RnURKDYcyqhw==
Message-ID: <sashiko-outbox-179075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/reclaim: allow disabling watermarks to
 force reclaim of cold pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, sj@kernel.org, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261020133233.3920818-1-ruanjinjie@huawei.com>
References: <20261020133233.3920818-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:00:45 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] mm/damon/reclaim: missing kernel-parameters.txt entry for ignore_wm=
arks
- [Low] mm/damon/reclaim: inaccurate ignore_wmarks parameter apply document=
ation
--

commit 8e407c81e469d1e743666b3331a460c372ffea07
Author: Jinjie Ruan <ruanjinjie@huawei.com>

mm/damon/reclaim: allow disabling watermarks to force reclaim of cold pages

This commit adds the ignore_wmarks module parameter to DAMON_RECLAIM so
that the scheme can use DAMOS_WMARK_NONE and reclaim cold pages even when
free memory is plentiful.

> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentati=
on/admin-guide/mm/damon/reclaim.rst
> index ec7e3e32b4ac6..ef57f60a91059 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -159,6 +159,23 @@ this auto-tuning feature.
> =20
>  Disabled by default.
> =20
> +ignore_wmarks
> +-------------
> +
> +Ignore the watermarks-based scheme activation condition.
> +
> +If set to ``Y``, DAMON_RECLAIM runs its scheme regardless of the system's
> +free memory rate, so the reclaim is bounded only by ``min_age`` and the
> +quota.  This is useful when cold pages should be reclaimed even while the
> +system still has free memory, e.g. to squeeze the cold anonymous pages o=
f a
> +just-parked virtual machine out immediately.
> +
> +By default, ``N``, so the scheme is activated based on the system's free
> +memory rate, as described for the watermarks below.
> +
> +Changes take effect when the scheme is rebuilt, i.e. on the next ``enabl=
ed``
> +``0 -> 1`` transition, like the other DAMON_RECLAIM parameters.

[Severity: Low]
Is this description of when changes take effect accurate?

In mm/damon/reclaim.c, ignore_wmarks is applied in
damon_reclaim_apply_parameters() and committed via damon_commit_ctx().
Because damon_reclaim_commit_inputs_store() invokes
damon_reclaim_commit_inputs_fn() -> damon_reclaim_apply_parameters():

    static int damon_reclaim_commit_inputs_fn(void *arg)
    {
        return damon_reclaim_apply_parameters();
    }

writing Y to commit_inputs also applies ignore_wmarks changes online while
DAMON_RECLAIM is already running, without requiring an enabled 0 -> 1
transition.

Could the documentation note that changes can also be applied online via
commit_inputs?

>  wmarks_interval
>  ---------------
> =20
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 014b0779ea6dd..effd963f3c783 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -112,6 +112,23 @@ static struct damos_watermarks damon_reclaim_wmarks =
=3D {
>  };
>  DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_reclaim_wmarks);
> =20
> +/*
> + * Ignore the watermarks-based scheme activation condition.
> + *
> + * With the default ``N``, DAMON_RECLAIM runs its scheme only while the
> + * system's free memory rate is inside [wmarks_low, wmarks_mid].
> + * Reclaiming cold pages itself raises the free rate, so the scheme
> + * deactivates as soon as memory looks plentiful again.  For a VMM parki=
ng
> + * an idle sandbox, cold anonymous pages should be reclaimed immediately
> + * even while the host still has plenty of free memory; setting this ``Y=
``
> + * makes the scheme ignore the watermarks, so the reclaim is bounded only
> + * by min_age and the quota.
> + */
> +static bool ignore_wmarks __read_mostly;
> +module_param(ignore_wmarks, bool, 0600);
> +MODULE_PARM_DESC(ignore_wmarks,
> +	"Ignore watermarks: reclaim cold pages even while free memory is plenti=
ful (default: false)");

[Severity: Low]
Since mm/damon/reclaim.c defines MODULE_PARAM_PREFIX as "damon_reclaim.",
registering ignore_wmarks via module_param() exposes
damon_reclaim.ignore_wmarks as a kernel command-line parameter at boot.

Should this patch also document damon_reclaim.ignore_wmarks in
Documentation/admin-guide/kernel-parameters.txt?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020133233.3920=
818-1-ruanjinjie@huawei.com?part=3D1
