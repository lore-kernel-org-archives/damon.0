Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506941E6A3
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468182; cv=none; b=Pu2YqqMci5Hp/jJryGP2Ad1xEAwZhzVcxxkwAte057DWyJniNYN/kKPNGULq5bMzxPVXiRPd/z1YkO8KMizT4sY4+G7dbm9X05chMUz2tW+Df5lefdXjQ7FOU0SeqZNxlug2Sm6GcNqTkOp1k6fZJBcJ3lfYP+oWGlY9tSCzRTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468182; c=relaxed/simple;
	bh=3TizjrQTST8VO0UsZi6r7wEKfqbGlYhQ2O/uQ6bbW6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=suI6q+D660KhfYSVK016C4sc+ZaZRWaZ8Tb5R4gxQ35VweHy65FvZwzicVmQobZ9LMatcLsiQQNigBA8/QXkMr0FgtZc2l0IhmU1KM5MoLNPO04rV2UlUuvwYygcs7wgKQWIoBfwvySRHmrI3Aj/djJ0ump92Bk4Kss5c9oYiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipeoj+C3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipeoj+C3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3401F000FF;
	Tue, 15 Sep 2026 10:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789468181;
	bh=3TizjrQTST8VO0UsZi6r7wEKfqbGlYhQ2O/uQ6bbW6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ipeoj+C3wNOZ1vAg4ppGT2cV8Y5adjLtOVwQXd5Ex9Ze6cf8MGKj2J05pO/AheIYM
	 yvXcAuEqQLn+58BRDH9fxoWlKGk7+M4s8Pzapu4WW30k7IcjyQ5F8wssBvMLGDylMP
	 pBqdmUsjV/4E0gXlzOLugg9ri0RXNwH4QRz4IG+9MfD/OeNffAcNsNC8Gb9unyxeC4
	 7kzoUU5euF0Vqq2XThYCCvnHGgxC98UF667cFAmJIcArLtpvwOZMSAVESHmOu9MShu
	 63HGQz5YEumWwloxd41JrtsrhgRKBug7aYRLDbThjORu3i/eyofph6+LJpzh9GSGRB
	 /KsxFUHTH14qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] mm/damon: fix typos in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWRyaWFuIEh1YW5nIChMZW5vdm8p?= <adrianhuang0701@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915102746.647-1-adrianhuang0701@gmail.com>
References: <20260915102746.647-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 10:29:40 +0000
Message-Id: <20260915102941.1C3401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Correct spelling mistakes. No functional changes.
>=20
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915102746.647-=
1-adrianhuang0701@gmail.com?part=3D1

