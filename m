Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD73351C31
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808436; cv=none; b=fZ4kYl4gsaDTcg29lzKP4kJChatwGr/k1uiAxet9OZGq/X8AGSQ93wXE4Tgj2LTZD3/qkzJ4LQHJbxLpjd9y9LQHTJh7Wuwb++C6cTD1KALdczwEO+qbD67yqwDb23oCR0HEe84e0xTx0e/AYB8aL6g3xHhIYxzQr8CgrbK48lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808436; c=relaxed/simple;
	bh=8fBA83owMJzMJyhurvvEaxERG6SYlSPS0p6unXh7zoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nq9wv4NcFBUvEyDQauzeCYnICow4p0mw1FeVF5smVx1KmSg8SoMDJEKZLN91ZX14YMzjGTiq8gxHwSFjkyC8HdCdtBxaYeyEnSlPO9DzRjPqXvBeGt6xNqkJHNZEufW3ITKijaeSgE1aq8Pe/FwYZtWDEQjXreigANb5FhSzV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+Hr2FOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+Hr2FOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D161EC2BCC6;
	Fri, 15 May 2026 01:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808435;
	bh=8fBA83owMJzMJyhurvvEaxERG6SYlSPS0p6unXh7zoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q+Hr2FOYC35ukfEf3dJHoxwDjOEGZW0tMlRg3Vnjhbjd12+be3GKrDx1ydJJOcf61
	 1T1YjWo+Pa0773hHStXvs+EoQtmer9o0HT/S3/2WaF3b/Vdi8F3mBTlpxVxCU47RE7
	 jeG1DmYUJTsvdj/ajEOMMP6PY8e0igzXXFW+tkWxRsVe8XlCKR3DesSX8S7wMtq3QH
	 Ex39OLOv+rqh52Sxhb2/tm2E0+MAXlhvsat1wZGKPq7rp1b6LlKOH5ZqQmPRnKmnum
	 VW0SWfo/OGkWzVfVcAovEiiL+GeX/xfZu6X8s2RYRye0lbNW01mnBCaaeVrRo6hr/d
	 94wB0mR0YO1Vg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 15/28] mm/damon/sysfs-schemes: implement
 tried_regions/<r>/probes/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-16-sj@kernel.org>
References: <20260515004433.128933-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:27:15 +0000
Message-Id: <20260515012715.D161EC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Use-After-Free and Double-Put of kobjects due to delayed relea=
se
- [High] Lockless list corruption in delayed kobject release
- [High] State variables (`nr_regions`, `total_bytes`) leak on error paths
- [Medium] Undefined Behavior from unvalidated pointer arithmetic on NULL
--

commit 2a0f4a006e3babc368de4c2d048d4ec6e1aec966
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: implement tried_regions/<r>/probes/

This commit adds a probes/ sysfs directory under DAMOS tried regions to
show per-region probe hit counts.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 245d63808411a..0bca89217b8fa 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]
> @@ -34,10 +61,36 @@ static struct damon_sysfs_scheme_region *damon_sysfs_=
scheme_region_alloc(
>  	sysfs_region->ar =3D region->ar;
>  	sysfs_region->nr_accesses =3D region->nr_accesses_bp / 10000;
>  	sysfs_region->age =3D region->age;
> +	sysfs_region->probes =3D NULL;
>  	INIT_LIST_HEAD(&sysfs_region->list);
>  	return sysfs_region;
>  }
> =20
> +static int damos_sysfs_region_add_dirs(
> +		struct damon_sysfs_scheme_region *region)
> +{
> +	struct damos_sysfs_probes *probes =3D damos_sysfs_probes_alloc();
> +	int err;
> +
> +	if (!probes)
> +		return -ENOMEM;
> +	err =3D kobject_init_and_add(&probes->kobj, &damos_sysfs_probes_ktype,
> +			&region->kobj, "probes");
> +	if (err) {
> +		kobject_put(&probes->kobj);
> +		return err;
> +	}
> +
> +	region->probes =3D probes;
> +	return 0;
> +}
> +
> +static void damos_sysfs_region_rm_dirs(
> +		struct damon_sysfs_scheme_region *region)
> +{
> +	kobject_put(&region->probes->kobj);

If damos_sysfs_region_add_dirs() fails, region->probes remains NULL.
If damos_sysfs_region_rm_dirs() is subsequently called on this region,
will &region->probes->kobj evaluate the address of a member of a NULL point=
er?

While this evaluates to a NULL pointer because kobj is at offset 0, is it
safe to rely on this undefined behavior, or should there be an
if (!region->probes) check?

> +}
> +
>  static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *a=
ttr,
>  		char *buf)
>  {
> @@ -165,6 +218,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
> =20
>  	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
>  		/* release function deletes it from the list */
> +		damos_sysfs_region_rm_dirs(r);
>  		kobject_put(&r->kobj);

If the kobject release is delayed (e.g. because userspace holds a sysfs file
open in the region directory, or CONFIG_DEBUG_KOBJECT_RELEASE is enabled),
the region remains on the regions_list.

If a user consecutively writes to the sysfs state file to clear regions,
damon_sysfs_scheme_regions_rm_dirs() will iterate over the same region agai=
n.

Will this call kobject_put(&region->probes->kobj) a second time on the
already-freed probes kobject, triggering a use-after-free and refcount
underflow?

Should region->probes be set to NULL after the put to avoid this?

Also, regarding the list management, this isn't a regression introduced her=
e,
but the comment mentions the release function deletes it from the list. If
kobject release runs asynchronously in a worker thread, can the release
function list_del() run concurrently while this loop iterates the list,
silently corrupting the doubly-linked list?

>  		regions->nr_regions--;
>  	}
> @@ -2932,9 +2986,14 @@ void damos_sysfs_populate_region_dir(struct damon_=
sysfs_schemes *sysfs_schemes,
>  	if (kobject_init_and_add(&region->kobj,
>  				&damon_sysfs_scheme_region_ktype,
>  				&sysfs_regions->kobj, "%d",
> -				sysfs_regions->nr_regions++)) {
> -		kobject_put(&region->kobj);
> -	}
> +				sysfs_regions->nr_regions++))
> +		goto out;
> +	if (damos_sysfs_region_add_dirs(region))
> +		goto out;
> +	return;
> +
> +out:
> +	kobject_put(&region->kobj);

Earlier in this function, sysfs_regions->total_bytes is increased, and
sysfs_regions->nr_regions is incremented.

If damos_sysfs_region_add_dirs() fails and the code jumps to the out label,
these state variables are not reverted. Since
damon_sysfs_scheme_regions_rm_dirs() only decrements nr_regions by 1 per
region in the list, do these counters permanently drift, causing accounting
issues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D15
