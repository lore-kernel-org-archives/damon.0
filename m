Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553634;
	b=4Ril88t9tJ5y5R2njS/IRFeTUy4foomSYfKNGgpS1Ja5h4rZk0/7raAmCUsVWn7rkLJe
	 PJ2ExAS2gr3FOmWTiPJSZHq5DZsLlWmaVkMK/kvbvuwWzH8oaXnM3DOzcJ+HMSnxw8dLw
	 eg791s9ron1UDQ+NZ+el1sDabiyoXy62T3nZn0zLyfuGhUVwshJnaxGVzaDwqL9gxGvgL
	 WpzNr+/OxjKhEHX2LBlbGZ4hspLrn/crjL5rr5gznBJEYY+4ncrvo13Ne2rg7RwR3Q8qE
	 JzIiXBhsNmi8P4Z6bt8XxllhB1lC6tRKOYFo7rxbpY2RthSYX+yZ4KKO3TjrX4Un9Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=szwoa8MQwk8nW+Y1WpnJHMkPZgcB9M33OnLZHwGiHB0=;
	b=SzECG+rmSVSH9AMgxzJBATrBmtC3k/ht0lauMIuOMT/VXzU3PbZDALJgSuQ8Y1T1lfE8
	 zkbG5NuglaLxyNpjU+7tX70MRxmYVR85En6UJ1SEJHuZIAk61GGdC2q0PSyq0NcDuLMPt
	 pcyYiTQlcZuZq2Fr6WSqU3loMW8Lw7zcc7Cq1HsaBI+xIf5b69HuOr/FXO/7tPdJfGPam
	 7GVKGTgwsQwCOo3uzqXySw9XFHHZN0p17w3tK6KH0nb7QODKfiAZ7VuZlZmI03LjQImT0
	 rc/yZFbU0EY3lfkABZOtPj0UXWHKoBJHTNsO5Io4PSNSwTMtTFq4itOjAZ9BSAoj19w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRYFayz2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D352606A326
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRYFayz2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7791F000C1;
	Sun,  1 Nov 2026 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553634;
	bh=szwoa8MQwk8nW+Y1WpnJHMkPZgcB9M33OnLZHwGiHB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FRYFayz26BEGs7eWxRZYDsCGUgYPNkx1HTRnRATon+VHGeVkISF5PpNP6wWvLXVhs
	 mEqeI4Grz2I6guJ9LuSgS/+NIVjKJEpZs1CAOA9gdr+a3bC0JsdXQhFJGU9CQgfeY4
	 BVwU0BD9yQRvdsrSzWkibI9efdLFf8u1aNOUBfVIlm4m961PP0FR3HaIuMAyCEG6HY
	 7joAcoPznQIoPLrkQbg804aGxzqhf8PD16XTr4CDWbOfbLnkyJw/oDG9dN3TLSm+jP
	 MtJavQv/xra2xJr8bHshIkQo6EXYz930r0xmCc9TfnCTozN6zSMQYT9jGDZ6htbUmK
	 HOHGGbJLta+tA==
Message-ID: <sashiko-outbox-192521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 6/6] selftests/damon: remove unused imports of os
 and sys modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Shuah Khan" <shuah@kernel.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261101171630.81477-7-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
 <20261101171630.81477-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 17:20:33 +0000
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
- [Low] selftests/damon: commit subject names wrong removed modules
--

commit dfc99fb0f6f595e8bf824229e67f0b391cab2a8e
Author: SJ Park <sj@kernel.org>

selftests/damon: remove unused imports of os and sys modules

This commit removes unused Python module imports from
sysfs_no_op_commit_break.py and sysfs_update_schemes_tried_regions_hang.py
in the DAMON selftests.

>     selftests/damon: remove unused imports of os and sys modules
>    =20
>     sysfs_no_op_commit_break.py imports 'sys' module but never uses it.
>     sysfs_update_schemes_tried_regions_hang imports 'time' module but nev=
er
>     uses it.  Remove the unnecessary imports.
>    =20
>     The issue is found using flake8.
>    =20
>     Signed-off-by: SJ Park <sj@kernel.org>

[Severity: Low]
As reported by Sashiko on RFC [1], should the commit subject be updated to
refer to the sys and time modules instead of os and sys?

In tools/testing/selftests/damon/sysfs_no_op_commit_break.py, the patch
removes import sys while import os remains and is used in
dump_damon_status_dict():

    file_dir =3D os.path.dirname(os.path.abspath(__file__))
    dump_script =3D os.path.join(file_dir, 'drgn_dump_damon_status.py')

In tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py,
the patch removes import time while both import os and import sys remain and
are used at module scope:

    sys.path.append(os.path.dirname(os.path.abspath(__file__)))

[1] https://lore.kernel.org/r/sashiko-outbox-192115@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101171630.8147=
7-1-sj@kernel.org?part=3D6
