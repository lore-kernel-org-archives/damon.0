Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968846;
	b=HgU2NfEXQ0TV8MMnxSChaxaT+OK6CrCzOMBrU7TapRwyGGYDJJ7JtNFPMww97tPHbxgU
	 v73oZfNCecjhxzdDjrQmeTE/+9PoLkemyJonzOQGj3DI57Tkw8mOUf35hbligCl4OhZdr
	 q6ssC3LNq3QL7K8tzGcVolh7TBrMl/ApyA7Fsj+XEcaVZ2cYvqy1vzd2cmPktFEI55xr4
	 jurRCWFb/TJ3qQtFCHbc31xKt/jFROlsMwLSXAbnbYYGcI4VglYVsmePXKW4Wblcg/gKf
	 HRBSgm8PsPVSV1nZ2BcibjwCvAr4SwugCFji9yG3cnv5ITCGm+TyLx8d0uxCxgcQZ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968846;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gnbl0+2ejC5SavvYuMaJG9UDudop42G88QjFl+nScVI=;
	b=HHjw3GYNyz0bgV7stbaPvWPZHL139UBZFSMFVxQQDSQDAlvE4C30g16Xj/K37LnBh7yd
	 85QQhfGAr8EKqf2tEum5cHBCl9Afag24oFnHOlniIpqmiRdLKGVfkqdvrMWZnB8L9BV+b
	 1AME0/xe+s3bTGaY1LKjihrS+b1+Qs4kLPrBV2oWsd/HRjQuWy6bE3cI/cECVf6JCTc9W
	 n6RSBujNdqEsNbc/5Ja0uX0JD/IS9vG4Ic+adAFjs10geECLzIe+E6IbzPfd+qwosOXbc
	 pW6rpxfC0Trxo8whJMZvi2tzpdBS5+ifYjaNPChNKeTkM6u0F8vcyAiA0Wguvg+1G9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSYK8IG5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A1606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSYK8IG5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EAA1F000C4;
	Wed, 18 Nov 2026 02:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968846;
	bh=gnbl0+2ejC5SavvYuMaJG9UDudop42G88QjFl+nScVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSYK8IG5ENnpFn2JF2EEgUwHsvrI73LenXCgK4HlAcvFVv2ssV1p15DXg7vGWLWPA
	 7cZ1Kr2+HlBXbMGHi6T6QOm1uhcAtZATIXAbIztAxEyngSsQ5GDGcAVW8c8kVzFnmF
	 VuErk0OM9VMI7FSIVbCmNCEGyyVHylg9gCx4GQF4s3Tf43ZvNLl9kLYgOJCmeJCZQF
	 pKIOF+xrbm/Xi6SPunM8ePNEc/+/fyEB8LQMOQxvcHtMwMrHLuBatAbzYLKqeITPJR
	 P4x7uVwFwgYx410bycBw9ySFDA+tD+s5aLHy0Si8VivCMTHrqpm510NuM2NvFWcmWk
	 3p2MpIVlYH6AQ==
Message-ID: <sashiko-outbox-219947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 15/27] mm/damon/sysfs: add filter_report_type
 file under probe filter directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-16-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:27:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Add a sysfs file, filter_report_type, under probe filter directory.  It
> receives damon_report_type from the user.  Reuse
> damon_sysfs_report_type_name struct for user keyword matching.  Move the
> definition instead of forward declaration, as the code change is small
> enough at this stage.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D15

