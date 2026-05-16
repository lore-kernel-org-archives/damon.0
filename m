Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1AE405C31
	for <damon@lists.linux.dev>; Sat, 16 May 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958572; cv=none; b=u8DcRt1CitPGdlyYljUE8WIwX4EwiLjYssDWm2MKLKV32GG9M+kt3bTjHKhFFIn+hjEoPNtEPsqGJogDnTdfQeqm5U3i0XyAuuh3AbSxJI3X3TSay43KKd61xhdyn6HUgUIUzqPqG9htVkN3m4fuXMQZ4d3wENV7Urp2ND+ch5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958572; c=relaxed/simple;
	bh=C1v98Yk2VkQZTwOsE9sm5B0GeXO9zDfC7F8/1oGfTmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d/PP3tA1lPzZXYdHgKGU/Z987gsJYJANBy09iYGadPsnnDbtKkyZygKtBmX0jLKaNlxP+VzfcJWLscTi++ZWiYwH8YaCocZWNPJO6SV0zr0tyV/1bWHwYPVO26A5klhtmQL+8KNce9j3O36CbfuuXBU1b8vjFc3gADZkgOA9Ssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/7FbTqw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/7FbTqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B49AC19425;
	Sat, 16 May 2026 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778958572;
	bh=C1v98Yk2VkQZTwOsE9sm5B0GeXO9zDfC7F8/1oGfTmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=s/7FbTqwHlh67WyCcUstjwqhEQvfWD8d3TBBHY7uxRbkKxgwl+FcBUO0tdptWKZUJ
	 /55WcFwlVeI3wqzBrmhNCBD/XdM6cRUSD/evhd9l2nSLFbJp9NIRpARD8fl32W1Sfw
	 AMCjP9U738PuB+/a9GKpVlPw86grL2J+Eat5fjyAn6OgeefFZGlrUY5eWSfxwF+XRk
	 NXzIfREc1YwDkAhvP+yrxiixEWkkwyvcOpCuAff/KQKRPrCsouOIGhxW78NINROiw1
	 hJfJnFd/0HDnhvgGO8/THM5vYipDDqui9NigHFwwGx1cRBamThhTGhrWU0cL9VFwgu
	 HJFz2c0KIBfwQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 28/28] Docs/admin-guide/mm/damon/usage: update
 for memcg damon filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516183712.81393-29-sj@kernel.org>
References: <20260516183712.81393-29-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 19:09:31 +0000
Message-Id: <20260516190932.1B49AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Inconsistent sysfs UAPI naming for identical memcg filter concep=
ts ('path' vs 'memcg_path').
- [Low] Awkward and non-standard grammar in the documentation.
--

commit eca4a8cfbb76f7f5c4df18fb3c84beeef902be91
Author: SeongJae Park <sj@kernel.org>

Docs/admin-guide/mm/damon/usage: update for memcg damon filter

Update DAMON usage document for the newly added belonging memory cgroup
attribute monitoring feature.

> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation=
/admin-guide/mm/damon/usage.rst
> index 7b6074a1666f3..b4584c0e4cd72 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst

[ ... ]

> @@ -283,7 +283,9 @@ the data attribute for the probe.
>  In the beginning, ``filters`` directory has only one file, ``nr_filters`=
`.
>  Writing a number (``N``) to the file creates the number of child directo=
ries
>  named ``0`` to ``N-1``.  Each directory represents each filter and works=
 in a
> -way similar to that for :ref:`DAMOS filter <sysfs_filters>`.
> +way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the f=
ilter
> +``type`` is ``memcg``, ``path`` file works the role of ``memcg_path`` for
                                      ^^^^^^^^^^^^^^^^^^

This isn't a bug, but this phrasing is non-standard. Would it be clearer
to use "acts as" or "serves the same role as"?

Also, does exposing this as "path" instead of "memcg_path" create an
inconsistent sysfs UAPI?

DAMOS memcg filters use "memcg_path" for the exact same concept. Could the
underlying kernel implementation rename "path" to "memcg_path" before the
interface is finalized to keep the naming consistent?

> +:ref:`DAMOS filter <sysfs_filters>`.
> =20
>  .. _sysfs_targets:
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516183712.8139=
3-1-sj@kernel.org?part=3D28
