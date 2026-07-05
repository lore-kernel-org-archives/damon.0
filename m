Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558E233938
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267561; cv=none; b=MV8rzBbYHVGPBj845KBX7B4fNbIeWRiRTfqPEdFJOx5zlbSXcRVhGovhk2AIychlz/HhPjfPZ7Z02W8YRqVlbSvQKNCskhjAje4P0WloGENo6rxeE8DM1Yd1iN4Rb7eTdArTao2Qj65lZ7z/5mBMX6pIYpTfKRJtp14m8li/ZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267561; c=relaxed/simple;
	bh=SqOKNJqBb/wsfS5SBoWncs3SXQUTntYu/NH2CsRuCiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CIrzYu5xEYnqYlZ+MZLPE6IOzrVKJ/p16nF7c+18o/8/X8usX7RhEYSWmn287R6aDvZeJyQ5K/TPdb8ZSojRa0TSnkIUWtJ9TrdZoxtkzszAkfvKASY6V5LZ3J+EDvEEJIBhuqaDShYnvqSR90j4SovlevYAJra7Y4d/lHDtiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWwPcj+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWwPcj+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900E61F000E9;
	Sun,  5 Jul 2026 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267559;
	bh=S5QEy0/rZy4xNBsdogatGN1x3PzWJaEjfQXfyoBNJLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XWwPcj+dwsRZevu2UasXpbEoMItJtvVUJSfTjCMYtBuvgMyR14/n7BkFuj8nZ1eK5
	 Y1CTfDc/K1H+5HquWiu+MHULW6Bc5SJHtZangFJ6yZr2q/Q3fsWEjUWzqUCkKEt5TW
	 UmSXZghzDUOsGjur8kEQo8iDAIfxrn9P6k1klhpdq+kO1WyUZuBCjJvI00okgXeXs7
	 npmC13PDNbksZmpuZ4EISDRPUMFaCEyKJfoUt4xe5KpbUymFdHNzkFRHq/WRG1FsKO
	 UHn0oPjsQ9vPuoBauxGwivvx9x7stRRKy/6Cq38sFyoYThxHnW0LOTqVX5cyX1a3mF
	 /tuKkxxWHfLag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] mm/damon/sysfs: remove region size validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705155600.96555-9-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
 <20260705155600.96555-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 16:05:59 +0000
Message-Id: <20260705160559.900E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removal of region size validation allows accepting negative size=
 regions which are then silently transformed into valid positive size regio=
ns.
--

commit 9f8b624e84e757e30369d491c2b454f3896c87c7
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: remove region size validation

This commit removes the region size validation in DAMON sysfs, relying on t=
he
assumption that damon_set_regions() performs complete validation.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index e666dddf1feba..b65651498e0d1 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1987,9 +1987,6 @@ static int damon_sysfs_set_regions(struct damon_tar=
get *t,
>  		struct damon_sysfs_region *sys_region =3D
>  			sysfs_regions->regions_arr[i];
> =20
> -		if (sys_region->ar.start > sys_region->ar.end)
> -			goto out;
> -

[Severity: Medium]
Does removing this check allow invalid input to be silently accepted?

If a user configures a region via sysfs where start is greater than end,
damon_set_regions() might still accept it because the alignment happens
before the size validation:

mm/damon/core.c:damon_set_regions() {
        ...
        start =3D ALIGN_DOWN(ranges[i].start, min_region_sz);
        end =3D ALIGN(ranges[i].end, min_region_sz);
        if (start >=3D end)
                return -EINVAL;
        ...
}

If the user provides start =3D 100 and end =3D 50, and min_region_sz is 409=
6,
the alignment step evaluates start to 0 and end to 4096.

This causes the subsequent check to see 0 >=3D 4096 (which is false), silen=
tly
mutating the invalid negative-sized region into a valid positive size region
instead of rejecting it.

>  		ranges[i].start =3D sys_region->ar.start;
>  		ranges[i].end =3D sys_region->ar.end;
>  		if (i =3D=3D 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705155600.9655=
5-1-sj@kernel.org?part=3D8
