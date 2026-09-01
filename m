Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD93AFB0C
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237825; cv=none; b=gPYEM8pLIN2/OOU5FmX57F/n1PCEj4JrGUArt1rtV6hy4oUkzNjNse0+rYT5u7RWnCcpjBomASz9yonA5/vasPzmpY6HCzT6ZORLyEX6GZ4YMu9BvmCzP7ORjjjIaxE0rb3+TxOApXStasKrrhR1HRBmZZFgA0oajyxKjWCjECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237825; c=relaxed/simple;
	bh=EDGCKAo1X8Ammqt2DIEos0tsy457q/atfn5/JsLCsmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AV9v9zERjgU6/NK9K5eF0T4tXJ2D2nNd5dF4UwUgamM8m44V5i92HrauQ2Vn5mOLfW5mg1hollyP3tG74K7cjOIwGCaisq1ZgytJVvQdXEadJZWgRSoMTipfQ+T6gQ8kOXXb4xhNrDkbQgOVwZOk7FT4YztO0MxrvhTJWmxv96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN/5gKX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN/5gKX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AB81F000E9;
	Tue,  1 Sep 2026 04:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237824;
	bh=NWUjIn4Jqsav6VSq14EAqE3Ne1lixAqpAD3BJP67sdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jN/5gKX02Q/vuPifBtZ0YU8fP3Z67mkRqlQI0SUk1WY3tOjy9Jw5idlWoocBSnFbN
	 JzkF+dZHZ/ax7TFaybsybrZKfvblWNSpAHbt16CvXx/cdHv6lC2IYPO96PVdjASEzE
	 SWJxuaUGfe5tb/tBa0T8eYcHfOfnAx1M8qefD1mn2njAnNvkED+8OIukEEd/0P24z2
	 UdzUxxbNHTVmO/gr9p06wt6EX4fDt1mxRPW12kiV0Di3i+b+Ak4WUEBcPPHgrlVmUW
	 Kj7L/jYgajpYBWSuIcCIKi3fa3zW1/KWsCT/jd/J5UzcL96SY2VpkFtcNn7/afD5SZ
	 BFDUWAX9TCq+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/17] mm/damon/core: commit preps
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-7-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:43:43 +0000
Message-Id: <20260901044344.19AB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_commit_probes() is ignoring damon_prep.  Commit the prep actions,
> too.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D6

