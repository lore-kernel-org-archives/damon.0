Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AE2D9797
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341626; cv=none; b=rAd+FEFgmbyr+Vln1BQt4bbNpu2eeItIg9tWJv3N1j0K8469GGFCw1EuqDnBxAwtobm9n1DSxusqrUvpB2UnY2rZSZjLH7D4Or74mT0asmlIuzKEwktjA0GHdo4FuPPgamcFt8N+ZNhDQirl4DpqYEUGiiXRwJkOaW8cGp28BbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341626; c=relaxed/simple;
	bh=odfdENRFWDcq+H136uZ15gXmqCwofLEt42KMPVTZxMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YVzRMyhXuy0pCWr1CI0Z9ulpBncAqFyQeP9V1zsbTPVgrBEgqPhMt/+5OWzWIg33Gjw1uMFbIcJYdLPafboiGmtzh9Egi1Dkc6Yzpqh9Q5tf05N1nxuCKOnVPNlEsMdwcHxyWa0Od5Dc/R2yNLzCr9u3537CC8VRqu6TjpfPdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi5DsFGd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi5DsFGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC94C19425;
	Tue, 28 Apr 2026 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341625;
	bh=odfdENRFWDcq+H136uZ15gXmqCwofLEt42KMPVTZxMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Mi5DsFGdvVxokuG+Dcl2sTz/nzHXe9EeDnV+Dx7l4RIKHTP2vfaObcy5SPAWL7cud
	 TXQBDTIfuLatPeNkyaQ9D4ER0KtmJwZfgV3Mj1Nk3Qx0GrxL7QBxawAatREjjSx64s
	 NHXgKYZtV9kC9eSeJXvIrF0KvysQ8sjJvvmMGG1U5MpLbN7Z2MDXyGio2c1q+AXsbg
	 MftKrwqnZeffrwohqLafWwr1SIIjk2LfV5c6s4U//Rz1NEhPRnCiiFNBO+pXF2OnBf
	 F7+09125dKj9hBCNqllWIiTyrsJ8UU6d7EpwTR3pH1/d+1v3kweS3YMqdrrvHS6Vtf
	 mb/rEcn16NDVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] mm/damon/core: handle <min_region_sz remaining
 quota as empty
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260428013402.115171-2-sj@kernel.org>
References: <20260428013402.115171-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 02:00:25 +0000
Message-Id: <20260428020025.BDC94C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] The patch unmasks an existing off-by-one bug in the DAMOS quota ch=
eckpoint logic, which permanently starves memory regions following a quota =
boundary.
--

commit 6b38ae7237b3de6636c6c420fb6a8b80b4e7eb87
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: handle <min_region_sz remaining quota as empty
   =20
This commit updates the DAMOS quota logic to treat quotas with less than
min_region_sz remaining as fully charged. This ensures that charge_target_f=
rom
and charge_addr_from are updated appropriately to prevent DAMOS actions from
being applied too frequently to specific memory areas.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2103,8 +2117,7 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  		quota->total_charged_ns +=3D timespec64_to_ns(&end) -
>  			timespec64_to_ns(&begin);
>  		quota->charged_sz +=3D sz;
> -		if (damos_quota_is_set(quota) &&
> -				quota->charged_sz >=3D quota->esz) {
> +		if (damos_quota_is_full(quota, c->min_region_sz)) {
>  			quota->charge_target_from =3D t;
>  			quota->charge_addr_from =3D r->ar.end + 1;

Does this reliably unmask an existing off-by-one bug here?

Since DAMON ranges [start, end) are exclusive at the end, r->ar.end is
exactly the start of the next region. By adding 1, the checkpoint
address advances 1 byte into the next uncharged region.

During the subsequent charge window, damos_skip_charged_region()
evaluates the next region and checks if it falls within the skipped area:

mm/damon/core.c:damos_skip_charged_region() {
    ...
    if (quota->charge_addr_from && r->ar.start <
            quota->charge_addr_from) {
        sz_to_skip =3D ALIGN_DOWN(quota->charge_addr_from -
                r->ar.start, min_region_sz);
        if (!sz_to_skip) {
            if (damon_sz_region(r) <=3D min_region_sz)
                return true;
            sz_to_skip =3D min_region_sz;
        }
    ...
}

Because the checkpoint is 1 byte inside the next region, sz_to_skip
evaluates to ALIGN_DOWN(1, min_region_sz), which becomes 0. The
fallback logic then forcefully skips min_region_sz bytes and returns true
without clearing the checkpoint.

Could this cause the min_region_sz bytes immediately following a quota
boundary to be permanently starved of DAMOS actions?

Should the assignment be changed to quota->charge_addr_from =3D r->ar.end
instead?

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428013402.1151=
71-1-sj@kernel.org?part=3D1
