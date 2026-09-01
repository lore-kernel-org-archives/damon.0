Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4E392C5A
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269854; cv=none; b=WOsM0LQ1bVULRj9PC3dMJjyAYZMfh7qsyF9fD1r0AfHOGaVOF0+jj3AmtXgzOkQjLKPUSIoOzRm6RlExm8Rcr2hzbiDl4Y+bO+s2uk+aY1GxfH6vAqHM6wkRg6Vo5RR0VxcKVipR2XUJjoAVjEadfz10mTTEqOR2Pk0Pj+d/8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269854; c=relaxed/simple;
	bh=AYRCxs8VBDvY0saSMelWGkPrHFC1mM+q3bUwWW52Dbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IGmgzPqcWQ3TY491w2qALMJcpzLxL6XFmkT4npcLmM6i4i0kFY4eY5TooTBVahHyg17+qReEEdt9mEfUm+zFgOeXDHjr4CfQzdbadhFtrPgPKSYQgJa/nwevcJ0++UiohPAZEV2Y9SfKHjZFl+d0kaS10EoSKxDcIZDOG0Qd4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOqhtmtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOqhtmtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200271F000E9;
	Tue,  1 Sep 2026 13:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269853;
	bh=lx+T3mJPBawmSzpgPB6kOTlussVuGUcFv0yXDt1VOic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iOqhtmtqFs/pkRQuhatEEhRe4xklXqLGbBlAcynHErtvzNViXMB+oTNO9OVf0barc
	 ijOmDCLoWBvncyjnc45h//WZLekPh95jZ1HubZZ/nju9pc1utd3Xg+1PZMAPVlHVYQ
	 gYaMYOLKpVASXKzPCc4EEy+7HBgpIVV1xCA9JsDA2/IinuuS1501DXdEtK+5AkOWkX
	 bbuSUvmO8mWqBnnHEorRNY9teBb0L2rExjLh/1VnvTIqBKFsQu8gd9QM8fn69YPjOn
	 YI8SicSjr1kNs66KcyWP4BzOz8EuXjRabqgHhL8u84pznRjlkm+wvUrIOYqVZfpwh9
	 AWhZVF3XPLNwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 02/17] mm/damon/paddr: support PGIDLE_UNSET probe
 filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-3-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:37:31 +0000
Message-Id: <20260901133732.200271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
> address space DAMON operations set.  It reuses damon_folio_young(),
> which was being used for access monitoring.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D2

