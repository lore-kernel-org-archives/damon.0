Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67533B6CB
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924251; cv=none; b=iGeZeHZW5XNgERLhq6jfE92pf+/8UseQlq51WVEij6fjbx1haFh2nSiXIKqtqG5B5H9Jab0KdssqGsufHe1yyYny2XGTLy9QAEyTL11zy4ejSTIIIo4hAHeLCBoziBj5ag0BJJgmSFWTjFmYFDO+NLDnrhq+/LwEzR9tguRbETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924251; c=relaxed/simple;
	bh=9IMMZaPCHnjemf1vGK+qFkGGIN+9o02OP1JE9VF3WbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SbtuAngogG1i6wPrHtFdH/p2Ft2tehKYClWJmR5lExQpsbW/05UVcQ+pJt4pq6qZ2MHhHIJkcCxYxEHIXdn9AycDlHDdPpm8pM/RJlEiI+huT6jsm2TzlLHu1MTwiY4e2c0i6IwwPJwSBqPaEAl+tN6Lf81+Gri2nYwI3nt9KqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP2KQMU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP2KQMU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918371F00A3A;
	Wed,  9 Sep 2026 03:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924249;
	bh=9IMMZaPCHnjemf1vGK+qFkGGIN+9o02OP1JE9VF3WbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KP2KQMU41YmPG7/oGDal91u+caxk3s3TB7nsaMID/yUbmy3P1HTYW+DVetARDXiot
	 Ui7fNTRnFjH9p/bxGZ52wNoUCEpBQ/1DeqFkLUXi0Qwho8FaKGJk/eDpUfBO1UXP5Z
	 87Stkaeb1xztpa07puPDfcJpcUFp5VMfDr+lT3xbWpxenETrX7nNvw6/Na6G+eM3BB
	 KANxctna0IjVh2lfWoWKOFuCu5GcTrkL6HPuixCxMY6WxU5WRg7M7jHCVp2nBVUtOJ
	 fUOJoO1X//oVkl5SgDQ+DVR3DelWoH8MByKS7MprBcfSn7XFSyGryq73XYZR5lTu/z
	 JmjXAYQb/Md6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] Docs/ABI/damon: fix typo in intervals_goal sysfs
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909032155.118089-1-sj@kernel.org>
References: <2026090815-crane-crease-f5f5@gregkh>
 <20260909032155.118089-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:24:09 +0000
Message-Id: <20260909032409.918371F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Song Hu <husong@kylinos.cn>
>=20
> Patch series "Docs/ABI/damon: sysfs ABI document fixes and additions", v2.
>=20
> This series fixes typos and fills in missing entries in the DAMON sysfs
> ABI document (Documentation/ABI/testing/sysfs-kernel-mm-damon).
>=20
> Patch 1 fixes a path typo, "intrvals_goal" -> "intervals_goal", in four
> What: entries; the documented path points to a non-existent directory, so
> it is Cc'ed to stable.
>=20
> Patch 2 fixes two further typos ("WDate:", "manimum").
>=20
> Patches 3 and 4 add ABI entries that exist in the kernel and are already
> described in usage.rst but are missing from the canonical ABI document:
> [ ... ]
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 1b492fc82368399123413c937f13da6ed312ee4d)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909032155.1180=
89-1-sj@kernel.org?part=3D1

