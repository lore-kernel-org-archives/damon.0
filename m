Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5612F0C62
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089600; cv=none; b=Eazjx0rKkgMSc1tKk7nkf6b135ab5IMLCScIDDik0H8hm22Nnik2ojlbxStNvl4ud1wct37wSXTrxh/lCQykHsVqtkqxh6Wtv/dQwUd+angllIEBUayv/zp5DgeS7+2LdOHXsJZ0G3IvS2gu8DFiXEtbb7pif1ud5HYI4e6Z9bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089600; c=relaxed/simple;
	bh=09lE4f42lmVod1pMf4L0/teFgjoYVjObZ2A9KRjqPYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nr6k/VoaRZ25RDexXxugVZSYfDktGKDdlpQDg1P4nEGpskdfD2erel6Ri8rRVoDygSsicqLgm4l4GUja5MuywcsMe5v/AkimyFYtoFxD9wh98aQ/s2iiyDVB0N4JZbOo6FlwO9vOWHzGeq105QCuSJnI8l1mZK8jpnfDS2+1eaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOlSF2vV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOlSF2vV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D201F000FF;
	Fri, 11 Sep 2026 01:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089596;
	bh=9ISRZMcvasElgDsQwVTPTYBxJk3hA5rkTXMIicQD7bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jOlSF2vVDg5Zc0yZ76PwvY9odlQFfEx6NOOemcZLGOP73C4vKf+UOOH3V9sk8EzD4
	 pv4vJUgBJI/sChFzC4LDTFntJsC0WttHx0JGbQX3/eNp+KF8DtJP1mFxqj/luIkzLe
	 u5aZnVAl9RV9V5AWwUYtXDHwzXrpiTKN9KQ74R1jS8s4qtUM5R6kdwNS8BLaj94JqB
	 IODzjEWP6mQQ4Bz6oB7rblKM2ktA/yq+C/acpqDafE0DtVrrBCSbIjxdya422vYgIR
	 cn/pQ/oBWwVBbM6fnIcFgusxpmWTtp1yBMiyDHVVAjRvLtcf1/++GWBta+tIMZKzrj
	 /wL2KkjK1wk8g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 4/7] mm/damon/sysfs-schemes: rename
 sysfs_filter->sz_range to range_{min,max}
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911011330.93678-5-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
 <20260911011330.93678-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 01:19:55 +0000
Message-Id: <20260911011956.58D201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface provides 'min' and 'max' files under the DAMOS
> filter directory.  The purpose is setting the general range arguments
> for hugepage_size like filters that require range arguments.  So far,
> hugepage_size was the only filter using it.  Hence sz_range field of
> damon_sysfs_scheme_filter struct was connected to the files.
>=20
> In future, we could add a new filter that can reuse the 'min' and 'max'
> files.  And the filter might use a range of a type that is not size. For
> example, probe_hits weighted sum.  In this case, simply reusing the
> sz_range field would make it a little confusing.  Rename sz_range to
> range_{min,max} to avoid such confusion.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911011330.9367=
8-1-sj@kernel.org?part=3D4

