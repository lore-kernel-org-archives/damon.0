Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71254A2A4E
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200531; cv=none; b=oW0sU1fIxjouxS5bim56JsOiWFmE5DF3lPCnZpFewUKFPR0kmJDDne/QisFQSgIW07r73J7q5X8zId50MlgfGa4FS7FBFnsMrhQwokSFGRsXzMBDUYeWHwlq1PTskLXTwuPuxwESRzU8T/YwCqZjMolbTngQ88QAG8Fy2l/M624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200531; c=relaxed/simple;
	bh=D6bVJ+D3Q5XPi3bC+RPAQyA7WWXk0ilUHM8xU378YqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kq5l/YViwfqibKYtNp/GWl1ZHb+QiWHhn9h9WqFBrnoEj/RACHtbEuDvukPDHac0aBuib/gtUaZablU4jDyD7UWS4GLRoDkQz6qONK0W+lnoh7opi92bmDKxCH0zTcJXoOJcLiulV4zoHQ9CCgDOq2hJuGVyqILx0qKXlHGzTOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juU2PyBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juU2PyBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6568A1F00A3D;
	Mon, 31 Aug 2026 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200529;
	bh=KTBtQn3iWJpybcPqXzkOL2Y3KBYpNwMhI7veKrR40e8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=juU2PyBbRDNQiHL4G5DbUvuBnYUZWV85DVoAC6FLHSrcGibqB5wasM+LKt1OXmODL
	 aygiho7ECvD08jRIJit58WfT+5G+wRgU2AubdNkmy3qi4kUavsHKUdHi8IjnwpYH5C
	 19IomC8EbgOQ6xz33LEkM0T9lacI31ktoAPRdr06DQKYmWM11LOth1hqaskkc68P7i
	 PXH4KHdcgM446l5q0uYTxIQzmAL15fR0FcJ4ZsbKBH5v8K0+HsLo+iRd5yo5BR2tyZ
	 RrmZC0TznXT1PDCXVqWDgui+59YQ10Q1WPyZ9hH4kOgzRj2gM6cqnIScy4KLbWvwgf
	 oWcma0X0hs/FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] mm/damon/sysfs: support hugepage_mem_bp quota
 goal metric
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831144732.80910-3-sj@kernel.org>
References: <20260831144732.80910-1-sj@kernel.org>
 <20260831144732.80910-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:22:08 +0000
Message-Id: <20260831182209.6568A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new `hugepage_mem_bp` metric is missing from the sysfs selft=
ests.
--

commit a2c5ad81dadcc820e74efd9d73c1f576bbe76457
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon/sysfs: support hugepage_mem_bp quota goal metric

This commit introduces the new DAMOS_QUOTA_HUGEPAGE_MEM_BP autotune policy
metric. It also exposes this metric to userspace through the sysfs-schemes
interface by adding "hugepage_mem_bp" to the list of recognized metrics.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 32f495a96b17a..d9b81d7b5910e 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -1269,6 +1269,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_q=
goal_metric_names[] =3D {
>  		.metric =3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>  		.name =3D "node_eligible_mem_bp",
>  	},
> +	{
> +		.metric =3D DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> +		.name =3D "hugepage_mem_bp",
> +	},

[Severity: Medium]
Should the new hugepage_mem_bp metric be added to the DAMON sysfs kselftest?

Looking at tools/testing/selftests/damon/sysfs.sh in test_goal(), it explic=
itly
validates all supported metric strings by writing them to the sysfs node:

    ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
    ensure_write_fail "$fpath" "foo" "invalid input"

Without adding hugepage_mem_bp to this selftest script, the new sysfs metric
is left without automated test coverage.

>  };
> =20
>  static ssize_t target_metric_show(struct kobject *kobj,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144732.8091=
0-1-sj@kernel.org?part=3D2
