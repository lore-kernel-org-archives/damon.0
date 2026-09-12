Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009778C9C
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241209; cv=none; b=XMdjm+i0lXsoxd0cIO60/jVxZrx6hr7+mn633Q9+19BPltM5Onfn8HOakB3Ks+B1RcjJCG8vkfQbKuRgFohEHGmj3NvVn5lckK/BTL36ioCEKiDQW1R0LYd+H/j7dd2/m7YUcTPHSCTVI5HSKYdD/VLMNFP7GQvl4HOMdMBVzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241209; c=relaxed/simple;
	bh=CwRzfsPJDe/hEPuqNTct1AB1a94XcEg0QeAQslUgtEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=anR5ipQNu9AgKb0Tqpr41SuXohmrpxn/80r3N3xTssuwDyiNWNkzcRSYfJRdSaIVrtFHKCPNYTaoQQgsiQ9VrOR4XuX2hRG5d4SzWICGMRsnye1uENKXdpeNY1zLRI58xhgSKnisveObFPO1CWlyzjRHkOQ+57KNyra4uc2wPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxG3rSC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxG3rSC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8082A1F000FF;
	Sat, 12 Sep 2026 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241208;
	bh=V56APdqCi4cLwSbnLenumiYmSu7YR4x9J5on8eE0MdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nxG3rSC4wKEvdVn4rlHdYjyjym0HiqB+s4a9L9kUuBDDtrzrPEGIt8LeG8dgeh1cZ
	 Sqv07pDK9GHqaZBS3FiZnXerN7bEqpsmKgSsFguIrBFaGaUgXFy0cnyvGD2l9XFtap
	 2juvXvctV2UeTHHOc7Qotw8KRydItdgFOSLZgmUlK2jITHZQ3SyKK0s1Cx5iJpkWu/
	 cOsUecUyqjtf5demDlm4E5w+W20ldpZyFbFfkfYLq40FHJH94Zha9IuyPTTwiOwEaW
	 wX7gCyCEqkiDyNmtcA2/+aBqb91yHZiL1hiaHDz7PCkmGP4NFfdKL9h6c4kZBWwI8H
	 Rjn27DOO8uVyw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/8] mm/damon/sysfs-schemes: read
 sysfs_filter->sz_range only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912191807.138502-3-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
 <20260912191807.138502-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 19:26:48 +0000
Message-Id: <20260912192648.8082A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface reads the user-provided size range arguments for
> hugepage_size type DAMOS filter twice.  Once for validation, and once
> again for assignments to the variable that will be passed to the core
> layer.  If the user updates the arguments in parallel, an invalid size
> range could be passed to the core layer.  Avoid it by doing the
> assignments first, and then validating the assigned variables before
> passing those to the core layer.
>=20
> User impact of the bug should be trivial.  From the core layer's
> perspective, the invalid size range is not really invalid.  It just
> works as having a weird size range.  No critical issues such as a crash
> or a leak could happen.  And sane users ain't do such parallel arguments
> update anyway.  If they do, such racy behavior is arguably somewhat
> expected and deserved.  That said, there is no reason to keep such
> races.
>=20
> Fixes: ea1f204ba29a ("mm/damon/sysfs-schemes: add files for setting damos=
_filter->sz_range")
> Cc: <stable@vger.kernel.org> # 6.15.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912191807.1385=
02-1-sj@kernel.org?part=3D2

