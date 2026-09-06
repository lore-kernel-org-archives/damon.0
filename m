Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765D222597
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720781; cv=none; b=ieU/VRW/JAPhTbbFVs10OMimYO+233Z7WE9+UY0Ntjk5r1KURUWMmpD53GCEIlTPMA6mJyj9DXwz6k8rAmNClGmv+htqEf5wVJF3vO84EdegmrLj5vCl3LWR6kDHzU+PQ0+0TmpEnSI+W/xwwYgUOT8PDIytWS3jhHxrAWfOePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720781; c=relaxed/simple;
	bh=HgoQMWIUrukOBdqWlpmhnd/6Hr6IGoDrzfFFd3ui+Oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NI+aB0oMW2i4kEcGiF67jZJPT4IurxkIKAM2LMcyVEwoSQpcsXbyYsTMHYUMcWPrgk48n6g7oUrhOL8thHRrfQl0zwy2MvrRUQ3aw30OX0cKMybT1ZQfZfSTZuD7I9w7WFDPo9E01ZqkaazRlM4wzL9wsDYLhS121eev8iqVglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIgqfwRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIgqfwRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1221F00A3A;
	Sun,  6 Sep 2026 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720779;
	bh=L1LmMSHp87+xeNaVOA8rHkSH2xlHwPCAVveOA+PIwNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YIgqfwRfyARv0hn4nCq8ipeo3EyMYke1ZKD5Iq95KHnQFoWgvoyTJDjwBWSW9lN1s
	 OOFHqXXCJZ0nI/iZ4p2jx/t6KgkKP4HEF9CGNwcN/fR5Ix4lBta8kZ1rzmkeYH0SxH
	 5FnPiQpIkR5q5KCyx3HHzVx0l9bcgUhbh/seS5T6nOFA88bFoO3I9KWhqeFy6g4WrW
	 un6DqLQEG3FeGEPXAGcPQleALhi1ZyWiu3j04sNTgt06dCFRu9XSn000BOGcOFnIUa
	 ftKbOSfcVC20GBis4AmBJ0qOcdtZfGL1RuxG6KusQkHDO3v1eAjnLH9fODcqjvsVwI
	 +OP8wSnmkzogg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] mm/damon/vaddr: support prep_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906184417.96621-2-sj@kernel.org>
References: <20260906184417.96621-1-sj@kernel.org>
 <20260906184417.96621-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 18:52:59 +0000
Message-Id: <20260906185259.8F1221F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set (vaddr) is not supporting
> prep_probes.  Add the support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906184417.9662=
1-1-sj@kernel.org?part=3D1

