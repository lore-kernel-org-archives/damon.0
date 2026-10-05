Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8941BA77
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190794; cv=none; b=D8aytTk426SNTCOUtMQod7486jGN/548hnUdGvhGjdSIEo5KPi1LcPhshaDce9Wj6omQINdS1ojo2/T0ndp/f5Zm7/WzgJ5g1Kb7eSGn9997KKE5mabRCMToi2nYmNNXr+xqIRMQgHP/rAvnGrNDY133hg+SOgRu2ZEQv8/IaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190794; c=relaxed/simple;
	bh=pJutDaFh56jK9J/Vbhukly46LiSGDfBppUeapv1jJnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EeTZQfK7EjwlA5vN0tNGCTkx4W5RlcIbDyxf2i3XsftQaEhqFFz+1/duwkx+XpbkDnoTDU4TozkukSMTzr0+rHkNEXr126wFnbH+HRJKuDv1XhBm+EDDSDGiJmmBpylxStAQ4FyVhfnkY9MM+nEybw469mUu+5+8khkmnbRbfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr32M+oS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr32M+oS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66281F000FF;
	Mon,  5 Oct 2026 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190793;
	bh=G0mmr66Qle3PhiSLOhD2x1eZwBpEpm6mcdqarxsVz8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cr32M+oSAnqIH2QE7hkAuZHP0speS20wJms4S83ZV39H6Px7nZ6ZEyY/Lx9kW1ke9
	 jkL4xPGZSre7cfGvzC/zAQX9kPaOphQHi3tcQkAN63kPSFtlFOzt0GOeehxDY9coLG
	 rPhtWiZ45KLmD6BH430ebhCy6rMrQV0KK293UF0OozORJV73Rs5o5cKnWdWHxZdT48
	 XAxehRUuQL5xpvCsC9cnZfekYOZDrckECvEj938p1FMNaagitUPOZ3zqapXmZ1rdpy
	 JTAvRK8VIjesNr9pJTGTHUSBAXm0eHc5FwNZrnu1MqtsdZUI0p/d4GamMduLTSAuKq
	 UeIEKv/3aYTAQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 9/9] mm/damon/core: apply probe_hits_wsum filters
 to node_eligible_mem_bp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-9-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
 <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-9-b03452e137f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:59:52 +0000
Message-Id: <20261005085952.E66281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> node_eligible_mem_bp is the share of a scheme's eligible memory that is
> on a given node, and memory is eligible when its region matches the
> scheme's access pattern.  In data attributes-only monitoring nr_accesses
> is not updated, so the access pattern cannot tell which regions the
> scheme is for; its probe_hits_wsum filters do.
>=20
> Count a region as eligible only if it also passes the scheme's
> probe_hits_wsum filters, decided as the scheme's core filters are: the
> first matching one decides, and if none matches, the region passes
> unless the last of them is an allow filter and the scheme has no ops
> filters.  The address and target filters stay out of the metric, as
> before, since they scope where the scheme acts rather than which memory
> it is for.
>=20
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-damon-perf=
-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com?part=3D9

