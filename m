Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968847;
	b=E/PeT5uR4ZZd7PiJnTtrIyn5nBFcH1AQJPQ8j6/wHdNgKj1jfw+RJsldGs5Jc6sZaefe
	 233NdKyJ25fjQRxWgBRtH9wJ0qhR99r530/ESiRgPC865kxgwD8kJIsbFqT1PO6nhKgrd
	 H//g7U2ZNKqcrCaSme14gh2tzvcJ8vWVuEaHPpGx2Tjk82VkWwRm4/vH7s0lhQCnXeOyi
	 llCU7nWBV9y7Hwq2Lfk76jgRoERurUCPtctORDxdaFJmwxlveOHLvQIIOXZAn+bguCQg+
	 n3+6KGAjfv08AAX/YDzLuhpdULiiOYQeO+2pUiJOcO77MRjwWLYlYZYggQAeQy0xn2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968847;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KqhB8KA4NH7a+JixV//jWxOdoIPXEqL2mcdFv97bzSc=;
	b=QcHfftt5m+i6QTXOo8im9KcEI2tY6RQ/c+SayO8ownOUK7kut/9k0Jp3z3BbA5Q0ZOQb
	 6wX/Xj29WbpueufS/ix0hyumT1KSssYDRX8KGTAmk+zSjaArh8/3xFYlFy5nlKV4mFgwn
	 HkupTTGawrzShWOuF377G1iSXc02Jii1UeTJsurVnGlfMqqWjo1aaJ3IWWpe92SuxRteA
	 5E2JaBj9PY7cSOTzxN8Kq5Nk6780Ws42gPd2WFisB7KfYTqEPAR2KhbrY2hpIPuFmvKl6
	 0qRFNjg34TlD/P/AqTO2oe+u5uPDKnJTpYOB0PJalbEs83UEgRE5m0g/qoxl1vKP72Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbWgpSg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A26606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbWgpSg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0711F000C4;
	Wed, 18 Nov 2026 02:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968847;
	bh=KqhB8KA4NH7a+JixV//jWxOdoIPXEqL2mcdFv97bzSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jbWgpSg1uoUphqW5MWfghc4bHTyG3XOIkXLtpRe+wySy1DEiZlS3iY9Ap8VUNQ68p
	 hkcAE2Bt/uL+OVdMU88mVif1LUAvVs6pzHKJsjtd3gRJGRYDbJWRXBgwHWVoao56dg
	 yJZQnTb9L/SqpGas91q4d7FHI9A4RNVdwWTBUAFSDeMO/CciDb84VGZTzTmZfYFtkc
	 dni3yJAXP4WrnmGDBUmGWtNEJauiSl2OFSBhivQXEin3d67UdPavm2vqMFZ7HmWZ0S
	 S81D8Sls4pxf4rCKzrXkfL1ldpycEcm2/y6w7lcRtJL3AbE7rd8pdn15e7KNcAxWsl
	 IKuZ0DJ+PdNKQ==
Message-ID: <sashiko-outbox-219948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/27] mm/damon/sysfs: add reports/producers/
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-6-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:27:26 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Add a new sysfs directory, producers/, under reports/ directory.  It is
> a placeholder for files that will be used for controlling DAMON report
> producers.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D5

