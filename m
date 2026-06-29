Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A741C2E1
	for <damon@lists.linux.dev>; Mon, 29 Jun 2026 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744954; cv=none; b=rUOR6gxwWsJzm866Ua1+i+TldPNr27Yde6VgrPdvXvmkijbmN08d1mR7gCu0K7XFzVCY7GhTnfnOMVQA8AmN3eX4LGuS7Z7HVHGj0HmW8Spwss868fdeBxO7mWztv6M7Aezs4iA0QwxMJjylBkQVR4AsFc5NiHDBrnWqO2wU5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744954; c=relaxed/simple;
	bh=8ZWgTDJjdcP/Tb+8OP5QRGlkjG0ITnaUGgpUQvakfts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KFI9B8Y+D35QRAmfMUdnJGyRHicqtjN7mRe4QyuDraoVNG1IdFwdURtiGT9gJvGadO42LkyHb7HsgrbvGbGTeZ0v+YWjs5Gh4dpmWl7i68krv1cGtHDGAMRft6hfYBip7l16DdakfJHo5513M2g2/t/pvCymJa+18cpHHUxwqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKCRiwJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKCRiwJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275BB1F00A3A;
	Mon, 29 Jun 2026 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744953;
	bh=H3SGBHV/UV0VcilfigfESiWkq+eAzuFQ3t1oToXu3kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VKCRiwJDTAQN3ev7TRjXz9EWjRWZJtR6aTd+PEnDTLUGziU44mK/PtE7UscCFSMv7
	 E3+k1AuBSuVG7xSvJdh01rrMwFqG5fnmfUK8sMPOaOkV9u2IWY0v8sT2owYNS0tF26
	 BGA9DEP2jRa+/AnCCPGFsEGmVpye3JT2EPAnLb4HyOrWbln5lcXAL6PsTDCQYKk0VT
	 vR3YpUpwRV47qA/kijAMcQTjusWZZNsnJSPBGERtzUx7kbpXUsiumTZrNIgNLp3kfZ
	 TmWeF07B3B5UgYQ3B2skEP6e8uOrzWMhhhKGDLbMpWNWnXpFezhBba6TNtaFlOqHdw
	 DeCgb20lFHYgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] selftests/damon: prevent cross-context state
 pollution in DamonCtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260629144648.134092-2-sj@kernel.org>
References: <20260629144648.134092-1-sj@kernel.org>
 <20260629144648.134092-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:55:52 +0000
Message-Id: <20260629145553.275BB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a split-brain state corruption in `DamonCtx=
` by implementing an incomplete fix for Python mutable default arguments. W=
hile it replaces the defaults in `DamonCtx.__init__` with `None` sentinels =
and instantiates them at runtime (e.g., `monitoring_attrs =3D DamonAttrs()`=
), it misses the fact that `DamonAttrs.__init__` still uses a mutable defau=
lt (`intervals_goal=3DIntervalsGoal()`).

Because `DamonAttrs()` is now called multiple times (once per `DamonCtx`), =
multiple `DamonAttrs` instances are created, but they all silently share th=
e exact same `IntervalsGoal` instance. During `DamonAttrs.__init__`, the sh=
ared `IntervalsGoal` instance's `attrs` back-reference is overwritten to po=
int to the newest `DamonAttrs` (`self.intervals_goal.attrs =3D self`).=20

As a result, when an older `DamonCtx` calls `stage()`, its base attributes =
correctly route to its own sysfs directory, but its `intervals_goal` writes=
 route to the sysfs directory of the most recently created `DamonCtx`. This=
 is a newly introduced inconsistency, as prior to the patch, all properties=
 incorrectly routed to the same directory together. Additionally, the patch=
 leaves identical mutable default bugs untouched in `DamosFilters`, `DamosD=
ests`, `Damos`, `Kdamond`, and `Kdamonds`.
--

commit 7d9280d7450287d38ab4b080317de0093ab71119
Author: Kunwu Chan <chentao@kylinos.cn>

selftests/damon: prevent cross-context state pollution in DamonCtx

DamonCtx.__init__() uses mutable default values for monitoring_attrs, targe=
ts,
and schemes. In Python these are evaluated once at function definition time,
so multiple DamonCtx instances can unintentionally share the same lists and
DamonAttrs instance. Replace the mutable defaults with None sentinels and
initialize the objects when needed.

Link: https://lore.kernel.org/20260601032314.424013-2-kunwu.chan@linux.dev

> diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testin=
g/selftests/damon/_damon_sysfs.py
> index 8b12cc0484405..2f6f2699db256 100644
> --- a/tools/testing/selftests/damon/_damon_sysfs.py
> +++ b/tools/testing/selftests/damon/_damon_sysfs.py
> @@ -624,17 +624,23 @@ class DamonCtx:
>      pause =3D None
>      idx =3D None
> =20
> -    def __init__(self, ops=3D'paddr', monitoring_attrs=3DDamonAttrs(), t=
argets=3D[],
> -            schemes=3D[], pause=3DFalse):
> +    def __init__(self, ops=3D'paddr', monitoring_attrs=3DNone, targets=
=3DNone,
> +            schemes=3DNone, pause=3DFalse):
>          self.ops =3D ops
> +        if monitoring_attrs is None:
> +            monitoring_attrs =3D DamonAttrs()

[Severity: Medium]
Does this incomplete fix introduce a split-brain state regression?

Because DamonAttrs() is now called multiple times (once per DamonCtx),
multiple DamonAttrs instances are created. However, DamonAttrs.__init__
still uses a mutable default for intervals_goal:

tools/testing/selftests/damon/_damon_sysfs.py:DamonAttrs.__init__() {
    def __init__(self, sample_us=3D5000, aggr_us=3D100000,
                 intervals_goal=3DIntervalsGoal(), update_us=3D1000000,
...
        self.intervals_goal.attrs =3D self
}

This causes all newly created DamonCtx instances to silently share the
exact same IntervalsGoal instance. During DamonAttrs.__init__, the shared
IntervalsGoal instance's attrs back-reference is overwritten to point to
the newest DamonAttrs.

As a result, when an older DamonCtx calls stage(), its base attributes
correctly route to its own sysfs directory, but its intervals_goal writes
route to the sysfs directory of the most recently created DamonCtx.

Additionally, could there be other similar mutable default bugs left
untouched, such as in Damos.__init__:

tools/testing/selftests/damon/_damon_sysfs.py:Damos.__init__() {
    def __init__(self, action=3D'stat', access_pattern=3DDamosAccessPattern=
(),
                 quota=3DDamosQuota(), watermarks=3DDamosWatermarks(),
                 core_filters=3D[], ops_filters=3D[], filters=3D[], target_=
nid=3D0,
}

>          self.monitoring_attrs =3D monitoring_attrs
>          self.monitoring_attrs.context =3D self

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629144648.1340=
92-1-sj@kernel.org?part=3D1
