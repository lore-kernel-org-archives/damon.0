Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968913;
	b=xjMmrSpcMe81wBW857hYGkQfLl8XdeGSBSERHJkuzShphB7YzMHh5gy/jp4L+GfdP1dQ
	 R7gZ/fdJ5ZkObvqE7XSHju8YxZf8dJA8xpj5tROB2Qkf0PRRRVNMMvr97UJ9XlXAoICJQ
	 14t6v89WLs3q/B0eGz7VOV4Qt+eJHoXhrMuBhi8G0p028f4d8iG8GTVl9MUM2Eb4jeb4U
	 ZtpFP77BeCxl7JBObuFq0TaV/6T58cg0gKWJkSz5ab2XnWqOb3v+iLllyKhJo7V+9FI4g
	 85DRa2b2ARqYV8zl0Jf9zFbTbWWgNMRtOuWHlIRibQNF7rCC0lyE2DWzBaneB6EaV9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mdG8jbnDUt0Nc/t/nLZ40D+H7MACgosdETsjHw0YEh4=;
	b=GH7tjgjwtWcHW2s2nSzgnWwuNsrx4c7QROvi8XDymvFfMCFxRfQrOnOvN86qiYSWGaC7
	 QljvJltk2u4SPrm5GjjfE9nvPWp0yJQ5FWfAj84SLmX99BgfMEWg2wer1m7UFMcneUxqa
	 eJab3XGnDwwWBILlxY8ExkIJ9uwwwuEHcdgo5zgvGNkar2mDH1yqVypxQGWKCHfVk9jR/
	 F+vExe62xcPe3OywGjcxO23HcbHAskz+hPLMLIhjCTDu5UCak0cROvqRmvdNZwwk+OVi9
	 kmKQoEpVVhpho3vA2M6r3nGlcFXj4fXtxi3dI/HfJGDL9IOQx2aRHyuWzcTHnOVSQkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZY8jlQv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F74606A331
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZY8jlQv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740281F000C5;
	Wed, 18 Nov 2026 02:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968912;
	bh=mdG8jbnDUt0Nc/t/nLZ40D+H7MACgosdETsjHw0YEh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZY8jlQvpcNnFOOX2m5fapU1AaABEromYVbbo4ryax7zt4PXjk6kjp8N0oG2f7bgp
	 LxKj66cUfx0qkeJRKUylhgg83cFu6wRahlVxwPfS9VlIPfBN8dvBssd2aAeP7Yu6Wo
	 RqXmw4l82EecyBvLmB2J7UZ3ASX+9HhNA0ffpPEeWvL9to5HctiSmHO68ULQAC+Eue
	 hz2EHJw3xaeUsEYAON/7EhxWjRZEc3Z3HZS9egiEkKxQSfCRn1sT5aQldXLXbqm2I+
	 yRD/uGabF/W3ID4k+kaN4au9JQ12uUXnnCIBuj+GmITfxWNkWJL/wEwaC67OPNTBmO
	 ePp1zUFp3Y5pg==
Message-ID: <sashiko-outbox-219953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 21/27] mm/damon/sysfs: add user_report support
 for report type input
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-22-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-22-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:28:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Extend the mapping list for data attribute report types and user
> keywords, for the USER_REPORT report type.  Use "user_report" as the
> matching user keyword.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D21

