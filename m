Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508059;
	b=YTJFni4JIdoDZu3ULBqnf4BVozMLmJUbFzC9FerQ+A9O06m1Or2uSpavOGYrzTYQGbLM
	 PwTMXga6UwAl5msWqYDIz+6fdDh+zfMY3Z1XfGhA/cQIni6EWQ+8wooDvX6QI4Uv9i526
	 2IMY4VNBnl+mU8zxfsuS/WalhRmA+LHH2Le1yWxQcO7QNRAMD85Zvg80DKl5oiXxifUss
	 4qb4mG8PFwiS+XG4U4ECPlVQTeMXyV4F7vTJH4dhP5eI86kHDlArHC2BHtcEnch9S/Nsc
	 V69HpK7JRfv0r2+HPhftWT4LT2OBNeP0k8O5vxZXgZTs+wNM52w6t9DbkpotBdIsrtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508059;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J5ivZiRDgZARjIXxCwRmMWEsN/ju1KWgpHJDr2xQTh4=;
	b=ln3xmPdPnh5XMz32cDF2gfrsHVBaRE95CPuDm6nMl9wWsVTMBiiFmUYqpCc4aLQar7It
	 4t++ur3htV6Qtk6h8eOVvI86fe9GAYvfiKJgSfm0/ZO1JLbLkVi7c3ma9AMYEun6+2Z5B
	 AjcCbX1sAoCbo5btIA6Hlh+oEnvID/fbW0qtqH5opxWPRerDfbuC6VQJ9pEC5t9Psz16R
	 qvjQpzRJHxO/uwCWENoUKtEPNQEqTH2oZ+Qr68H59v5J8l6XwsnYqcDNJI7zKgU+YtaLL
	 gG9tRTFlIudlScaefZBMozDYq2wno1uTGa7vCQgKi66RIrAoCrw+7OraDmq6NBSiy8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRdYyCQI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4395606A319
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRdYyCQI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1E21F000C6;
	Tue, 20 Oct 2026 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792508058;
	bh=J5ivZiRDgZARjIXxCwRmMWEsN/ju1KWgpHJDr2xQTh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jRdYyCQIPrzoWk3yqSvHINHIOMhOzE/LSwUZLhN2DE2134XoUqzMFueQqbtvZBH6B
	 +iekQ/ECNmAeiMGoBR4YZUYTIcLgntXbB7ISOet5AoaaWJUVHZCUEZ7O5aOB/gC0Ii
	 oq/qONExx7g9NFJkfnbOXdwwXP37Im9Hc3DjoFexlgTto+AXXPxvbZMj+BEq7PL9YH
	 JHdmskSuwhpuPSPyd/3P7FTD6YK22xFDhWo6t6UkQVR5ZVfGU4uCv+IzHprJNx22QL
	 zOsb37fSQfsKj1GBoIMilY/fk+KQ56JCEeEWCEl9LjIiIPB3O2Hor/VlPJ1ZQZcyhG
	 1BUprXTYfcgNA==
Message-ID: <sashiko-outbox-179201@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: hold damon_sysfs_lock in
 target_value_store()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261020144726.88978-1-sj@kernel.org>
References: <20261020144726.88978-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:54:16 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon/sysfs-schemes: uninitialized stack read in target_value_s=
tore()
--

commit f43fea0015fcb1917385f72d150c59603a9ae43c
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_value_store()

This commit holds damon_sysfs_lock in target_value_store() while updating
goal->target_value to prevent a time-of-check-to-time-of-use race with
damon_sysfs_add_quota_score() that could result in a divide-by-zero.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 8f083611741fd..55298a17b653a 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1355,7 +1355,13 @@ static ssize_t target_value_store(struct kobject *=
kobj,
>  {
>  	struct damos_sysfs_quota_goal *goal =3D container_of(kobj, struct
>  			damos_sysfs_quota_goal, kobj);
> -	int err =3D kstrtoul(buf, 0, &goal->target_value);
> +	unsigned long target_value;
> +	int err =3D kstrtoul(buf, 0, &target_value);
> +
> +	if (!mutex_trylock(&damon_sysfs_lock))
> +		return -EBUSY;
> +	goal->target_value =3D target_value;
> +	mutex_unlock(&damon_sysfs_lock);
> =20
>  	return err ? err : count;
>  }

[Severity: High]
What happens in target_value_store() if kstrtoul() fails (for example,
returning -EINVAL or -ERANGE on malformed input) while damon_sysfs_lock is
not contended?

Since kstrtoul() leaves target_value untouched on error and err is not
checked before acquiring the lock, wouldn't this overwrite
goal->target_value with an uninitialized stack value (which could also be
read back via target_value_show())? Should err be checked and returned
immediately after kstrtoul()?

[]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020144726.8897=
8-1-sj@kernel.org?part=3D1
