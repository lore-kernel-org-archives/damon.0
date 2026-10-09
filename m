Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9D4E2F21
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554711; cv=none; b=Yr8cfWwqlna5aqJQrKVqSA5ZFjkoBpff0j4OGjq7p38Bgedq9ws1wOpHD/UnroMxAzj7spJ656zxmPXyDtWVR1qXvw8JNUIrSgLSHUm5E7TF/d/rWByvDWrsGBhBPYuiil7jcZ/y9N7e8i56gy30t8ORLQ2iA6xXsg2zHjf21b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554711; c=relaxed/simple;
	bh=wARfyymS6XawyM18dCR9tD5UkP1MPiTg4PdQe0rqPVM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pMYOiVfHWBnXqIwg0EhmsCmZyqIOm2leNwzM5OO2kRuTMttKDm492+MhhIwQooFDRn5CJ0XfCoJFCDfv9FI3mGEEMGR2YJ0CBsjCVNCoVpqdk8hWF2ocCrQtAWn9zem3yqlG9LU0aHQqs7zVuAwCCgbSlbeieEaaP5Y4gQbu29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDTmhTE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDTmhTE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56911F000FF;
	Fri,  9 Oct 2026 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554709;
	bh=NO2QHDao0AjdcNAmG+epnxrYbRxd9UupOF4RoVIcrYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDTmhTE7JcFIW3v8kzXa5VOVmH7f3lsT8f0Wlax9ptw2YU3IFLZVfm+m2nOFRhLar
	 MnbNqfE8lN3uSJtYb50SLtt09BdsNkslGBPQ1Ag+BFSVa1bq8maaijkYiWu/4mSo5a
	 z4NFVj3CNy0zPuwjSmuwHanX4oaFBBhxGb8iu4pH2OvxQ9ZsFmFmUBRDjiqJznHEnh
	 3e2M8qus00Dpm80WQDQOkPtjgW/GP9D8XuK4kdzZHkfSswZ0PzWlshjajti4uTfDaA
	 eVbLeCrx+33cKj6WgBbISBcDbKfGJjqjNIUd/+xLq/8k3vQJtDtLRubrfiJFd487JQ
	 ZpryPEDlmg1mQ==
Message-ID: <sashiko-outbox-165687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y v3 2/2] mm/damon/core: fix unconditionally skip
 last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261009134949.11507-3-sj@kernel.org>
References: <2026092948-moonrise-persecute-3597@gregkh>
 <20261009134949.11507-1-sj@kernel.org>
 <20261009134949.11507-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:05:09 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm/damon: dangling charge_target_from stalls schemes on target del=
etion
- [High] mm/damon: missing charge_target_from reset when target has no regi=
ons
--

commit 34b3a9a3bd49604e23a1fa56349694c2bc0db52b
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

This commit modifies the quota charge skipping logic to only reset
charge_target_from and charge_addr_from when the last region is actually
reached. It addresses a minor issue where the last region of a tracked targ=
et
could be unconditionally skipped and reset even when it had not been proces=
sed
yet.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c86cac855b9b0..c459eae4bbaeb 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -884,36 +884,39 @@ static bool damos_skip_charged_region(struct damon_=
target *t,
>  {
>  	struct damos_quota *quota =3D &s->quota;
>  	unsigned long sz_to_skip;
> +	bool skip =3D false;
> =20
>  	/* Skip previously charged regions */
>  	if (quota->charge_target_from) {
>  		if (t !=3D quota->charge_target_from)
>  			return true;

[Severity: High]
Does this logic stall the scheme indefinitely if charge_target_from points =
to a
destroyed target?

If a target is removed during a sysfs commit, damon_sysfs_set_targets()
dynamically destroys it:

mm/damon/sysfs.c:damon_sysfs_set_targets() {
[ ... ]
		} else {
			if (damon_target_has_pid(ctx))
				put_pid(t->pid);
			damon_destroy_target(t);
		}
[ ... ]
}

However, damon_sysfs_set_schemes() merely updates existing schemes in-place=
 and
fails to clear the quota->charge_target_from pointer if it points to the de=
leted
target.

Because this saved target was deleted and removed from the active target li=
st,
would this condition evaluate to true for all remaining targets, permanently
skipping all regions and never reaching the logic to clear the dangling poi=
nter?

[Severity: High]
Does this also cause a stall if a target loses all of its regions?

If quota->charge_target_from points to a target that loses all its regions =
(for
example, if all VMAs are unmapped and the task dies), damon_for_each_region=
()
will execute zero times for that target:

mm/damon/core.c:kdamond_apply_schemes() {
[ ... ]
	damon_for_each_target(t, c) {
		damon_for_each_region(r, t)
			damon_do_apply_schemes(c, t, r);
	}
[ ... ]
}

Would this bypass the invocation of damos_skip_charged_region() entirely fo=
r the
charged target, preventing charge_target_from from being cleared, and causi=
ng
all subsequent targets to be skipped indefinitely because they do not match=
 the
uncleared charge_target_from pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134949.1150=
7-1-sj@kernel.org?part=3D2
