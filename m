Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA8371D01
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618409; cv=none; b=Onb3Zaun/sEz2YBm4dySw/zxbVdlDdoSMRVynq3js12GBWDy3AvpNSK0drfZdw/wPY7RVJDqozOUYZrrlgA9kAEjQbrdi8lt182SpACm34B9/MsX9IEE7I7ochelu2EXKx96MTl0naZ6w5Qk05W1g/MygAlktdfWfrQ3TsGl60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618409; c=relaxed/simple;
	bh=nVnlo1CXz2KbJOkVeNbeWAD27mUpoqGZi6Q0FtgthvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sFs+W3zRjAqBQz8sXJHbEWlgccTwRxBdwkKffb8CxBt6e72GPZkkMBQesU0phhEuHz3VSmAgSW5+hRijnrUtsdNtp4QSpQeYFrjcjpHDCmC1BJEHHepJHnokskQu2wErlPDINV1L25rDLkTquxbtWZA42TPtftiMDOYYkij4rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL8lQbij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL8lQbij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B4E1F00893;
	Thu, 17 Sep 2026 04:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618408;
	bh=j60Mnj9Lxb3jIZlSO0z6ohRtE7mCCsBF6DHGLqBNQwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aL8lQbijVUmpatmJ5NSZSF97QtIcsppv9deyEDtujC0a3+YAPAYy1W7/H8IGF0MLr
	 xXKQxe18Q2qbTwkE3o+UltsyuVjeKTUkVCcl4tDZjKWfmML686J4aKtGXUWZmEoIeM
	 zE/pBYNVYm1VMmgchZf9ZVLKV/HoxPNc3pzRgI+xbhOxPnE7a0xzl0KQzXofZ3g0IK
	 WXf8cMwQAm48cEnDrxtwvNkFEomKFvL6mn5JyBs6b8ZKks6lG6Rpq4cf12PT8mFW5f
	 rTtR9Crd3DCJT1r1NoFhZ6K3WcpQILhUsqL2NxmPLP8Eux19dLwkgyeesMaHK9uJ/h
	 zYTtUDaqZXlyg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/10] selftests/damon/sysfs_memcg_path_leak:
 fail only for real DAMON leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-10-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:13:27 +0000
Message-Id: <20260917041328.38B4E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The selftest can fail for any leak if it happens while the test is
> running.  Remove the false positive test failures by further checking if
> the expected leaking function is called out on the report.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D9

