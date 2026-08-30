Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935172630
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788067371; cv=none; b=GbXlBW36d6Igro30igNrh9Y6HvpGLGGYvF2RpKU+BYiOmshyasdZXlndLBrBNsQiNFMrOMkG+yBsnHwNy3mrb5TBa9iC8m6FiSQlOLe9xrCGyai7rObqc1nyEfMZw6PAzrt6H7FYtP2Diq4SHNrQ/zR4TAVMJTukHJo/oxfUj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788067371; c=relaxed/simple;
	bh=QXrI9P3hym6m+k3Vt/Z2kj4pWwy5SepXkLbH4nzCjP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XYpjmq0Y2AVKPfX6/njEeWANzHoIsIaKY7CLgJ4/cTi8EXgm0LPRxt/i+JJimfI1zv3UJEcYf6PrTc1uqAGaZsjtRW11MkNmKOSPGRxGBXGTOkir7UIwKXdQDsaGiG3pHQMoLU5Aolc3msQSCLQ5ABBOeJPuu6dCUEkQ9hdbLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxwNYRWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxwNYRWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD6D1F000E9;
	Sun, 30 Aug 2026 05:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788067370;
	bh=UROU1NW0T6hDweiy6EvEQ3KwFu+EnTSJV+Wbr8YmJYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LxwNYRWuxBmqPr0wQEyzoJahRs45u/wNr23swfrKHOk1hcE1qC9C1u7tC6Kp1vXsJ
	 Dy+VwoSHJlS791/9Z+0EDqAh1+1rXPmSSAp4ElHZivBqERwW3FPEsgM6mI/E5AHzqe
	 3x8QB8xgtWRKcE4lwGcktURDgGNhpMTFDECWGKpKSvjcX7GHuCJtHW8/Ks3qJNSu7N
	 1n1gfc5McOSHRkUXMup1SRouvjkvmfY1ULh7rLxO6XE0Wc4fcwJx7bmgqqb/iV/nFl
	 LOXLke+0OFrFeWxZeTlpiStcT01Ae0GMirRDG33aL5FGA8e9ku5rSKJOrRzMgwx8bj
	 mSm4nmt58wcJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] mm/damon/sysfs: support aging_flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Iyer" <kiyer@crusoe.ai>
Cc: damon@lists.linux.dev
In-Reply-To: <20260830051407.50008-6-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
 <20260830051407.50008-6-kiyer@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 05:22:49 +0000
Message-Id: <20260830052249.CFD6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `aging_flush` field in `struct damon_sysfs_conte=
xt` is not initialized during allocation, leading to undefined default beha=
vior and a minor information leak.
--

commit d37fc04bb82ae96572d3c46e4e494980a145a1c1
Author: Krishna Iyer <kiyer@crusoe.ai>

mm/damon/sysfs: support aging_flush

This commit exposes the aging_flush monitoring context option via a new DAM=
ON
sysfs context file. It accepts boolean strings to configure the value, which
the commit message states defaults to N.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index e3858ffab4b22..c8bc9cfbe4cf5 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1403,6 +1403,7 @@ struct damon_sysfs_context {
>  	struct kobject kobj;
>  	enum damon_ops_id ops_id;
>  	unsigned long addr_unit;
> +	bool aging_flush;

[Severity: Medium]
Since this structure is allocated using kmalloc_obj() in
damon_sysfs_context_alloc(), does this leave the new aging_flush field
uninitialized?

The commit message mentions it "defaults to N", but without an explicit
initialization in damon_sysfs_context_alloc(), it appears it could inherit a
random value from the heap:

mm/damon/sysfs.c:damon_sysfs_context_alloc() {
    ...
	struct damon_sysfs_context *context =3D kmalloc_obj(*context);
    ...
	context->pause =3D false;
	return context;
}

>  	struct damon_sysfs_attrs *attrs;
>  	struct damon_sysfs_targets *targets;
>  	struct damon_sysfs_schemes *schemes;

[ ... ]

> @@ -1618,6 +1619,29 @@ static ssize_t pause_store(struct kobject *kobj, s=
truct kobj_attribute *attr,
>  	return count;
>  }
> =20
> +static ssize_t aging_flush_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_context *context =3D container_of(kobj,
> +			struct damon_sysfs_context, kobj);
> +
> +	return sysfs_emit(buf, "%c\n", context->aging_flush ? 'Y' : 'N');

[Severity: Medium]
If aging_flush is left uninitialized during allocation, could reading it he=
re
expose uninitialized kernel memory to user-space?

> +}
> +
> +static ssize_t aging_flush_store(struct kobject *kobj,

[ ... ]

> @@ -2102,6 +2130,7 @@ static int damon_sysfs_apply_inputs(struct damon_ct=
x *ctx,
>  	if (err)
>  		return err;
>  	ctx->addr_unit =3D READ_ONCE(sys_ctx->addr_unit);
> +	ctx->aging_flush =3D READ_ONCE(sys_ctx->aging_flush);

[Severity: Medium]
Could reading an uninitialized sys_ctx->aging_flush here cause unpredictable
behavior by randomly applying the uninitialized value to the core DAMON
context?

>  	/* addr_unit is respected by only DAMON_OPS_PADDR */
>  	if (ops_id =3D=3D DAMON_OPS_PADDR)
>  		ctx->min_region_sz =3D max(

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830051407.5000=
8-1-kiyer@crusoe.ai?part=3D5
