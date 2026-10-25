Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792947176;
	b=2sR0EI/iebNKsQ40Rc1sKuPMT3vsxioQcJc7xvnjmP+37I2CpKi3h7ouH7rIpUiULAQS
	 TsgXE1SlSk1r2JaiN8ZwGZe/ErHf/AEBh4/iCMO8H2XP0UvrV7MO45LYgjiim4B4sNH0W
	 0qxqWYpi+Iga7tOYrVXbZrTSV9r2wdEd/a/InhEkF09LuN8UNI+/jbUs3Wdky28ns407T
	 Ef2k8zyv5DqVwltlbKYrln6WWQ4ikEgO4vlv3V4WIhbTH6Yy4zJWbgEll45RkZN9OkwNi
	 buFIhnrTFkSKIVGEOreGNJXHGdeXK6o6Bn/V056O68JV/pUZL7pPLStdJ4nDYqvcuTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gxOaHvNVeBUKCZtcMfscbE8LkyZv3MQNs6A2Y5RPC5g=;
	b=OIcOgULQno+Me2+DbhUbIeqdxE9ihUDC3/jB5G28QaDd29W3lctp51VvvKP9bWQ2g7l3
	 M+u4blOofXILNnyRvtevpm+kZ3kuZri5+Zz+9gDdgGaa4ZX4KuLNFSZJEefEgs4npOilX
	 zeq78nHB6LT+9s+4Q0DU/cc85gEqOgjfbMJdit06CnaI4GrYRrxLrs7vdWLOK1WMCUp5I
	 r3okG7GJ7hN5EgucVbDlScKroM0yC234Ltj/skWnHWS+/jSQz/UarYTDPk+R1TQ9wfQUu
	 VKQfXMxHaFxD8LwaIiReH+YnCDuPSvuVbqHPr9f7/rsnF7iMl5yRFG7MgmYVKKT+Y5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2omY06B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909C606A323
	for <damon@lists.linux.dev>; Sun, 25 Oct 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2omY06B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DBF1F01829;
	Sun, 25 Oct 2026 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792947176;
	bh=gxOaHvNVeBUKCZtcMfscbE8LkyZv3MQNs6A2Y5RPC5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q2omY06BXHxy9EXHe8ATL3HCVGqvvOhM1lUhmZVOJb7WlISiEhpW/9vOKnVseiotY
	 kADDZN8HqFZxWx+WcwsoEDECxG7obJvazRKm1dKe+ZUy918GdM+Cyi7gdV2kA345Lf
	 N7dSdwv2cKwErWZ58AMtWeDUTieAtO4GDw3JCLmacnLyJiZ0JbcUuaVn4+etzB9G32
	 Odbxk8mzbb9M2Bt6l8AEC1lR6Vsg0lR6KApP7LUeaK4aW4KMr41I+L3jtgRKbuZkA4
	 vPCRtXS8YV5jgnF9M/UZ9DXUG1ziAAdjPAfEAqaDKv2KVMqL8EU0pw0JRPKsbi5SMo
	 Zu+T6fj6NT3sw==
Message-ID: <sashiko-outbox-184283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm/damon/sysfs-schemes: hold damon_sysfs_lock in
 target_metric_store()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261025164808.152048-2-sj@kernel.org>
References: <20261025164808.152048-1-sj@kernel.org>
 <20261025164808.152048-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 16:52:55 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_add_quota_score() reads damos_sysfs_quota_goal->metric
> twice, once to set damos_quota_goal->metric to the value, and once again
> to set the metric-dependent damos_quota_goal unions based on the value.
>=20
> target_metrics_score() can update damos_sysfs_quota_goal->metric between
> the two reads.  This time-of-check to time-of-use (toctou) race can make
> the union fields incorrectly set.  The incorrect damos_quota_goal will
> be passed to the core layer and make DAMOS incorrectly behave.
>=20
> Users could reproduce the race by writing a new value to the
> target_metric sysfs file while DAMON is starting, or online parameters
> update is ongoing.  The issue will only rarely happen in the real use
> cases.  It requires sysfs write permission.  The race window is short.
> Sane users wouldn't do such writes while DAMON enablement and/or online
> parameters update is ongoing.
> [ ... ]
> [2] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org
>=20
> Fixes: 85fcf0ffc460 ("mm/damon/sysfs-schemes: connect damos_quota_goal ni=
d with core layer")
> Cc: <stable@vger.kernel.org> # 6.16.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025164808.1520=
48-1-sj@kernel.org?part=3D1

