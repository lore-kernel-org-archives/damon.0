Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26856852E
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963114; cv=none; b=I0XtylWF/0lzwhaqP0dfOgd3G2n0BrecmmADm2w9FCVsz8TI+F8b6TzX7dTGOYlxXHia7tR3wRhj1yYALBmfZwTZZ0/f1I+aHCmlITwTFr0ckeTqaiTLcDBzIZV28cOZu4f/0k0OwJhm0MHLKWVx+66dZ+YeyaoivR/baI4QFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963114; c=relaxed/simple;
	bh=+Pxp1mGWYdhHffSdUIdWXgNJN5hnlDEFuc1vj+7xMcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bERnNPJHAe4e9E4krcODazHTx8Rd4CcVwAczdf0/ciA7yMvd71XtGxlRUONDBuCiMRbCLCT+PP5lxZHfOLnuA08p0jGrcoiBIRyJHbUpcWqEanW5mTbpjqYdVFSW7i2P11lyROYakDlqFOKjWHH/KiCCceQMgUZ9J5I8Fvx7epQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiWELhAM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiWELhAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEAD1F00A3D;
	Wed,  9 Sep 2026 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963112;
	bh=c0RxuXOoAy6M6wjlUNrycBJbXKV99n9hnkgfmIcg7/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MiWELhAMJi197silPRTT5IxlBrR68cPiv+CPx3ntZlQ1pf0CDNmvKkyJcIvWnqGfN
	 aHYXSBxVBVP4HJoxKLrTASK66Ulf9NwMvrvPJXiQqPW6hp29y7/etjyJ/nx0EjKNmC
	 8LiX4pGEbrpwix5T9AHP4klzwDkzllgos1BjlEQnY8FZSB7buYPgZ24fQNMjK8QsPx
	 eYbPeUdOpIrRM7wtFjgHh3g/dAGAAJ/GgLhFBPAYLsq3uTrK8u+Knn2YB9iiELa+uS
	 0d6TXADbNVExYHOp090AaKh/FhQl5SHgS9LY/GeKZSvaPqMjKKFeia6QgcUjyV0ySx
	 qGzZVYU2FtxQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REPOST 3/5] mm/damon/vaddr: support apply_probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909140408.104699-4-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org>
 <20260909140408.104699-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:11:52 +0000
Message-Id: <20260909141152.BBEAD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set (vaddr) is not supporting
> apply_probe.  Add a minimum support.  Do not support hugetlb pages and
> PGIDLE_UNSET filter type for simplicity.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909140408.1046=
99-1-sj@kernel.org?part=3D3

