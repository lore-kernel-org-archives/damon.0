Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95D3C4562
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244072; cv=none; b=ca6annYcA6mJdpMXSiEbNlwveFQTilbJftMPX3DZA2oXH6zofYxtple9dso9RPUNjxhAn2RfbFifcjc3ZBX2Kw6e2uomM7yggo2xPAzM3Rc6Ata8nj6++WZ3QawVR1byOl30tgBOLtdzh1gvUV7CEJzVb6VJIeote17IJWJyMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244072; c=relaxed/simple;
	bh=mAWaS8HXPHzVTtrdggzI+vpZ+2NcGeIXs5PRD6A+zs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oz90x0phjQnvyhYyO4AK7p3XTX5L4+72DjZ3Z4CNJ1epwngw413ie6/N9Wqggm39eNt8jmpjLKctwfmUu0O1Sq+I+mQ5cFd+UNUxOtLi4KmJ/auIxYrhCSSJsq2qDVVv/WNtnSVmZY5U5koIFwQZMpw6buxssUQAWYQqKU/+Cic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG5CmD5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG5CmD5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92AB1F00893;
	Sat, 12 Sep 2026 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244057;
	bh=qUSoqKNE4pqcZnvd4igIq165s41yLXo2ck6iOJ3lXHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EG5CmD5xv/yOWxpwCuv0dMF5yF1mQHLcdhS39xHNHg1jVfE7Lg526fkG99Ce3CuYL
	 Rntw4vQ99y+EJiNC7pmlh8lzLpLoqEmLe25w+Yr7AD0B0jLy4bVG2chcqVLsl0KHA+
	 RV2MW/v59Qa/J+tANizQY2+FZBWousDqy148KK1uaIKQpvckwrXkF17u/f57XZpoLj
	 EZcrjhEF/dnV3OhHnWwhIZZmcyRWlYGOM0GyGTv7fkgxI6ZGbzMgk2P463CJ+LCpzW
	 ZkEFNGZ/GaBoTpBpeT9DK4BnzAPwTUjmJDVr7nmfNVnBSNtE/Pq20jYkfwGXv5KvPT
	 FtyH5LbmuL3ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/9] mm/damon/core: use damos_quota_is_set() in
 damos_adjust_quota()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912200814.145612-5-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:14:16 +0000
Message-Id: <20260912201416.E92AB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_adjust_quota() is manually checking if the user set the DAMOS
> quota.  There is a dedicated helper, damos_quota_is_set(), for the
> purpose.  Use the helper.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912200814.1456=
12-1-sj@kernel.org?part=3D4

