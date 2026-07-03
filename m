Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0F2BDC2F
	for <damon@lists.linux.dev>; Fri,  3 Jul 2026 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099612; cv=none; b=BhPVIcpsStvhNFlrJ0VGCeTJ9nTREnselpNubCVBBOXpmlAsPQcxLG4V4oLC2CfGZDnth4zHpHXzWFOVQCboztOTazR84AalppRFeLxPapkqIr7Ryz4Jb7bzC81Gf+cXsSl9CccVQvms7XHwzaliSWhyfFGr7Q+rHomQiNonnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099612; c=relaxed/simple;
	bh=s9kxDqs2NhOJR1xihpjCpUD7cheLe97uy36s+z0zC/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iGUE9vD+HiVlnUq9a5mbBWb/J9d0bOtcRjDNcWdoA0FdbYBWf/pHxe2CR5Z9HAaarru+r94TZKEH1RCtoQsprTSTRlfkQjRexxhFgZtMsnELmXFYr0SRYDTrQMjKH/p9ZrznMBmuyFdnDBkzfPAO/Fs+FCjt/0AIjryIwHU4yLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOa5CRm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOa5CRm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7246F1F00A3A;
	Fri,  3 Jul 2026 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783099611;
	bh=akl4/A7h26KTozg0UK2//gOzrRn/k8UWCYebfjoT6zE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DOa5CRm9nFQB8d2ZInzxLzrMGybfW18KEN7xsBgkc46f3jdia9z9wYcw6tkazgFkN
	 05LCl0n1HV+0T8fJ+g1mfwGfeB/RjDBByqIXCnrpFNd0N6friqc2mh6ZCovLy7ABnG
	 rL8y/12xUkANs2M9k/vztwD/3KCL6WuT6yZIaI4HsIznYcJs7ZCvrHFVrOoHdfIGmS
	 vCS61gTwoiQGcffHDslaOVovbBb3BwhjeX3rXmIjlEMTozqnXahJP/NrP/BWdkvfeU
	 tEqQRStVO9/kTRA9suAMTbKXN/aL8isPsvsaRi14kzaUT25EZP9argvFCydKb+J/JO
	 API1RQPqRXACQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] mm/damon/sysfs-schemes: set probe hits as pseudo
 moving sums
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260703170605.94472-4-sj@kernel.org>
References: <20260703170605.94472-1-sj@kernel.org>
 <20260703170605.94472-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 17:26:50 +0000
Message-Id: <20260703172651.7246F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing left_window_bp =3D=3D 10000 guard in damon_probe_hits_mv=
sum causes wrapped/doubled values at the aggregation interval boundary.
--

commit a039a69816e23f1f7d4a1680c2ab2713e7d81fe1
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: set probe hits as pseudo moving sums
   =20
DAMON sysfs interface exposes damon_region->probe_hits via probe hit
files.  Because the counters are completed only at the end of the
aggregation interval, users can show incomplete values if they requested
the file content update (update_schemes_tried_regions command) in the
middle of an aggregation interval.  Set the value as the pseudo moving
sum value of the counter, similar to that for nr_accesses.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index dbf2b0515d582..32f495a96b17a 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -110,7 +110,8 @@ static int damos_sysfs_probes_add_dirs(struct damos_s=
ysfs_probes *probes,
>  		struct damos_sysfs_probe *sys_probe;
>  		int err;
> =20
> -		sys_probe =3D damos_sysfs_probe_alloc(region->probe_hits[i]);
> +		sys_probe =3D damos_sysfs_probe_alloc(
> +				damon_probe_hits_mvsum(i, region, ctx));

[Severity: Medium]
Could this result in wrapped or doubled values at the aggregation interval
boundary?

Looking at damon_probe_hits_mvsum() in mm/damon/core.c, it seems to calcula=
te
the moving sum without guarding against the boundary race condition, unlike
damon_nr_accesses_mvsum():

mm/damon/core.c:damon_probe_hits_mvsum() {
    ...
    left_window_bp =3D mult_frac(left_window, 10000, window_len);

    return damon_mvsum(r->probe_hits[probe_idx],
            r->last_probe_hits[probe_idx], left_window_bp);
}

If damon_set_attrs() updates ctx->next_aggregation_sis (e.g., via a sysfs
commit command) just before kdamond_apply_schemes() executes in the same lo=
op
iteration, left_window_bp could evaluate to 10000.

If a user concurrently queues an update_schemes_tried_regions walk exactly =
at
this moment, the walk callback invokes damon_probe_hits_mvsum(). Because the
guard `if (left_window_bp =3D=3D 10000)` is missing, the function evaluates=
 to
probe_hits + last_probe_hits.

Since probe_hits retains its un-cleared values from before the attribute up=
date
(as damon_update_monitoring_result() does not clear it), does this effectiv=
ely
double the count and cause the 8-bit unsigned char to silently wrap around?

While this requires a tight race between sysfs writes (commit and
update_schemes_tried_regions), it appears structurally possible.

>  		if (!sys_probe) {
>  			damos_sysfs_probes_rm_dirs(probes);
>  			return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703170605.9447=
2-1-sj@kernel.org?part=3D3
