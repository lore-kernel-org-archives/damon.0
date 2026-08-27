Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571E369985
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787797230; cv=none; b=sW4CchhXeSkvl+hPBNl4Slnf1lgBJZZ4ppgypvnX83E1K5eVkx4+t++Q/H+5zUEoRTNrC1CkCZN8ffNX/v65MOsO2K3Gz2APxGrhID+39uyERmq7Pi1Lows3VZ6Y8LLSXjivO5j98/8WWVF9MesIDrSrgXlRcJYmOb2HW74Alt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787797230; c=relaxed/simple;
	bh=nghbczZ2/xLJ91LZK2cc6nyRgDPgSYGzTZDfGtMWLNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZMTKXE83soY1naiFJBc+DJR6ySVti2KbmJPU12e+UAsltj66SysW96nJWcBy3mDchAc6eGsHwcwJZLoJ2ChhRnnomIH77My53CiWdKtU+pIxvn9IMIYYZnTtJZA+ydD74DdlBLhBAu18KNo7KC5dpXtJG5UIYLiChH/wFJpY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgimf55m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgimf55m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CE61F000E9;
	Thu, 27 Aug 2026 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787797228;
	bh=vTAdCg4aV8L/5+MbpW8dcUK1xnPUdmG4Xwu+Y/GfhLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dgimf55mAajN/xQ6waNp26KfxxvZJXI/grXBBTzZo91mH2HhUpOTUZVL//cXMiiKP
	 BTvmbEuGwiBPI6+pcPPCJSoSg2wKhxrU5VmyOd4M3NcRuaCJESVVnmWmu1b6cdw3oS
	 Bbd2dzggnMkypCKgNdR2K+PdcLNzipeORPSsxZoISJHWRDUsSG3GlcpNL0HI1aLLo2
	 +5B3aRCAzjSu/PNdxs4332R+Cyvt9RyLGDBVrejjDq+TGEhTgnfT+kvRgOSTjwajTW
	 3HOxecTVoyn3fqtZn0fJGmPSz0ACTV2aZt4hYaqpoveAaIl3tX3LtKiZcLix4+Jgi2
	 9eS7C73BMYN0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/damon: prevent remaining cross-object state
 pollution
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaozhengzhuo@uniontech.com
Cc: damon@lists.linux.dev
In-Reply-To: <38E4AAAAEDFCC283+20260827021515.1316838-1-zhaozhengzhuo@uniontech.com>
References: <38E4AAAAEDFCC283+20260827021515.1316838-1-zhaozhengzhuo@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 02:20:27 +0000
Message-Id: <20260827022028.74CE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
>=20
> _damon_sysfs.py defines constructors with mutable default arguments,
> including DamosAccessPattern(), DamosQuota(), DamosWatermarks(),
> DamosDests(), IntervalsGoal(), and empty lists.
>=20
> Default arguments are evaluated once at function definition time.
> Damos() instances created without explicit arguments therefore share
> the same DamosQuota(), and the other default-constructed sub-objects
> and lists are shared in the same way.  The sub-objects keep
> back-pointers to their owner scheme, so constructing the second Damos()
> rebinds the shared quota's scheme pointer to the second object.  An
> item appended to one object's default contexts or filters list is also
> visible from other default-constructed objects.
>=20
> The shared state can corrupt test configurations.  DamosQuota.sysfs_dir()
> derives the sysfs directory from its scheme pointer, so operating on
> the first scheme's default quota may write to the second scheme's
> directory.  The wrong values often match the defaults, so tests still
> pass, but the behavior depends on object creation order.
>=20
> Commit 8319dadcbd81 ("selftests/damon: prevent cross-context state
> pollution in DamonCtx") fixed the same pattern in DamonCtx only.  Fix
> the remaining constructors by defaulting to None and creating fresh
> objects or lists inside each constructor.  Explicit arguments keep
> their previous behavior.
>=20
> Signed-off-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/38E4AAAAEDFCC283+20=
260827021515.1316838-1-zhaozhengzhuo@uniontech.com?part=3D1

