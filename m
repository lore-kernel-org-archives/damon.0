Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B843E763E
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511603; cv=none; b=n7pGX2uCt/hwgui2zsqgsUaS9IKhCIcuy1IP5UZU/rP3y/O9rvQDAi5JVSxKqvUUSdqDGVd+sAPe3utPBfij+tOPUcXePkSbT7SQEkzUqb25rFP/VnLpWfZkCkLg41NVZgkmWZPoehS97FeTeVsLIAOJTPN3RkdNiXNuCsOX/PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511603; c=relaxed/simple;
	bh=hUKCXOP8/sllNG4YlMzbmojCbSxuA7S2o/lOO/YeaH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mxLkbHOOre8voriWDVS0Q3hsF1p1CoeJy1O0b+G8ZeFX5bcoUrR8ds3/85fE/OPWGyJWGavIypss6ReYKvzfWCqya3H8e1QxvKzIvbOKHc+kFlg5ogKPrgw/ar4AvXvIEeXuYmp2fqaKwdA5haOM988T/dJy/y07i4OigisAZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTk3WqfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTk3WqfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2741F000FF;
	Sun, 27 Sep 2026 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790511593;
	bh=mkP9sDxc5ozphuZES6QHskKohuhK+DbbDypAJ3ML0QA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VTk3WqfPkwLaZzVbzM3pTUaVYCzqqPqhKamxSU/fb3lMQtFQJXQteReAhWatPSvGg
	 dCSfJGe+Rt0m2S8aERxm5fJkG55ZJtSVCrtXGA0dNuP/ssxrAWcadRGzHLO+B3CsWc
	 9Lnz9B8wtFow0ARuylsWrsmHstUEieXOFZzMyn72ijKHMFpJBI199rnSpb6jLJEsjf
	 g/XuJQzSaW1QgMPZaVO6EVCL9SaBxSJ2oFn1Q+lY6zHoMMqemNer4fML7hwqWMQz9G
	 Dy/jqXQVvCSjDe2wM/4oQ+VPxCOZEEbDkzVUyoJNSEYCzV00uoEFkan/w3NtQxq/NR
	 S6OYXBoFdfWHg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 3/7] mm/damon/sysfs-schemes: support quota goal
 complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260927120533.50484-4-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
 <20260927120533.50484-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 12:19:52 +0000
Message-Id: <20260927121953.2C2741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] damon/tests: build failure due to complementfalse typo
--

commit c13d1579fc49797d69a40d8e22286757e16cdd20
Author: SJ Park <sj@kernel.org>

mm/damon/core: add complement argument to damos_new_quota_goal()

This commit extends the damos_new_quota_goal() constructor to receive and
set the complement flag value. It also updates all API callers to use the
new signature to prevent manual configuration mistakes.

[ ... ]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index df84d9cc7d204..20bba7421a406 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -930,6 +930,7 @@ static void damos_test_commit_quota_goals_for(struct =
kunit *test,
>  		 * Make it kfree()-able.
>  		 */
>  		goal =3D damos_new_quota_goal(dst_goals[i].metric,
> +				dst_goals[i].complementfalse,

[Severity: Low]
Is this a typo? The struct damos_quota_goal does not have a complementfalse
member, which causes a build failure in damos_test_commit_quota_goals_for()
when the damon kunit test configuration is enabled.

>  				dst_goals[i].target_value);
>  		if (!goal)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927120533.5048=
4-1-sj@kernel.org?part=3D3
