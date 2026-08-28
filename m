Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4A2DECCC
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882196; cv=none; b=ZkjLc3OcWhaKCV14y6RvjDyBFxT+A3qy9Exjwju3BGDY0FKEXgJzepHL2H3RAJH93UZ8Ro1FuyN079NFYXSZ+Ge6heuZ3Gj2DEU3rihvUL3jv0s02aZYZziRw0iHUpIRu00ITqI7LoCf5JK9wmNZpi3D8rOwUB0fgYETtI9sbYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882196; c=relaxed/simple;
	bh=xU3uIeC/amzpdbJ6+aptgnhyZqa1TAkxzupiEj4iE2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KiBvpIS5kfF2LSrPtDmYbSJpdduGh9rAbaQDOn3J/7YEn45suYcOWtTebjIM2iH+LfdYI3nPV83I//dtj5fM0z2FSf6GGJDdMmMLsJuT8X2vuhi6ljG9Wh5Deg69HyTEycMDHkLGVaVircjhiBai7DWexLVF8NbJoDwXCwpfnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtqChbgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtqChbgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2181F000E9;
	Fri, 28 Aug 2026 01:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787882195;
	bh=dn+Rk7y3uUzHD4u+UHfxq2mzKVSmwTmSovfl+dV1ViE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtqChbgCvybmoj8WCPB58r6yrWrsaAe/WGg8mhWAb9/xt9L4hIplVY/blOxnVfH8S
	 2enKQqSHxwUCcNpnudhdIspbICz4Z+Ug1+2Gr+Il+q+t7f5hcfKweg4rYLZOV5z2DL
	 LAtrfduo/iVKJZSoLvqESTQD4/Fec3OqVg5Oniw2W84YUqFAikUfp4b0A8mx6bXEgV
	 Zz79UBC3AnPWUFJXKR9M6H6cTr3c2DdCuBRYQKrUtyJSkOtAR8Z2ggSb7fjkjph9vW
	 dtu+9PwZZEbZ/d+yxCbPT2+AXNH5jLqXiTV5RdQn66xVjeMREi2OvVthFbWBEG0g3A
	 IrECYYck+hIqg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 3/4] mm/damon/core: copy nid for
 eligible_mem_bp damos quota goal commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260828014659.121058-4-sj@kernel.org>
References: <20260828014659.121058-1-sj@kernel.org>
 <20260828014659.121058-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 01:56:34 +0000
Message-Id: <20260828015635.1B2181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The KUnit tests in `mm/damon/tests/core-kunit.h` were not update=
d to verify the bug fix for the `DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP` metric.
--

commit 2e3746fc6a44e14dd4bda23054c960b1e043e013
Author: SJ Park <sj@kernel.org>

mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit

damos_commit_quota_goal_union() does not update the nid union field when the
goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP. This commit adds the
missing update to ensure it does not use a garbage nid value.

Link: https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b0c8e22ab5404..086d2ac57259f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1136,6 +1136,9 @@ static void damos_commit_quota_goal_union(
>  		dst->nid =3D src->nid;
>  		dst->memcg_id =3D src->memcg_id;
>  		break;
> +	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> +		dst->nid =3D src->nid;
> +		break;

[Severity: Medium]
Since this case was added here, do we also need to update the corresponding
KUnit tests in mm/damon/tests/core-kunit.h?

Currently, damos_test_commit_quota_goal_for() is missing the case for
DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:

mm/damon/tests/core-kunit.h:damos_test_commit_quota_goal_for() {
    ...
	switch (dst->metric) {
	case DAMOS_QUOTA_SOME_MEM_PSI_US:
		KUNIT_EXPECT_EQ(test, dst->last_psi_total, U64_MAX);
		break;
	case DAMOS_QUOTA_NODE_MEM_USED_BP:
	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
		break;
	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
		break;
	default:
		break;
	}
}

Should a test case for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP also be added
to damos_test_commit_quota_goal() to ensure the fix is validated?

>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828014659.1210=
58-1-sj@kernel.org?part=3D3
