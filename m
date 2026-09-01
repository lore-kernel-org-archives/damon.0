Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5304CCDC2
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237624; cv=none; b=te0gthUtAdxo/YvJL9QqUQ/Drm7mIBXNTonuku4ZpmlbZUBp5DqREQOxWbnMenrflPjtec2TrxxMozLRl9CskMJ/SWVIHdd2+RBXdWVoHdbkBUk1kh3CX8IZU+8rl6htEpPcEM6CCWRd2Cw5mwKb1JMRldeRZV0Hww/KDAXU7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237624; c=relaxed/simple;
	bh=ImLeoCycJwNXXcEZ8DLpwLeN/t/HXzmGOqxBX80JSz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fiJjE3fCrI3VP3e4aOhQFcNwa4Q+2uc5/r9DH+TAubz8xIKTsu9dl8yl0uWF6AvfOwYvyfqPbmMCeLG2oBwUeKI913d+juW9HgQ/CCyhDMSMpX2w/RrJ8poYoDu3sfT8GdIAhDOpcNq9Zh+icDQLgNNte9HuyFRogaEbKb4pEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMrntTOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMrntTOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C119D1F000E9;
	Tue,  1 Sep 2026 04:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237623;
	bh=PqulEL/H87iQUEpFgkJNycJj/450vOmYjppiM8SPQCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMrntTOVugYns0HpHhRvDJkdygwN3WxCqnPiic4ohnoKMqWX/bQzUWoqJqrxhe0vJ
	 RQy64XkIDa6RIlV7SLZXgYKQLGrTtHLFQlfzxoAdj9PfZfulkGqSayQx9NRbcXFlsP
	 ccTn2/+gCv7xrl7vyR7yc1MQaLVw+H5C24oA74GGAaLhcFTF2i5+izqe2xe9zrOlBg
	 HF8fFB1eJI+6me7SYz2FuTaNjzc4Ll/ck7ru50+r68WZK7EoU35MsXgh6xjJZSQJ2a
	 4gINzLk9llajg1wXnSVlPU0RmYJFNXM3lEBz2WCYVe/rykSQCYdsMhkGhOMblIWt2N
	 9STcrolWUp2aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/17] mm/damon/core: introduce
 damon_operations->prep_probes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-8-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:40:22 +0000
Message-Id: <20260901044022.C119D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_prep needs to be executed by the underlying DAMON operation set.
> Extend the operation set callback list for the execution of damon_prep
> actions.  If the underlying operation set implements the callback, DAMON
> core executes it in the monitoring preparation time.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D7

