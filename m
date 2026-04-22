Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC629E0FD
	for <damon@lists.linux.dev>; Wed, 22 Apr 2026 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889817; cv=none; b=N+deJHOti96/QiXuUtZxZX+xph8nKYls329ZgvpjKhb5hKjzWpSKxSAMC/nQMSKtE/79PCyI2c0xJUeW1zS2r9ajZdO4OKaYnVn4u3BKXlDwubLMWc5K0Nas6sCZof29ALdYLCUwKf5O60g705cN0j7HZUL+jRaCeE2x7DmdOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889817; c=relaxed/simple;
	bh=pbHLgFZuZ+QqblwPdYarGj7F4msGUHc5ovtCqEAt4mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iV6GMZKAUdJuI+xEGMgCkOMbxShQBbvspNiI61H1dX11+RCWt4Y7XEc+9lutAsqrRHxmoKMUlNbKtwhZT4E3bcL0Hmvc3MK/Xkyg7Nme4z2kQ8Nv3MQmHJT2lA7T9D3ro+6jS/gysYndhI9qrPiiWxM4/OLcd+7bSYNqU+dVT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu6orR8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu6orR8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F3EC19425;
	Wed, 22 Apr 2026 20:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776889817;
	bh=pbHLgFZuZ+QqblwPdYarGj7F4msGUHc5ovtCqEAt4mo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Tu6orR8GUe/+SKt1BJYKqwycLLotxvNSubY5mzzYf0Lzdg+aCfHErUQo03YXoQTyu
	 ToM39wA+cRRwU4PVCrCYJVOsN32nGzkYsExRPOfkEgM0hf2/PU/vI2mW8pRNWL5Gke
	 LsUymYeCcULrlqc8i4XXYDTq3Nzf7YRHCBrgAkiphO0Qc2ql45yaNFra4/SzxpXYs6
	 SpQNy9AVohw/7A9Lt8MCS2KNJkkFv+0hq92x7ygwR+BatcLyAQ6NrKWk2kadUn4pdx
	 jONnxFhYH3rl00aa7cy6RVaM9HwlHurEJGZVIJBo+l4zO7ad3G1/XUgij9wTMBnQUc
	 ZvvI0gM4XpydQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] mm/damon/sysfs-schemes: protect memcg_path
 kfree() with damon_sysfs_lock
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260422143503.71357-2-sj@kernel.org>
References: <20260422143503.71357-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 20:30:16 +0000
Message-Id: <20260422203017.48F3EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] Breaking from `mem_cgroup_iter()` without calling `mem_cgroup_iter=
_break()` leaks a cgroup reference in `damon_sysfs_memcg_path_to_id()`.
--

commit f19bff910905231adad168cfffc97ed67cb1fde3
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock

This commit fixes a use-after-free vulnerability by using damon_sysfs_lock
to protect concurrent user-direct reads and writes to the memcg_path sysfs
file. The locking prevents readers from accessing the memory path buffer
while it is being deallocated by a write operation.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 5186966dafb35..8d32a20531d49 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -550,8 +555,13 @@ static ssize_t memcg_path_store(struct kobject *kobj,
>  		return -ENOMEM;
> =20
>  	strscpy(path, buf, count + 1);
> +	if (!mutex_trylock(&damon_sysfs_lock)) {
> +		kfree(path);
> +		return -EBUSY;
> +	}
>  	kfree(filter->memcg_path);
>  	filter->memcg_path =3D path;
> +	mutex_unlock(&damon_sysfs_lock);
>  	return count;
>  }

This isn't a bug introduced by this patch, but I noticed a pre-existing
issue in this file.

Does damon_sysfs_memcg_path_to_id() leak a cgroup reference when breaking
early from the hierarchy walk?

mm/damon/sysfs-schemes.c:damon_sysfs_memcg_path_to_id() {
	...
	for (memcg =3D mem_cgroup_iter(NULL, NULL, NULL); memcg;
			memcg =3D mem_cgroup_iter(NULL, memcg, NULL)) {
		/* skip offlined memcg */
		if (!mem_cgroup_online(memcg))
			continue;
		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
			*id =3D mem_cgroup_id(memcg);
			found =3D true;
			break;
		}
	}
	...
}

According to the API contract, if a hierarchy walk is aborted prematurely
before a round-trip is complete, the caller must use
mem_cgroup_iter_break(NULL, memcg) to drop the reference to the last visited
cgroup.

Because this is missing, could every successful resolution of a memcg path
permanently leak a css reference?

In environments where DAMON configurations are frequently updated (like
dynamically profiling containers), this could lead to a buildup of "zombie"
cgroups that cannot be destroyed, eventually pinning substantial kernel
memory and causing system-wide memory exhaustion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422143503.7135=
7-1-sj@kernel.org?part=3D1
