Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B706386575
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351181; cv=none; b=nb+TlkVOQyub6YyvtsIxEfxHOOGoC9KBack03pIUrPbjprO8pTltxFh8Lv5IIhphjiiLEyfpvaktezzLH+CT5bjozcQqXZDuwBzkoQly7V29aFhrDAciStFViJq5pQDUT0xTulG7iYhpOKb1fIKE8fgCAfiDureaESKsQu7Dw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351181; c=relaxed/simple;
	bh=5zJsHwr1d4t+uQ/yHHfY8dj3cdH57/c1SgtmvMyHNIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SrGp35iKk53w1O9ukDWoOc2CA/UTboimakXU1k//nDwg5Y5XCPTNUC/aOPWFP2FGNxEAvLg9dR6crsYaAgo2VKj1NyZ96Y0J3GVVzo4AB9EFyjIDuj4lMIv8UMi4YwyekBclqGDD4kHvmuqSbFTdBETzMk6MvOJR4MhoMpZ/fgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTmlqhJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTmlqhJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847A71F000E9;
	Mon,  6 Jul 2026 15:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783351179;
	bh=/dr6odETlhB3bEkKhLpEmFOSd86wA3ICGtTDyxB1TLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lTmlqhJac87KAiQcFMEDtyy1bEr2KgMmUXOxlfUmaftEb8dHVck76CtijJZxwzF8r
	 c5wQ3Sl+IX46DJ6wAmrQnJ3Wjf5lh8Pz4hGa85VF9/kxRcFAdvcWcvc3yC/+ygQaS3
	 ta4oljIxwXW3Cn5iMUHEuXWsYGXasznhwCDKvH1AmD5OyzCyfwM7Zs2vpkSuCgPaw0
	 3pRWIXbHpeqc01W7igsxN94nrPNKkcjToqvqJHX+XUIg6EM/oFh3TBxUBDrKralIjz
	 JpoqF1AUXvPTkU9d0wfbejRp5jsmnM8N6iMJHTqo4xwKo1A5eEfrgHGb8fARwtZhWN
	 AtEg54iUgNg2Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 13/16] mm/damon/sysfs: implement probe/weight
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-14-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-14-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 15:19:38 +0000
Message-Id: <20260706151939.847A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unbounded `weight` from sysfs causes an integer overflow in `damon=
_probe_hits_wsum()`, which corrupts the core region scoring algorithm.
- [High] Setting a large `weight` via sysfs trivially bypasses the `max_nr_=
regions` limit, leading to unbounded kernel memory usage and CPU starvation.
--

commit 13d5322850c993787f439a6daf8065f8717e7f80
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: implement probe/weight file

This commit implements a new sysfs file, weight, under the probe directory.
Users can set the probe weight and enable monitoring using it.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index b65651498e0d1..a8ef7903bf94f 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> @@ -1100,12 +1101,35 @@ static void damon_sysfs_probe_rm_dirs(struct damo=
n_sysfs_probe *probe)

[ ... ]

> +static ssize_t weight_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_probe *probe =3D container_of(kobj,
> +			struct damon_sysfs_probe, kobj);
> +	int err =3D kstrtouint(buf, 0, &probe->weight);

[Severity: High]
Does this allow an unbounded unsigned int weight to be set, potentially
causing an integer overflow during calculation?

In damon_probe_hits_wsum(), the score is calculated by multiplying the
hits and the weight:

mm/damon/core.c:damon_probe_hits_wsum() {
    ...
    sum +=3D r->last_probe_hits[i++] * probe->weight;
    ...
}

Because weight is allowed to be up to UINT_MAX, and probe_hits can be up to
255, could this calculation wrap around? If it wraps around, regions with a
higher number of probe hits might erroneously compute a lower weighted sum
than colder regions, which seems like it would break the ability to
accurately track memory.


[Severity: High]
Could a large weight bypass the max_nr_regions limit and lead to unbounded
region growth?

In kdamond_merge_regions(), the merge loop condition checks against max_thr=
es:

mm/damon/core.c:kdamond_merge_regions() {
    ...
    } while (nr_regions > c->attrs.max_nr_regions &&
             threshold / 2 < max_thres);
    ...
}

The initial threshold scales with the unbounded weight. If a user configure=
s a
large weight, does threshold / 2 immediately exceed max_thres on the first
loop iteration?

This would cause the loop to terminate prematurely, failing to iteratively
increase the threshold to merge regions. Could this allow the number of
regions to grow without bound and lead to severe CPU starvation?

> +
> +	return err ? err : count;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D13
