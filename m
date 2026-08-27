Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223746AA76
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839203; cv=none; b=CCbfNZpveFreyVx0Kv0SAFwnkzyGyWiRg+EyY4KERj7n1DHyqwSJ8y67J1MuAVgxgM7sxv++h/Y+5oluvLwjaFzp8UjIHCh700WbJS+iFU8Z6C175CFaH8S8MCMaDdbfAHR0b8sANCPq46PGNIS8mF6RVsteJhjLqWm6pWSO8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839203; c=relaxed/simple;
	bh=oXx1ceniuXAuLB9/kTjPEARUfboh9sCzDtqSFjUHmhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mXjYzOt45OgbXY/6Q4UQp7c74AxmEbJFk5V2OOKjMa8qSjSlrWE6H7yF9ukNdpCLsaS7ADw7KKltxU5kBsv44JEjhlQUUiVxUS6P7aDqP3ciwR4YJo++zB1/Qr8VVdnXbOdpeIpof/mOoxIA9hce71PyIsrBhByUNfiOSrkMSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB6OJsGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB6OJsGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940FB1F000E9;
	Thu, 27 Aug 2026 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787839198;
	bh=Dk2pIJfc1adDEoYZbvPD/9D80FKxQRrmBQYXQHZyG94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SB6OJsGfP4AfyfGoQhiuQXZtOv2bTxk9vF1OR0JScL8Jf4CHjYjAhhv6bFrx5/ubb
	 I3MBwDrMtmgs+Jotyp+qkTIbbjbiQPqnQSbfuL9QLlLvknPTzhw9fkFgxhhst7MVbU
	 W3dRlnxCRm8+qxDQ8I4AkekWBga4PN03tOdxzF4gfmWcsQOx7JGpYjPpodDiyCnCWn
	 rAo9JNl4+nhJgFSDOG8N5uMuiCRKp/3s2QVNsHdJRiOXOJBLnZBECeEZwafWTIWjK9
	 3ErpXrL3kP+zI2KnXuV6MS8LtEkdWHN+t4MP56vG0AuHzj7bhUuO5Du2yuRh097bX3
	 GsS08uGCtFlmg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 1/3] mm/damon/core: initialize
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260827134429.123023-2-sj@kernel.org>
References: <20260827134429.123023-1-sj@kernel.org>
 <20260827134429.123023-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:59:58 +0000
Message-Id: <20260827135958.940FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditionally resetting last_psi_total in damos_commit_quota_goa=
l_union() breaks the feedback loop measurement interval for existing goals =
during sysfs updates.
- [Medium] The patch changes the semantics of damos_commit_quota_goal() to =
explicitly overwrite last_psi_total instead of preserving it, but leaves be=
hind a KUnit test assertion that expects preservation.
--

commit 8007d7351717974f3d1ef45ed438346542307389
Author: SJ Park <sj@kernel.org>

mm/damon/core: initialize damos_quota_goal->last_psi_total

This patch initializes the last_psi_total for DAMOS_QUOTA_SOME_MEM_PSI_US
quota goals to prevent the first iteration of the feedback loop from using
an uninitialized value. It introduces initialization at the start of kdamond
and during each goal commit.

Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..723ab998b63c7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1118,10 +1118,15 @@ static struct damos_quota_goal *damos_nth_quota_g=
oal(
>  	return NULL;
>  }
> =20
> +static u64 damos_get_some_mem_psi_total(void);
> +
>  static void damos_commit_quota_goal_union(
>  		struct damos_quota_goal *dst, struct damos_quota_goal *src)
>  {
>  	switch (dst->metric) {
> +	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> +		dst->last_psi_total =3D damos_get_some_mem_psi_total();
> +		break;

[Severity: High]
Does this unconditional reset of last_psi_total truncate the measurement
window for running goals that are updated via sysfs?

When a user updates a running DAMON context via sysfs that includes an
existing DAMOS_QUOTA_SOME_MEM_PSI_US goal, this overwrites the running
goal's last_psi_total with the current time's PSI value, without resetting
the overall charged_from interval timer.=20

Could this produce an artificially small current_value, causing the feedback
loop tuner to falsely assume memory pressure is low and erroneously increase
the scheme's quota?

>  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
>  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
>  		dst->nid =3D src->nid;

[ ... ]

> @@ -1143,7 +1148,6 @@ static void damos_commit_quota_goal(
>  	dst->target_value =3D src->target_value;
>  	if (dst->metric =3D=3D DAMOS_QUOTA_USER_INPUT)
>  		dst->current_value =3D src->current_value;
> -	/* keep last_psi_total as is, since it will be updated in next cycle */
>  	damos_commit_quota_goal_union(dst, src);
>  }

[Severity: Medium]
Since the semantics of damos_commit_quota_goal() have changed to explicitly
overwrite last_psi_total rather than preserve it, should the corresponding
KUnit test be updated as well?

The existing KUnit test in mm/damon/tests/core-kunit.h
(damos_test_commit_quota_goal_for()) expects the old preservation behavior:

if (dst_last_psi_total && src->metric =3D=3D DAMOS_QUOTA_SOME_MEM_PSI_US)
	KUNIT_EXPECT_EQ(test, dst->last_psi_total, dst_last_psi_total);

Without updating this assertion, there appears to be a mismatch between the
new code behavior and what the test expects.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827134429.1230=
23-1-sj@kernel.org?part=3D1
